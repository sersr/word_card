import 'dart:async';
import 'dart:typed_data';

import 'package:nop_annotations/nop_annotations.dart';
import 'package:nop_db/nop_db.dart';

import '../data/data.dart';
import '../database/dict_database.dart';

part 'event_base.g.dart';

@NopIsolateEvent()
abstract class DictEvent {
  DictEvent get event => this;

  /// 所有单词书籍列表 id
  FutureOr<BookCategoryDataNormalBooks?> getDictLists();

  /// 获取单词书详细信息
  FutureOr<List<BookInfoDataNormalBooksInfo>?> getDictInfoLists(
      List<String> body);

  /// 在下载之前询问单词书是否已下载
  FutureOr<bool?> getWordsState(String id);

  /// 从网上下载单词数据（有道），并保存到数据库中
  /// `int`为下载进度
  /// 以`Hive`方式存储
  FutureOr<int?> downloadDict(String id, String url);

  /// 获取一本书籍的所有单词
  Stream<List<Words>> getWordsData(String id);

  /// 主页展示所有创建的单词组，比如通过随机排列生成不同的单词组
  FutureOr<List<DictTable>?> getMainLists();
  Stream<List<DictTable>> watchDictLists();

  @NopIsolateMethod(isDynamic: true)
  FutureOr<Uint8List?> getImageSource(String url);

  FutureOr<int?> addDict(DictTable dict);
  FutureOr<int?> updateDict(String dictId, DictTable dict);
}
