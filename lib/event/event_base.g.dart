// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_base.dart';

// **************************************************************************
// Generator: IsolateEventGeneratorForAnnotation
// **************************************************************************

enum DictEventMessage {
  getDictLists,
  getWordsState,
  downloadDict,
  getWordsData,
  getMainLists
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

mixin DictEventResolve on Resolve, DictEvent {
  late final _dictEventResolveFuncList = List<DynamicCallback>.unmodifiable([
    _getDictLists_0,
    _getWordsState_1,
    _downloadDict_2,
    _getWordsData_3,
    _getMainLists_4
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

  FutureOr<BookListsData?> _getDictLists_0(args) => getDictLists();
  FutureOr<bool?> _getWordsState_1(args) => getWordsState(args);
  Stream<int> _downloadDict_2(args) => downloadDict(args[0], args[1]);
  FutureOr<List<Words>?> _getWordsData_3(args) => getWordsData(args);
  FutureOr<List<DictTable>?> _getMainLists_4(args) => getMainLists();
}

/// implements [DictEvent]
mixin DictEventMessager {
  SendEvent get sendEvent;

  FutureOr<BookListsData?> getDictLists() async {
    return sendEvent.sendMessage(DictEventMessage.getDictLists, null);
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
}
