import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/foundation.dart';
import 'package:nop_db/nop_db.dart';
import 'package:nop_db/extensions/future_or_ext.dart';
import 'package:utils/event_queue.dart';

import 'event.dart';
import 'event_base.dart';

class Repository extends DictEventMessagerMain with SendEventPortMixin {
  @override
  SendEvent get sendEvent => this;
  SendPort? _sdPort;

  Isolate? _isolate;
  final _initStatus = ValueNotifier(false);

  ValueListenable<bool> get initStatus => _initStatus;

  set isolate(Isolate? newIsolate) {
    if (_isolate == newIsolate) return;
    if (_isolate != null) {
      _isolate!.kill(priority: Isolate.immediate);
    }
    _isolate = newIsolate;
    _initStatus.value = _isolate != null;
  }

  final _penddingEvents = [];
  @override
  void send(message) {
    if (_sdPort == null) {
      _penddingEvents.add(message);
      return;
    }
    _sdPort!.send(message);
  }

  Future<void> init() {
    return EventQueue.runTaskOnQueue(this, _init);
  }

  Future<void> _init() async {
    _initStatus.value = _isolate != null;
    if (initStatus.value) return;
    final appPath = await getApplicationDocumentsDirectory();
    final rcPort = ReceivePort();
    final newIsolate =
        await Isolate.spawn(isolateDictEvent, [rcPort.sendPort, appPath.path]);
    await onDone(rcPort);
    isolate = newIsolate;
  }

  Future<void> onDone(ReceivePort rcPort) async {
    _sdPort = await rcPort.first;
    if (_penddingEvents.isNotEmpty) {
      final events = List.of(_penddingEvents);
      _penddingEvents.clear();
      events.forEach(send);
    }
  }

  Future<void> close() {
    return EventQueue.runTaskOnQueue(this, dispose);
  }

  @override
  void dispose() {
    _sdPort = null;
    _isolate = null;
    super.dispose();
  }

  @override
  Future<Uint8List?> getImageSource(String url) async {
    final data = await getImageSourceDynamic(url);
    if (data is ByteBuffer) {
      return data.asUint8List();
    } else if (data is Uint8List) {
      return data;
    }
  }

  /// Impl

}
