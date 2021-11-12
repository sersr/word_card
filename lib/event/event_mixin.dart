import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

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
import '../tools/hive_cache.dart';
import 'event_base.dart';

/// 实现类
class DictEventIsolate extends DictEventResolveMain with DatabaseMixin {
  DictEventIsolate({required this.path});
  @override
  final String path;
  late Dio dio;
  late String voicePath;
  // 执行初始化任务
  Future<void> init() async {
    Hive.init(path);
    voicePath = join(path, 'voice');
    dio = Dio(BaseOptions(
        connectTimeout: 30000, sendTimeout: 30000, receiveTimeout: 30000));
    // openDict(true);
    return initDb();
  }

  /// TODO: 为了方便检索单词，存储方式Hive修改为sqlite
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
  Stream<List<WordTable>> getWordsData(String id) {
    final stream = StreamController<List<WordTable>>();
    Timer.run(() async {
      final query = db.wordTable.query.all..where.bookId.equalTo(id);
      final data = await query.goToTable;
      final list = <WordTable>[];
      for (var item in data) {
        if (list.length > 30) {
          stream.add(List.of(list));
          list.clear();
          await releaseUI;
        }
        list.add(item);
      }
      if (list.isNotEmpty) {
        stream.add(List.of(list));
        list.clear();
      }
      stream.close();
      Log.i('done');
    });
    return stream.stream;
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

  FutureOr<List<WordTable>> _getWord(String headWord) {
    final query = db.wordTable.query.all
      ..where.headWord.equalTo(headWord).limit.withValue(1);
    return query.goToTable;
  }

  @override
  FutureOr<WordTable?> getWord(String headWord) async {
    var words = await _getWord(headWord);
    Future<void> _dd(String headWord) async {
      Log.i('actual: $headWord', onlyDebug: false);
      words = await _getWord(headWord);
    }

    if (words.isEmpty) {
      await _dd(headWord);
    }
    if (words.isEmpty) {
      headWord = headWord.toLowerCase();
      await _dd(headWord);

      /// TODO: 有没有词形还原的工具？
      if (words.isEmpty) {
        var word = headWord.replaceFirst(RegExp('(d|ing|s)\$'), '');

        await _dd(word);

        if (words.isEmpty) {
          final old = word;
          word = headWord.replaceFirst(RegExp('(ed|es)\$'), '');

          await _dd(word);
          // if (words.isEmpty) {
            if (words.isEmpty) {
              final l = word.length;
              if (l >= 2 && word[l - 2] == word[l - 1]) {
                final old = word;
                word = word.substring(0, l - 1);
                await _dd(word);
                word = old;
              }
              word = '${old}e';
              await _dd(word);
            }
          // }
        }
      }
    }
    if (words.isNotEmpty) {
      Log.i(words.last.content?.wordId);
    }
    return words.isEmpty ? null : words.last;
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
