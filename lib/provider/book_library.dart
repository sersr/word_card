// ignore_for_file: prefer_final_fields

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:useful_tools/useful_tools.dart';

import '../data/data.dart';
import '../database/dict_database.dart';
import '../event/repository.dart';

class BookLibraryData {
  BookLibraryData(this.normalBooks, this.bookInfos) {
    for (var item in bookInfos) {
      final id = item.id;
      if (id != null) {
        _mapData[id] = item;
      }
    }
    initCateData();
  }
  BookCategoryDataNormalBooks normalBooks;
  List<BookInfoDataNormalBooksInfo> bookInfos;
  // id => info
  Map<String, BookInfoDataNormalBooksInfo> _mapData = {};
  // cate => list
  Map<String, List<BookCategoryDataNormalBooksBookList>> _cateData = {};

  void initCateData() {
    if (_cateData.isNotEmpty) return;
    final rawList = normalBooks.bookList;
    if (rawList != null) {
      for (var item in rawList) {
        final cateName = item?.cateName;

        if (cateName != null) {
          for (var cateItem in cateName) {
            final name = cateItem?.name;
            if (name != null) {
              final _dataList = _cateData.putIfAbsent(name, () => []);
              _dataList.add(item!);
            }
          }
        }
      }
    }
  }

  // cate => infos
  final Map<String, List<BookInfoDataNormalBooksInfo>> _cacheData = {};
  final Map<String, List<BookInfoDataNormalBooksInfo>> _cacheCateTagData = {};
  List<BookInfoDataNormalBooksInfo>? getCateData(String cate) {
    final _data = _cacheData[cate];
    if (_data != null) {
      return _data;
    }
    final _genData = _cacheData.putIfAbsent(cate, () => []);
    final ids = _cateData[cate];
    if (ids != null) {
      for (var item in ids) {
        final id = item.id;
        if (id != null) {
          final info = _mapData[id];
          if (info != null) {
            _genData.add(info);
          }
        }
      }
    }
    return _genData;
  }

  List<BookInfoDataNormalBooksInfo>? getCateTagData(String? cate, String? tag) {
    if (cate == null || cate.isEmpty) {
      return bookInfos;
    }
    if (tag == null || tag.isEmpty) {
      return getCateData(cate);
    }
    final key = '$cate$tag';
    final _data = _cacheCateTagData[key];
    if (_data != null) {
      return _data;
    }
    final dataRef = _cacheCateTagData.putIfAbsent(key, () => []);
    final list = getCateData(cate);
    if (list != null) {
      for (var item in list) {
        final tags = item.tags;
        if (tags != null) {
          for (var rawTag in tags) {
            final tagName = rawTag?.tagName;
            if (tagName == tag) {
              dataRef.add(item);
              break;
            }
          }
        }
      }
    }
    return dataRef;
  }
}

class BookLibraryNotifier extends ChangeNotifier {
  BookLibraryNotifier();
  Repository? repository;
  BookLibraryData? data;
  bool get initialized => data != null;
  bool get loadingOrDone =>
      initialized || EventQueue.getQueueState(_load) == true;

  Future<void> load() {
    return EventQueue.runTaskOnQueue(_load, _load);
  }

  Future<void> _load() async {
    if (repository == null) return;
    final idLists = await repository!.event.getDictLists() ??
        const BookCategoryDataNormalBooks();
    final bookIds =
        idLists.bookList?.map((e) => e?.id).whereType<String>().toList();
    if (bookIds != null) {
      final _data =
          await repository!.event.getDictInfoLists(bookIds) ?? const [];
      data = BookLibraryData(idLists, _data);
    }
    notifyListeners();
  }

  String? cate;
  String? tag;
  void changeCate(String? newCate, String? newTag) {
    EventQueue.runTaskOnQueue(_load, () {
      if (data == null) return;
      if (cate == newCate && tag == newTag) {
        if (tag == null) {
          cate = null;
        }
        tag = null;
        notifyListeners();
        return;
      }
      if (cate != newCate || tag != newTag) {
        cate = newCate;
        tag = newTag;
        notifyListeners();
      }
    });
  }

  bool eqTag(String selectTag) {
    return tag != null && selectTag == tag;
  }

  bool eqCate(String? selectCate) {
    return cate != null && selectCate == cate;
  }

  List<BookInfoDataNormalBooksInfo>? get getCateTagData =>
      data?.getCateTagData(cate, tag);
  List<BookCategoryDataNormalBooksCateNames?>? get tagNames =>
      data?.normalBooks.cateNames;
  BookCategoryDataNormalBooksCateNames? get tags {
    if (cate == null) return null;
    final _tagNames = tagNames;
    if (_tagNames != null) {
      for (var item in _tagNames) {
        if (item?.name == cate) {
          return item;
        }
      }
    }
  }

  // Future<void> download(String? id, String? url) {
  //   Log.i('$id, $url');
  //   return EventQueue.runOneTaskOnQueue([download, id, url], () async {
  //     if (id == null || url == null) return;
  //     await repository!.event.downloadDict(id, url);
  //   });
  // }

  Map<String, bool> _idState = {};
  Future<bool> getWordState(String? id) async {
    if (id == null) return false;
    var state = _idState[id];
    if (state != null) {
      return state;
    }
    state = await repository!.event.getWordsState(id) == true;
    return _idState.putIfAbsent(id, () => state!);
  }

  Future<void> loadAndAdd(
      String? id, String? url, BookInfoDataNormalBooksInfo info) {
    return EventQueue.runOneTaskOnQueue(loadAndAdd, () async {
      if (id == null || url == null) return;
      await repository!.event.downloadDict(id, url);
      await addDict(info);
      _idState.remove(id);
      notifyListeners();
    });
  }

  Future<void> addDict(BookInfoDataNormalBooksInfo info) {
    return EventQueue.runTaskOnQueue(addDict, () async {
      final name = info.title;
      final wordNumber = info.wordNum;
      final dictId = info.id;
      if (name == null || wordNumber == null || dictId == null) return;
      final list = List.generate(wordNumber, (index) => index);
      final now = DateTime.now().microsecondsSinceEpoch;
      final dict = DictTable(
        dictId: dictId,
        name: name,
        wordIndex: 1,
        dataIndex: list,
        createTime: now,
        sortKey: now,
        show: true,
      );
      await repository!.event.addDict(dict);
    });
  }
}
