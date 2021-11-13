import 'dart:async';
import 'dart:convert';

import 'package:nop_db/database/nop.dart';
import 'package:nop_db/extensions/future_or_ext.dart';
import 'package:nop_db_sqlite/sqlite.dart';
import 'package:nop_annotations/nop_annotations.dart';
import 'package:nop_db/nop_db.dart';
import 'package:useful_tools/common.dart';
import 'package:word_card/data/data.dart';
part 'dict_database.g.dart';

class DictTable extends Table implements Comparable<DictTable> {
  DictTable({
    this.dictId,
    this.id,
    this.show,
    this.sortKey,
    this.wordIndex,
    this.name,
    this.createTime,
    this.dataIndex,
  });
  @NopItem(primaryKey: true)
  int? id;
  String? dictId;
  int? wordIndex;
  bool? show;
  int? sortKey;
  String? name;
  int? createTime;
  List<int>? dataIndex;

  @override
  Map<String, dynamic> toJson() {
    return _DictTable_toJson(this);
  }

  @override
  int compareTo(DictTable other) {
    final otherKey = other.sortKey;
    if (sortKey == null || otherKey == null) return 0;
    return otherKey - sortKey!;
  }
}

String? _WordsContentWordToMap(WordsContentWord? data) {
  if (data != null) {
    return jsonEncode(data.toJson());
  }
}

WordsContentWord? _WordsContentWordToTable(String? text) {
  if (text != null) {
    final data = jsonDecode(text);
    return WordsContentWord.fromJson(data);
  }
}

WordsContentWord? toTable(String? text) {
  if (text != null) {
    final data = jsonDecode(text);
    return WordsContentWord.fromJson(data);
  }
}

/// [bookId]、[headWord] 做为唯一码
class WordTable extends Table {
  WordTable({
    this.id,
    this.wordRank,
    this.headWord,
    this.content,
    this.bookId,
  });

  @NopItem(primaryKey: true)
  int? id;
  int? wordRank;
  String? headWord;
  @NopItem(type: String)
  WordsContentWord? content;
  String? bookId;

  @override
  Map<String, dynamic> toJson() {
    return _WordTable_toJson(this);
  }
}

@Nop(tables: [DictTable, WordTable])
class DictDatabase extends _GenDictDatabase {
  DictDatabase(this.path);
  final String path;
  final int version = 2;
  final String index = 'word_index';

  FutureOr<void> initDb() {
    return NopDatabaseImpl.open(path,
            version: version, onCreate: onCreate, onUpgrade: onUpgrade)
        .then(setDb)
        .whenComplete(() {
      return db.rawQuery(
          'select count(*) From sqlite_master where type = ? and name = ?',
          ['index', index]).then((value) {
        Log.i(value, onlyDebug: false);
        if (value.first.values.first == 0) {
          // db.execute('drop INDEX $index');
          // db.execute('drop INDEX $indexBookid');
          db.execute(
              'CREATE INDEX $index on ${wordTable.table}(${wordTable.headWord})');
          // db.execute(
          //     'CREATE INDEX $indexBookid on ${wordTable.table}( ${wordTable.bookId})');
        }
      });
    });
  }

  @override
  FutureOr<void> onUpgrade(
      NopDatabase db, int oldVersion, int newVersion) async {
    if (newVersion == 2) {
      await db.execute(wordTable.createTable());
    }
  }
}
