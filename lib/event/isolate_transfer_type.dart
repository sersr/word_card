import 'dart:convert';
import 'dart:typed_data';

import 'package:nop_db/nop_db.dart';
import 'package:utils/utils.dart';
import '../database/dict_database.dart';

class WordTableTransferType
    extends TransferTypeMapList<Map<String, Object?>, WordTable> {
  WordTableTransferType(this.raw);
  @override
  List<Map<String, Object?>>? raw;

  @override
  WordTable decodeToSelf(ByteBuffer buffer, int index) {
    var map = const <String, Object?>{};
    try {
      final data = utf8.decode(buffer.asUint8List());
      map = jsonDecode(data);
    } catch (e) {
      Log.e(e);
    }
    final table = GenWordTable.mapToTable(map);
    return table;
  }

  @override
  TypedData encodeToTypedData(Map<String, Object?> rawData, int index) {
    try {
      final json = jsonEncode(rawData);
      final bytes = utf8.encode(json);
      return Uint8List.fromList(bytes);
    } catch (e) {
      Log.e(e);
    }
    return Uint8List(0);
  }
}
