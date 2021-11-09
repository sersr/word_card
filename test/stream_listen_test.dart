// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

void main() async {
  test('listen close', () async {
    final stream = getStream();
    print(stream.runtimeType);
    stream.streamSend();
    await Future.delayed(const Duration(milliseconds: 100));
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
