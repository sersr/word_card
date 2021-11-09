import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:isolate';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:file/local.dart';
import 'package:hive/hive.dart';
import 'package:nop_db/extensions/future_or_ext.dart';
import 'package:path/path.dart';
import 'package:useful_tools/common.dart';

import '../api/api.dart';
import '../data/data.dart';
import '../database/dict_database.dart';
import 'event_base.dart';

Future<void> beginHive(String fileName, Future<void> Function(Box box) run) {
  return EventQueue.runTaskOnQueue(
      [_beginHive, fileName], () => _beginHive(fileName, run));
}

Future<void> _beginHive(
    String fileName, Future<void> Function(Box box) run) async {
  try {
    final box = await Hive.openBox('dictHive');
    await run(box);
    await box.close();
  } on HiveError catch (e) {
    Log.e('在当前隔离中可能没有初始化\n`Hive.init(path);`', onlyDebug: false);
    Log.e(e, onlyDebug: false);
  }
}

/// 实现类
class DictEventIsolate extends DictEventResolveMain with DatabaseMixin {
  DictEventIsolate({required this.path});
  @override
  final String path;
  late Dio dio;
  // 执行初始化任务
  Future<void> init() async {
    Hive.init(path);
    dio = Dio(BaseOptions(
        connectTimeout: 30000, sendTimeout: 30000, receiveTimeout: 30000));
    return initDb();
  }

  Future<void> beginDict(Future<void> Function(Box box) run) {
    return beginHive('dictHive', run);
  }

  @override
  FutureOr<int?> downloadDict(String id, String url) async {
    Log.i('start');
    if (await getWordsState(id)) return null;

    // final streamController = StreamController<int>();
    // yield* streamController.stream;
    try {
      final respone = await dio.get<List<int>>(url,
          options: Options(responseType: ResponseType.bytes),
          onReceiveProgress: (count, total) {
        if (total == 0) return;
        // yield math.min(progress.toInt(), 100);
      });

      final zipData = respone.data;
      if (zipData != null) {
        final zip = ZipDecoder().decodeBytes(zipData);
        for (var file in zip) {
          try {
            final utf8Data = utf8.decode(file.content);
            final divDatas = utf8Data.split('\n');
            final listData = [];
            for (var d in divDatas) {
              if (d.isNotEmpty) {
                // final data = jsonDecode(d);
                listData.add(d);
              }
            }
            if (listData.isNotEmpty) {
              await beginDict((box) async {
                Log.i('data');
                if (box.get(id) == null) {
                  return box.put(id, listData);
                }
                Log.e('box $id 已经有数据了！', onlyDebug: false);
              });
            }
          } catch (e) {
            Log.e(e, onlyDebug: false);
          }
        }
      }
    } catch (e) {
      Log.e(e);
    } finally {
      Log.i('close');
      // if (!streamController.isPaused) {
      // streamController.close();
      // }
    }
  }

  @override
  FutureOr<BookCategoryDataNormalBooks?> getDictLists() async {
    try {
      final response = await dio.get<String>(Api.bookListsUrl());
      final data = response.data;
      if (data != null) {
        final normalBooks =
            BookCategory.fromJson(jsonDecode(data)).data?.normalBooks ??
                const BookCategoryDataNormalBooks();

        return normalBooks;
      }
    } catch (e) {
      Log.e(e, onlyDebug: false);
    }
  }

  @override
  FutureOr<List<BookInfoDataNormalBooksInfo>?> getDictInfoLists(
      List<String> body) async {
    try {
      final buffer = StringBuffer();
      buffer
        ..write('["')
        ..write(body.join('","'))
        ..write('"]');
      final response =
          await dio.post<String>(Api.bookWordsDataUrl(), queryParameters: {
        'bookIds': buffer,
        'reciteType': 'normal',
      });
      final data = response.data;
      if (data != null) {
        final normalBooks =
            BookInfo.fromJson(jsonDecode(data)).data?.normalBooksInfo ??
                const [];

        return normalBooks;
      }
    } catch (e) {
      Log.e(e, onlyDebug: false);
    }
  }

  @override
  Stream<List<Words>> getWordsData(String id) {
    // final List<Words> wordsData = [];
    final stream = StreamController<List<Words>>.broadcast(sync: true);
    Timer.run(() async {
      // start
      // stream.add(const Words());
      await beginDict((box) async {
        final data = box.get(id);
        // await box.delete(id);
        if (data is List) {
          Log.i('item is Map');
          final cache = <Words>[];
          for (var item in data) {
            if (item is String) {
              final map = jsonDecode(item);
              final word = Words.fromJson(map);
              cache.add(word);

              // wordsData.add(word);
            }
            if (cache.length >= 40) {
              final _cache = List.of(cache);
              cache.clear();
              stream.add(_cache);
            }
          }
          if (cache.isNotEmpty) {
            final _cache = List.of(cache);
            cache.clear();
            stream.add(_cache);
          }
          return;
        }
      });
      Log.i(' close.${stream.hasListener}');
      await stream.close();
      Log.i(' closeeee.');
    });
    return stream.stream;
  }

  @override
  Future<bool> getWordsState(String id) async {
    var hasData = false;
    await beginDict((box) async {
      hasData = box.get(id) != null;
    });
    return hasData;
  }

  @override
  Future<Uint8List?> getImageSource(String url) async {
    try {
      final response = await dio.get<List<int>>(url,
          options: Options(responseType: ResponseType.bytes));
      final responseData = response.data;
      if (responseData != null) {
        return Uint8List.fromList(responseData);
      }
    } catch (e) {
      Log.e(e);
    }
  }

  @override
  getImageSourceDynamic(String url) {
    return getImageSource(url).then((value) {
      if (value != null) {
        return TransferableTypedData.fromList([value]);
      }
    });
  }
}

mixin DatabaseMixin on DictEvent {
  String get path;
  final name = 'dict_words.nopdb';

  late final db = DictDatabase(join(path, name));
  FutureOr<void> initDb() {
    const fs = LocalFileSystem();
    final dir = fs.currentDirectory.childDirectory(path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    return db.initDb();
  }

  @override
  FutureOr<List<DictTable>> getMainLists() {
    return db.dictTable.query.all.where.show
        .equalTo(true)
        .back
        .whereEnd
        .goToTable;
  }

  @override
  Stream<List<DictTable>> watchDictLists() {
    return db.dictTable.query.all.where.show
        .equalTo(true)
        .back
        .whereEnd
        .watchToTable;
  }

  @override
  FutureOr<int?> addDict(DictTable dict) {
    assert(dict.dictId != null);
    final queryCount = db.dictTable.query
      ..select.count.all
      ..where.dictId.equalTo(dict.dictId!);
    return queryCount.go.then((v) {
      var count = 0;
      try {
        final first = v.first.values.first;
        if (first is int) {
          count = first;
        }
      } catch (e) {
        Log.w(e);
      }
      if (count > 0) return -1;
      return db.dictTable.insert.insertTable(dict).go;
    });
  }

  @override
  FutureOr<int?> updateDict(String dictId, DictTable dict) {
    final update = db.dictTable.update..where.dictId.equalTo(dictId);
    db.dictTable.updateDictTable(update, dict);
    return update.go;
  }
}
