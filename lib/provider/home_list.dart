import 'package:flutter/foundation.dart';

import '../database/dict_database.dart';
import '../event/event_base.dart';
import '../event/repository.dart';

class DictTableData {
  DictTableData(this._data) {
    _data?.sort();
  }

  final List<DictTable>? _data;
  List<DictTable>? _unmodifiableData;

  List<DictTable>? get data {
    if (_unmodifiableData == null) {
      if (_data != null) {
        _unmodifiableData = List.unmodifiable(_data!);
      }
    }
    return _unmodifiableData;
  }
}

class HomeListNotifier extends ChangeNotifier {
  HomeListNotifier({required this.repository});

  final Repository repository;
  DictEvent get event => repository;
  DictTableData _data = DictTableData(null);

  DictTableData get data => _data;

  @protected
  void setData(DictTableData value) {
    _data = value;
    notifyListeners();
  }

  Future<void> initList() async {
    final dbData = await event.getMainLists() ?? const [];
    setData(DictTableData(dbData));
  }
}
