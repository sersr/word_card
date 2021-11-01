// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dict_database.dart';

// **************************************************************************
// Generator: GenNopGeneratorForAnnotation
// **************************************************************************

abstract class _GenDictDatabase extends $Database {
  late final _tables = <DatabaseTable>[dictTable];

  @override
  List<DatabaseTable> get tables => _tables;

  late final dictTable = _GenDictTable(this);
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

class _GenDictTable extends DatabaseTable<DictTable, _GenDictTable> {
  _GenDictTable($Database db) : super(db);

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
      UpdateStatement<DictTable, _GenDictTable> update, DictTable dictTable) {
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

  DictTable _toTable(Map<String, dynamic> map) => DictTable(
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
      query.map((e) => _toTable(e)).toList();
}

extension ItemExtensionDictTable<T extends ItemExtension<_GenDictTable>> on T {
  T get id => item(table.id) as T;

  T get dictId => item(table.dictId) as T;

  T get wordIndex => item(table.wordIndex) as T;

  T get show => item(table.show) as T;

  T get sortKey => item(table.sortKey) as T;

  T get name => item(table.name) as T;

  T get createTime => item(table.createTime) as T;

  T get dataIndex => item(table.dataIndex) as T;

  T get dictTable_id => id;

  T get dictTable_dictId => dictId;

  T get dictTable_wordIndex => wordIndex;

  T get dictTable_show => show;

  T get dictTable_sortKey => sortKey;

  T get dictTable_name => name;

  T get dictTable_createTime => createTime;

  T get dictTable_dataIndex => dataIndex;
}

extension JoinItemDictTable<J extends JoinItem<_GenDictTable>> on J {
  J get dictTable_id => joinItem(joinTable.id) as J;

  J get dictTable_dictId => joinItem(joinTable.dictId) as J;

  J get dictTable_wordIndex => joinItem(joinTable.wordIndex) as J;

  J get dictTable_show => joinItem(joinTable.show) as J;

  J get dictTable_sortKey => joinItem(joinTable.sortKey) as J;

  J get dictTable_name => joinItem(joinTable.name) as J;

  J get dictTable_createTime => joinItem(joinTable.createTime) as J;

  J get dictTable_dataIndex => joinItem(joinTable.dataIndex) as J;
}
