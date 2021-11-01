import 'dart:async';

import 'package:nop_db/extensions/future_or_ext.dart';
import 'package:nop_db_sqlite/sqlite.dart';
import 'package:nop_annotations/nop_annotations.dart';
import 'package:nop_db/nop_db.dart';
part 'dict_database.g.dart';

class DictTable extends Table {
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
}

@Nop(tables: [DictTable])
class DictDatabase extends _GenDictDatabase {
  DictDatabase(this.path);
  final String path;
  FutureOr<void> initDb() {
    return NopDatabaseImpl.open(path, onCreate: onCreate).then(setDb);
  }
}
