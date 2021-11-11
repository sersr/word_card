import 'dart:async';

import 'package:hive/hive.dart';
import 'package:useful_tools/common.dart';

typedef CacheHiveRun = FutureOr<void> Function(CacheHive box);

class CacheHive {
  CacheHive(this._box, this._onDispose);
  final Box _box;
  final void Function() _onDispose;

  Box use() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    return _box;
  }

  bool ticked = false;

  Timer? _timer;
  void end() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    if (ticked) {
      _timer = Timer(const Duration(seconds: 30), _onDispose);
    }
  }

  static final _cacheHive = <String, CacheHive>{};

  static Future<void> beginHive(String fileName, CacheHiveRun run) {
    return eventRun(fileName, () => _beginHive(fileName, run));
  }

  static Future<void> eventRun(String fileName, FutureOr<void> Function() run) {
    return EventQueue.runTaskOnQueue([_beginHive, fileName], run);
  }

// 在生命函数期间`box`不会被关闭
  static Future<void> _beginHive(String fileName, CacheHiveRun run) async {
    try {
      CacheHive box;
      if (_cacheHive.containsKey(fileName)) {
        box = _cacheHive[fileName]!;
      } else {
        final hiveBox = await Hive.openBox(fileName);
        box = CacheHive(hiveBox, () {
          eventRun(fileName, () {
            _cacheHive.remove(fileName);
            return hiveBox.close();
          });
        });
        _cacheHive[fileName] = box;
      }

      try {
        await run(box);
      } catch (e) {
        Log.e(e, onlyDebug: false);
      } finally {
        box.end();
      }
    } on HiveError catch (e) {
      Log.e('在当前隔离中可能没有初始化\n`Hive.init(path);`', onlyDebug: false);
      Log.e(e, onlyDebug: false);
    }
  }
}
