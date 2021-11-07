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
  getImageSource
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
    _getImageSource_6
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
  Stream<int> _downloadDict_3(args) => downloadDict(args[0], args[1]);
  FutureOr<List<Words>?> _getWordsData_4(args) => getWordsData(args);
  FutureOr<List<DictTable>?> _getMainLists_5(args) => getMainLists();
  dynamic _getImageSource_6(args) => getImageSourceDynamic(args);
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

  Stream<int> downloadDict(String id, String url) {
    return sendEvent
        .sendMessageStream(DictEventMessage.downloadDict, [id, url]);
  }

  FutureOr<List<Words>?> getWordsData(String id) async {
    return sendEvent.sendMessage(DictEventMessage.getWordsData, id);
  }

  FutureOr<List<DictTable>?> getMainLists() async {
    return sendEvent.sendMessage(DictEventMessage.getMainLists, null);
  }

  dynamic getImageSourceDynamic(String url) async {
    return sendEvent.sendMessage(DictEventMessage.getImageSource, url);
  }
}
