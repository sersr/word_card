// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_base.dart';

// **************************************************************************
// Generator: IsolateEventGeneratorForAnnotation
// **************************************************************************

enum DictEventMessage {
  getDictLists,
  getDictInfoLists,
  getWordsState,
  downloadDict,
  getWordsData,
  getMainLists,
  watchDictLists,
  getImageSource,
  addDict,
  updateDict,
  getVoicePath,
  openVoiceHive,
  getWord
}

abstract class DictEventResolveMain extends DictEvent
    with Resolve, DictEventResolve {
  @override
  bool resolve(resolveMessage) {
    if (remove(resolveMessage)) return true;
    if (resolveMessage is! IsolateSendMessage) return false;
    return super.resolve(resolveMessage);
  }
}

abstract class DictEventMessagerMain extends DictEvent with DictEventMessager {}

/// implements [DictEvent]
abstract class DictEventDynamic {
  dynamic getImageSourceDynamic(String url);
}

mixin DictEventResolve on Resolve, DictEvent implements DictEventDynamic {
  late final _dictEventResolveFuncList = List<DynamicCallback>.unmodifiable([
    _getDictLists_0,
    _getDictInfoLists_1,
    _getWordsState_2,
    _downloadDict_3,
    _getWordsData_4,
    _getMainLists_5,
    _watchDictLists_6,
    _getImageSource_7,
    _addDict_8,
    _updateDict_9,
    _getVoicePath_10,
    _openVoiceHive_11,
    _getWord_12
  ]);

  @override
  bool resolve(resolveMessage) {
    if (resolveMessage is IsolateSendMessage) {
      final type = resolveMessage.type;
      if (type is DictEventMessage) {
        dynamic result;
        try {
          result = _dictEventResolveFuncList
              .elementAt(type.index)(resolveMessage.args);
          receipt(result, resolveMessage);
        } catch (e) {
          receipt(result, resolveMessage, e);
        }
        return true;
      }
    }
    return super.resolve(resolveMessage);
  }

  FutureOr<BookCategoryDataNormalBooks?> _getDictLists_0(args) =>
      getDictLists();
  FutureOr<List<BookInfoDataNormalBooksInfo>?> _getDictInfoLists_1(args) =>
      getDictInfoLists(args);
  FutureOr<bool?> _getWordsState_2(args) => getWordsState(args);
  FutureOr<int?> _downloadDict_3(args) => downloadDict(args[0], args[1]);
  Stream<List<WordTable>> _getWordsData_4(args) => getWordsData(args);
  FutureOr<List<DictTable>?> _getMainLists_5(args) => getMainLists();
  Stream<List<DictTable>> _watchDictLists_6(args) => watchDictLists();
  dynamic _getImageSource_7(args) => getImageSourceDynamic(args);
  FutureOr<int?> _addDict_8(args) => addDict(args);
  FutureOr<int?> _updateDict_9(args) => updateDict(args[0], args[1]);
  FutureOr<String?> _getVoicePath_10(args) => getVoicePath(args);
  FutureOr<void> _openVoiceHive_11(args) => openVoiceHive(args);
  FutureOr<WordTable?> _getWord_12(args) => getWord(args);
}

/// implements [DictEvent]
mixin DictEventMessager {
  SendEvent get sendEvent;

  FutureOr<BookCategoryDataNormalBooks?> getDictLists() async {
    return sendEvent.sendMessage(DictEventMessage.getDictLists, null);
  }

  FutureOr<List<BookInfoDataNormalBooksInfo>?> getDictInfoLists(
      List<String> body) async {
    return sendEvent.sendMessage(DictEventMessage.getDictInfoLists, body);
  }

  FutureOr<bool?> getWordsState(String id) async {
    return sendEvent.sendMessage(DictEventMessage.getWordsState, id);
  }

  FutureOr<int?> downloadDict(String id, String url) async {
    return sendEvent.sendMessage(DictEventMessage.downloadDict, [id, url]);
  }

  Stream<List<WordTable>> getWordsData(String id) {
    return sendEvent.sendMessageStream(DictEventMessage.getWordsData, id);
  }

  FutureOr<List<DictTable>?> getMainLists() async {
    return sendEvent.sendMessage(DictEventMessage.getMainLists, null);
  }

  Stream<List<DictTable>> watchDictLists() {
    return sendEvent.sendMessageStream(DictEventMessage.watchDictLists, null);
  }

  dynamic getImageSourceDynamic(String url) async {
    return sendEvent.sendMessage(DictEventMessage.getImageSource, url);
  }

  FutureOr<int?> addDict(DictTable dict) async {
    return sendEvent.sendMessage(DictEventMessage.addDict, dict);
  }

  FutureOr<int?> updateDict(String dictId, DictTable dict) async {
    return sendEvent.sendMessage(DictEventMessage.updateDict, [dictId, dict]);
  }

  FutureOr<String?> getVoicePath(String query) async {
    return sendEvent.sendMessage(DictEventMessage.getVoicePath, query);
  }

  FutureOr<void> openVoiceHive(bool open) async {
    return sendEvent.sendMessage(DictEventMessage.openVoiceHive, open);
  }

  FutureOr<WordTable?> getWord(String headWord) async {
    return sendEvent.sendMessage(DictEventMessage.getWord, headWord);
  }
}
