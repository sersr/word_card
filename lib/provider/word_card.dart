import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:useful_tools/useful_tools.dart';
import 'package:just_audio/just_audio.dart';

import '../database/dict_database.dart';
import '../event/event_base.dart';
import '../event/repository.dart';

class WordCardNotifier extends ChangeNotifier {
  WordCardNotifier(this.repository);
  final Repository repository;

  final List<WordTable> _cache = <WordTable>[];
  List<WordTable> get data => _cache;

  DictEvent get event => repository;
  StreamSubscription? _sub;
  bool _done = false;
  Future<void> _loadData(String id) async {
    final completer = Completer<void>();
    _sub?.cancel();
    _sub = event.getWordsData(id).listen((event) {
      _cache.addAll(event);
      if (loadIds.isNotEmpty) {
        notifyListeners();
        loadIds.clear();
      }
    }, onDone: () {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }, onError: (e) {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }, cancelOnError: true);
    await completer.future;
    _sub?.cancel();
    _sub = null;
    _done = true;
    notifyListeners();
  }

  Future<void> loadData(String id) async {
    if (_done) return;
    Log.w('dict:$id');

    return EventQueue.runTaskOnQueue([_loadData, id], () async {
      openVoiceHive(true);
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

  final loadIds = <int>[];
  bool getCurrentState(int index) {
    if (index <= _cache.length - 1) return true;
    loadIds.add(index);
    return false;
  }

  final audiopalyer = AudioPlayer();

  void playSentence(String? sentence) {
    if (sentence == null) return;
    final tranSentence =
        sentence.trim().replaceAll('\u3000', ' ').replaceAll(' ', '+');
    play('$tranSentence&type=2');
  }

  void play(String? query) {
    Log.i('query: $query', onlyDebug: false);
    if (query == null) return;
    final stop = Stopwatch()..start();
    EventQueue.runOneTaskOnQueue(audiopalyer, () async {
      final path = await event.getVoicePath(query);
      if (path == null) return;
      final currentTask = EventQueue.currentTask;
      if (currentTask?.canDiscard == true) {
        Log.w('discard this task', onlyDebug: false);
        return;
      }

      EventQueue.runOneTaskOnQueue(play, () async {
        Log.i('start ${stop.elapsedMicroseconds / 1000} ms', onlyDebug: false);
        if (audiopalyer.playing) {
          Log.i('playing', onlyDebug: false);
          await audiopalyer.stop();
          Log.i('playing ${stop.elapsedMicroseconds / 1000} ms',
              onlyDebug: false);
        }
        await audiopalyer.setFilePath(path);
        Log.i('play ${stop.elapsedMicroseconds / 1000} ms', onlyDebug: false);
        // 不同平台的行为不一致？？
        await audiopalyer.play();
        if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS) {
          await audiopalyer.stop();
        }
        Log.i('done: ${stop.elapsedMicroseconds / 1000} ms', onlyDebug: false);
      });
    });
  }

  void openVoiceHive(bool open) {
    EventQueue.runTaskOnQueue(audiopalyer, () async {
      // await event.openDict(!open);
      await event.openVoiceHive(open);
    });
  }

  Future<WordTable?> getWord(String? headWord) async {
    if (headWord == null) return null;
    return event.getWord(headWord);
  }

  @override
  void dispose() {
    super.dispose();
    audiopalyer.dispose();
    openVoiceHive(false);
  }
}
