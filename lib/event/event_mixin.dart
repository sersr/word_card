import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:isolate';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:file/local.dart';
import 'package:hive/hive.dart';
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
  } catch (e) {
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
  Stream<int> downloadDict(String id, String url) async* {
    if (await getWordsState(id)) return;

    final streamController = StreamController<int>();
    yield* streamController.stream;
    try {
      final respone =
          await dio.get<List<int>>(url, onReceiveProgress: (count, total) {
        if (total == 0) return;
        final progress = count / total * 100;
        streamController.add(math.min(progress.toInt(), 100));
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
              final data = jsonDecode(d);
              listData.add(data);
            }
            if (listData.isNotEmpty) {
              await beginDict((box) async {
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
      // if (!streamController.isPaused) {
      streamController.close();
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
  FutureOr<List<Words>?> getWordsData(String id) async {
    final List<Words> wordsData = [];
    await beginDict((box) async {
      final data = box.get(id);
      if (data is List<Map<String, Object?>>) {
        for (var item in data) {
          final word = Words.fromJson(item);
          wordsData.add(word);
        }
        return;
      }
      Log.i('this data: $data');
    });
    return wordsData;
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
      final response = await dio.get<List<int>>(url,options: Options(responseType: ResponseType.bytes));
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
}
