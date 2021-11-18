// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dict_database.dart';

// **************************************************************************
// Generator: GenNopGeneratorForAnnotation
// **************************************************************************

// ignore_for_file: curly_braces_in_flow_control_structures
abstract class _GenDictDatabase extends $Database {
  late final _tables = <DatabaseTable>[dictTable, wordTable];

  @override
  List<DatabaseTable> get tables => _tables;

  late final dictTable = GenDictTable(this);
  late final wordTable = GenWordTable(this);
}

Map<String, dynamic> _DictTable_toJson(DictTable table) {
  return {
    'id': table.id,
    'dictId': table.dictId,
    'wordIndex': table.wordIndex,
    'show': table.show,
    'sortKey': table.sortKey,
    'name': table.name,
    'createTime': table.createTime,
    'dataIndex': table.dataIndex
  };
}

class GenDictTable extends DatabaseTable<DictTable, GenDictTable> {
  GenDictTable($Database db) : super(db);

  @override
  final table = 'DictTable';
  final id = 'id';
  final dictId = 'dictId';
  final wordIndex = 'wordIndex';
  final show = 'show';
  final sortKey = 'sortKey';
  final name = 'name';
  final createTime = 'createTime';
  final dataIndex = 'dataIndex';

  void updateDictTable(
      UpdateStatement<DictTable, GenDictTable> update, DictTable dictTable) {
    if (dictTable.id != null) update.id.set(dictTable.id);

    if (dictTable.dictId != null) update.dictId.set(dictTable.dictId);

    if (dictTable.wordIndex != null) update.wordIndex.set(dictTable.wordIndex);

    if (dictTable.show != null) update.show.set(dictTable.show);

    if (dictTable.sortKey != null) update.sortKey.set(dictTable.sortKey);

    if (dictTable.name != null) update.name.set(dictTable.name);

    if (dictTable.createTime != null)
      update.createTime.set(dictTable.createTime);

    if (dictTable.dataIndex != null) update.dataIndex.set(dictTable.dataIndex);
  }

  @override
  String createTable() {
    return 'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $dictId TEXT, '
        '$wordIndex INTEGER, $show INTEGER, $sortKey INTEGER, $name TEXT, '
        '$createTime INTEGER, $dataIndex BLOB)';
  }

  static DictTable mapToTable(Map<String, dynamic> map) => DictTable(
      id: map['id'] as int?,
      dictId: map['dictId'] as String?,
      wordIndex: map['wordIndex'] as int?,
      show: Table.intToBool(map['show'] as int?),
      sortKey: map['sortKey'] as int?,
      name: map['name'] as String?,
      createTime: map['createTime'] as int?,
      dataIndex: map['dataIndex'] as List<int>?);

  @override
  List<DictTable> toTable(Iterable<Map<String, Object?>> query) =>
      query.map((e) => mapToTable(e)).toList();
}

extension ItemExtensionDictTable<T extends ItemExtension<GenDictTable>> on T {
  T get id => item(table.id) as T;

  T get dictId => item(table.dictId) as T;

  T get wordIndex => item(table.wordIndex) as T;

  T get show => item(table.show) as T;

  T get sortKey => item(table.sortKey) as T;

  T get name => item(table.name) as T;

  T get createTime => item(table.createTime) as T;

  T get dataIndex => item(table.dataIndex) as T;

  T get genDictTable_id => id;

  T get genDictTable_dictId => dictId;

  T get genDictTable_wordIndex => wordIndex;

  T get genDictTable_show => show;

  T get genDictTable_sortKey => sortKey;

  T get genDictTable_name => name;

  T get genDictTable_createTime => createTime;

  T get genDictTable_dataIndex => dataIndex;
}

extension JoinItemDictTable<J extends JoinItem<GenDictTable>> on J {
  J get genDictTable_id => joinItem(joinTable.id) as J;

  J get genDictTable_dictId => joinItem(joinTable.dictId) as J;

  J get genDictTable_wordIndex => joinItem(joinTable.wordIndex) as J;

  J get genDictTable_show => joinItem(joinTable.show) as J;

  J get genDictTable_sortKey => joinItem(joinTable.sortKey) as J;

  J get genDictTable_name => joinItem(joinTable.name) as J;

  J get genDictTable_createTime => joinItem(joinTable.createTime) as J;

  J get genDictTable_dataIndex => joinItem(joinTable.dataIndex) as J;
}

Map<String, dynamic> _WordTable_toJson(WordTable table) {
  return {
    'id': table.id,
    'wordRank': table.wordRank,
    'headWord': table.headWord,
    'content': _WordsContentWordToMap(table.content),
    'bookId': table.bookId
  };
}

class GenWordTable extends DatabaseTable<WordTable, GenWordTable> {
  GenWordTable($Database db) : super(db);

  @override
  final table = 'WordTable';
  final id = 'id';
  final wordRank = 'wordRank';
  final headWord = 'headWord';
  final content = 'content';
  final bookId = 'bookId';

  void updateWordTable(
      UpdateStatement<WordTable, GenWordTable> update, WordTable wordTable) {
    if (wordTable.id != null) update.id.set(wordTable.id);

    if (wordTable.wordRank != null) update.wordRank.set(wordTable.wordRank);

    if (wordTable.headWord != null) update.headWord.set(wordTable.headWord);

    if (wordTable.content != null) update.content.set(wordTable.content);

    if (wordTable.bookId != null) update.bookId.set(wordTable.bookId);
  }

  @override
  String createTable() {
    return 'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $wordRank INTEGER, '
        '$headWord TEXT, $content TEXT, $bookId TEXT)';
  }

  static WordTable mapToTable(Map<String, dynamic> map) => WordTable(
      id: map['id'] as int?,
      wordRank: map['wordRank'] as int?,
      headWord: map['headWord'] as String?,
      content: _WordsContentWordToTable(map['content']),
      bookId: map['bookId'] as String?);

  @override
  List<WordTable> toTable(Iterable<Map<String, Object?>> query) =>
      query.map((e) => mapToTable(e)).toList();
}

extension ItemExtensionWordTable<T extends ItemExtension<GenWordTable>> on T {
  T get id => item(table.id) as T;

  T get wordRank => item(table.wordRank) as T;

  T get headWord => item(table.headWord) as T;

  T get content => item(table.content) as T;

  T get bookId => item(table.bookId) as T;

  T get genWordTable_id => id;

  T get genWordTable_wordRank => wordRank;

  T get genWordTable_headWord => headWord;

  T get genWordTable_content => content;

  T get genWordTable_bookId => bookId;
}

extension JoinItemWordTable<J extends JoinItem<GenWordTable>> on J {
  J get genWordTable_id => joinItem(joinTable.id) as J;

  J get genWordTable_wordRank => joinItem(joinTable.wordRank) as J;

  J get genWordTable_headWord => joinItem(joinTable.headWord) as J;

  J get genWordTable_content => joinItem(joinTable.content) as J;

  J get genWordTable_bookId => joinItem(joinTable.bookId) as J;
}
