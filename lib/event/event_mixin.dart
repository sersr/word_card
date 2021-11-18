import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:file/local.dart';
import 'package:hive/hive.dart';

import 'package:nop_db/nop_db.dart';
import 'package:utils/future_or_ext.dart';
import 'package:path/path.dart';
import 'package:useful_tools/useful_tools.dart';

import '../api/api.dart';
import '../data/data.dart';
import '../database/dict_database.dart';
import '../tools/hive_cache.dart';
import 'event_base.dart';
import 'isolate_transfer_type.dart';

/// 实现类
class DictEventIsolate extends DictEventResolveMain
    with DatabaseMixin, NetMixin {
  DictEventIsolate({required this.path, this.sp});
  @override
  final String path;

  FutureOr<void> init() {
    initNet();
    return initDb();
  }

  @override
  FutureOr<bool> onClose() async {
    closeNet();
    await closeDb();
    return true;
  }

  /// [SendEventMixin] 要使用的 SendPort
  @override
  final SendPort? sp;

  @override
  Stream<TransferType<List<WordTable>>> getWordsDataDynamic(String id) {
    return _getWordsData(id);
  }
}

mixin NetMixin on DictEvent, DatabaseMixin, DictEventDynamic {
  late Dio dio;
  late String voicePath;

  // 执行初始化任务
  void initNet() {
    Hive.init(path);
    voicePath = join(path, 'voice');
    dio = Dio(BaseOptions(
        connectTimeout: 30000, sendTimeout: 30000, receiveTimeout: 30000));
  }

  void closeNet() {
    dio.close();
    Hive.close();
  }

  @override
  FutureOr<int?> downloadDict(String id, String url) async {
    if (await getWordsState(id)) return null;

    try {
      final respone = await dio.get<List<int>>(url,
          options: Options(responseType: ResponseType.bytes));

      final zipData = respone.data;
      if (zipData != null) {
        final zip = ZipDecoder().decodeBytes(zipData);
        for (var file in zip) {
          try {
            final utf8Data = utf8.decode(file.content);
            final divDatas = utf8Data.split('\n');
            await _addAllDictWord(divDatas, id);
          } catch (e) {
            Log.e(e, onlyDebug: false);
          }
        }
      }
    } catch (e) {
      Log.e(e);
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

        return normalBooks.whereType<BookInfoDataNormalBooksInfo>().toList();
      }
    } catch (e) {
      Log.e(e, onlyDebug: false);
    }
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

  @override
  Future<void> openVoiceHive(bool open) {
    return _openVoiceHive((cacheBox) {
      cacheBox.ticked = !open;
      Log.i('voice: $open', onlyDebug: false);
    });
  }

  Future<void> _openVoiceHive(
      FutureOr<void> Function(CacheHive cacheHive) run) {
    return CacheHive.beginHive('word_voice', run);
  }

  @override
  FutureOr<String?> getVoicePath(String query) async {
    String? filePath;
    const fs = LocalFileSystem();
    await _openVoiceHive((cacheBox) async {
      final box = cacheBox.use();
      final key = base64Encode(utf8.encode(query));

      final oldPath = box.get(key);
      if (oldPath != null) {
        final f = fs.currentDirectory.childFile(oldPath);
        if (await f.exists()) {
          filePath = oldPath;
          return;
        } else {
          await box.delete(key);
        }
      }

      final url = Api.wordVoiceUrl(query);

      try {
        final response = await dio.get<List<int>>(url,
            options: Options(responseType: ResponseType.bytes));
        final data = response.data;
        if (data?.isNotEmpty == true) {
          final name = join(voicePath, 'word_voice', key);
          final file = fs.currentDirectory.childFile(name);
          if (!file.existsSync()) {
            file.createSync(recursive: true);
          } else {
            Log.e('exists..');
          }
          file.writeAsBytesSync(data!);
          await box.put(key, name);
          filePath = name;
        }
      } catch (e) {
        Log.e(e);
      }
    });
    return filePath;
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

  FutureOr<void> closeDb() {
    return db.dispose();
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
      ..select.count.all.push
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

  Stream<WordTableTransferType> _getWordsData(String id) {
    final stream = StreamController<WordTableTransferType>();
    Timer.run(() async {
      final stop = Stopwatch()..start();
      try {
        final query = db.wordTable.query
          // ..index.notIndexed
          ..select.all
          ..where.bookId.equalTo(id);
        Log.i(query);
        final prepare = query.prepare;
        final data = await prepare.go;
        await prepare.dispose();

        final max = data.length;
        for (var i = 0; i < max;) {
          final end = math.min(i + 100, max);
          stream.add(WordTableTransferType(data.sublist(i, end)));
          i = end;
        }
      }catch(e){
        Log.e(e);
      } finally {
        stream.close();
        Log.i('done: ${stop.elapsedMicroseconds / 1000} ms', onlyDebug: false);
      }
    });
    return stream.stream;
  }

  // @override
  // Stream<List<WordTable>> getWordsData(String id) {
  //   final stream = StreamController<List<WordTable>>();
  //   Timer.run(() async {
  //     final stop = Stopwatch()..start();
  //     try {
  //       final query = db.wordTable.query
  //         ..index.notIndexed
  //         ..select.all
  //         ..where.bookId.equalTo(id);
  //       Log.i(query);
  //       final prepare = query.prepare;
  //       final data = await prepare.goToTable;
  //       await prepare.dispose();

  //       final max = data.length;
  //       for (var i = 0; i < max;) {
  //         final end = math.min(i + 100, max);
  //         stream.add(data.sublist(i, end));
  //         i = end;
  //       }
  //     } finally {
  //       stream.close();
  //       Log.i('done: ${stop.elapsedMicroseconds / 1000} ms', onlyDebug: false);
  //     }
  //   });
  //   return stream.stream;
  // }

  FutureOr<List<WordTable>> _getWord(String headWord) {
    final query = db.wordTable.query.all
      ..index.by(db.index)
      ..where.headWord.equalTo(headWord).limit.withValue(1);
    Log.i(query.args);
    return query.goToTable;
  }

  /// 建立 索引 可以将耗时降低到 10ms 左右
  /// TODO: 有没有词形还原的工具？
  @override
  FutureOr<WordTable?> getWord(String headWord) async {
    List<WordTable> words = const [];
    final stop = Stopwatch()..start();

    final queryList = <String>{};
    queryList.add(headWord);
    final _headWord = headWord.toLowerCase();

    queryList.add(_headWord);
    void add(String headWord) {
      var word = headWord.replaceFirst(RegExp('(d|ing|s)\$'), '');

      final l = word.length;
      if (l >= 2 && word[l - 2] == word[l - 1]) {
        queryList.add(word.substring(0, l - 1));
      }

      queryList.add(word);

      const list = ['e', 'y'];
      for (var item in list) {
        word = '$word$item';
        queryList.add(word);
      }
      word = headWord.replaceFirst(RegExp('(ed|es|ies)\$'), '');
      queryList.add(word);
    }

    add(headWord);
    if (headWord != _headWord) {
      add(_headWord);
    }

    var count = 0;
    for (final item in queryList) {
      count++;
      words = await _getWord(item);
      if (words.isNotEmpty) break;
    }
    Log.i('use: $count ${stop.elapsedMicroseconds / 1000} ms',
        onlyDebug: false);
    return words.isEmpty ? null : words.last;
  }

  FutureOr<void> _addAllDictWord(List<String> divDatas, id) async {
    final stop = Stopwatch()..start();
    final all = await queryCountDict(id);
    final allMap = all.map((e) => e.bookId);
    final isEmpty = allMap.isEmpty;
    Log.i('start:$isEmpty ${stop.elapsedMicroseconds / 1000} ms',
        onlyDebug: false);
    return db.transaction(() async {
      for (var d in divDatas) {
        if (d.isNotEmpty) {
          try {
            final data = jsonDecode(d);
            final word = Words.fromJson(data);
            final rank = word.wordRank;
            final headWord = word.headWord;
            final bookId = word.bookId;
            final content = word.content?.word;
            if (rank != null &&
                headWord != null &&
                bookId != null &&
                content != null) {
              if (isEmpty || !allMap.contains(headWord)) {
                await _insertWrod(rank, headWord, content, bookId);
              } else {
                await _addDictWord(rank, headWord, content, bookId);
              }
            }
          } catch (e) {
            Log.w(e);
          }
        }
      }
      Log.i('use: ${stop.elapsedMicroseconds / 1000} ms', onlyDebug: false);
    });
  }

  FutureOr<int> _addDictWord(
      int rank, String headWord, WordsContentWord content, String bookId) {
    final query = db.wordTable.query
      ..select.count.all.push
      ..where.headWord.equalTo(headWord).and.bookId.equalTo(bookId);
    return query.go.then((value) {
      final first = value.first.values.first as int? ?? 0;
      if (first > 0) {
        if (first > 1) {
          Log.e('update element: $first');
        }
        final update = db.wordTable.update
          ..content.set(content).wordRank.set(rank)
          ..where.headWord.equalTo(headWord).and.bookId.equalTo(bookId);
        return update.go;
      }
      return _insertWrod(rank, headWord, content, bookId);
    });
  }

  @override
  Future<bool> getWordsState(String id) async {
    final query = db.wordTable.query
      ..select.count.all.push
      ..where.bookId.equalTo(id);
    return query.go.then((value) {
      return value.first.values.first != 0;
    });
  }

  FutureOr<List<WordTable>> queryCountDict(String bookId) {
    final query = db.wordTable.query
      ..headWord
      ..where.bookId.equalTo(bookId);
    return query.goToTable;
  }

  FutureOr<int> _insertWrod(
      int rank, String headWord, WordsContentWord content, String bookId) {
    final insert = db.wordTable.insert.insertTable(WordTable(
        wordRank: rank, headWord: headWord, content: content, bookId: bookId));
    return insert.go;
  }
}
