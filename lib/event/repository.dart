import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:nop_db/nop_db.dart';
import 'package:path_provider/path_provider.dart';

import 'event.dart';
import 'event_base.dart';

class Repository extends DictEventMessagerMain
    with SendEventMixin, SendIsolateMixin {
  @override
  SendEvent get sendEvent => this;

  final _initStatus = ValueNotifier(false);

  ValueListenable<bool> get initStatus => _initStatus;

  @override
  void notifiyState(bool init) {
    _initStatus.value = init;
  }

  @override
  Future<Isolate> onCreateIsolate(SendPort sendPort) async {
    final appPath = await getApplicationDocumentsDirectory();
    final newIsolate =
        await Isolate.spawn(isolateDictEvent, [sendPort, appPath.path]);
    return newIsolate;
  }


  /// 网络图片
  @override
  Future<Uint8List?> getImageSource(String url) async {
    final data = await getImageSourceDynamic(url);
    if (data is ByteBuffer) {
      return data.asUint8List();
    } else if (data is Uint8List) {
      return data;
    }
  }
}
