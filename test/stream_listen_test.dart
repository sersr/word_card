// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:useful_tools/useful_tools.dart';

void main() async {
  test('listen close', () async {
    final stream = getStream();
    print(stream.runtimeType);
    stream.streamSend();
    await Future.delayed(const Duration(milliseconds: 100));
  });

  test('hive get', () async {
    Hive.init('./test/hive');
    var box = await Hive.openBox('test');
    await box.put('key', {'hello': 12});
    await box.close();
    box = await Hive.openBox('test');
    final x = box.get('key');
    Log.i('value: $x');
  });
}

Stream<int> getStream() {
  final stream = StreamController<int>();
  Timer.run(() async {
    stream.add(1);
    Zone.root.print('222232');

    await stream.close();
    Zone.root.print('2222zzx32');
  });
  return stream.stream;
}

extension StreamSend<T> on Stream<T> {
  StreamSubscription streamSend() {
    return listen((data) {
      Zone.root.print('listen $data');
    }, onDone: () {
      Zone.root.print('onDone....sss');
    }, onError: (_) {}, cancelOnError: true);
  }
}
