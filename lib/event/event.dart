import 'dart:isolate';

import 'package:useful_tools/common.dart';

import 'event_mixin.dart';

/// 隔离顶级函数入口
Future<void> isolateDictEvent(List args) async {
  final sendPort = args[0] as SendPort;
  final path = args[1] as String;
  final rcPort = ReceivePort();

  final eventImpl = DictEventIsolate(path: path, sp: sendPort);
  await eventImpl.init();

  rcPort.listen((message) {
    if (eventImpl.resolve(message)) return;
    Log.e('error: $message', onlyDebug: false);
  });
  sendPort.send(rcPort.sendPort);
}
