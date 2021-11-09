import 'dart:async';

import 'package:flutter/material.dart';
import 'package:useful_tools/common.dart';
import 'package:just_audio/just_audio.dart';

import '../data/data.dart';
import '../database/dict_database.dart';
import '../event/event_base.dart';
import '../event/repository.dart';

class WordCardNotifier extends ChangeNotifier {
  WordCardNotifier(this.repository);
  final Repository repository;

  List<Words>? _cache;
  List<Words>? get data => _cache;

  DictEvent get event => repository;
  StreamSubscription? _sub;
  Future<void> _loadData(String id) async {
    final cache = <Words>[];
    final completer = Completer<void>();
    _sub?.cancel();
    _sub = event.getWordsData(id).listen((event) {
      cache.addAll(event);
      Log.i('add');
    }, onDone: () {
      Log.w('done');
      if (!completer.isCompleted) {
        completer.complete();
      }
    }, onError: (e) {
      Log.w('onError');
      if (!completer.isCompleted) {
        completer.complete();
      }
    }, cancelOnError: true);
    await completer.future;
    _sub?.cancel();
    _sub = null;
    _cache = cache;
    notifyListeners();
  }

  Future<void> loadData(String id) async {
    if (_cache != null) return;
    Log.w('dict:$id');

    return EventQueue.runTaskOnQueue([_loadData, id], () async {
      await _loadData(id);
    });
  }

  Future<int?> updateDict(String dictId, int currentIndex) {
    return EventQueue.runOneTaskOnQueue<int?>([updateDict, dictId], () {
      return event.updateDict(
          dictId,
          DictTable(
              wordIndex: currentIndex,
              sortKey: DateTime.now().microsecondsSinceEpoch));
    });
  }

  final audiopalyer = AudioPlayer();
  void play(String? word, String? type) {
    if (word == null || type == null) return;

    EventQueue.runOneTaskOnQueue(audiopalyer, () async {
      final path = await event.getVoicePath(word, type);
      if (path == null) return;
      final currentTask = EventQueue.currentTask;
      if (currentTask?.canDiscard == true) {
        Log.w('discard this task', onlyDebug: false);
        return;
      }

      EventQueue.runOneTaskOnQueue(play, () async {
        Log.i('start', onlyDebug: false);
        if (audiopalyer.playing) {
          Log.i('playing', onlyDebug: false);
          await audiopalyer.stop();
        }
        await audiopalyer.setFilePath(path);
        await audiopalyer.play();
        Log.i('done', onlyDebug: false);
      });
    });
  }
}
