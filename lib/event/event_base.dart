import 'dart:async';

import 'package:nop_annotations/nop_annotations.dart';
import 'package:nop_db/nop_db.dart';

import '../data/book_lists.dart';
import '../data/words.dart';
import '../database/dict_database.dart';
part 'event_base.g.dart';

@NopIsolateEvent()
abstract class DictEvent {
  /// 所有单词书籍列表
  FutureOr<BookListsData?> getDictLists();

  FutureOr<bool?> getWordsState(String id);

  /// 从网上下载单词数据（有道），并保存到数据库中
  /// `int`为下载进度
  /// 以`Hive`方式存储
  Stream<int> downloadDict(String id, String url);

  /// 获取一本书籍的所有单词
  FutureOr<List<Words>?> getWordsData(String id);

  /// 主页展示所有创建的单词组，比如通过随机排列生成不同的单词组
  FutureOr<List<DictTable>?> getMainLists();
}
