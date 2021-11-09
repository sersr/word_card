// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_lists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookLists _$BookListsFromJson(Map<String, dynamic> json) => BookLists(
      reason: json['reason'] as String?,
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : BookListsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookListsToJson(BookLists instance) => <String, dynamic>{
      'reason': instance.reason,
      'code': instance.code,
      'data': instance.data?.toJson(),
    };

BookListsData _$BookListsDataFromJson(Map<String, dynamic> json) =>
    BookListsData(
      listBooksInfo: (json['listBooksInfo'] as List<dynamic>?)
          ?.map((e) =>
              BookListsDataListBooksInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookListsDataToJson(BookListsData instance) =>
    <String, dynamic>{
      'listBooksInfo': instance.listBooksInfo?.map((e) => e.toJson()).toList(),
    };

BookListsDataListBooksInfo _$BookListsDataListBooksInfoFromJson(
        Map<String, dynamic> json) =>
    BookListsDataListBooksInfo(
      cover: json['cover'] as String?,
      wordsNum: json['wordsNum'] as int?,
      introduce: json['introduce'] as String?,
      versionTs: json['versionTs'] as int?,
      reciteUserNum: json['reciteUserNum'] as int?,
      bookName: json['bookName'] as String?,
      creatorAvatar: json['creatorAvatar'] as String?,
      creatorNickName: json['creatorNickName'] as String?,
      bookId: json['bookId'] as String?,
      tags: json['tags'] as List<dynamic>?,
    );

Map<String, dynamic> _$BookListsDataListBooksInfoToJson(
        BookListsDataListBooksInfo instance) =>
    <String, dynamic>{
      'cover': instance.cover,
      'wordsNum': instance.wordsNum,
      'introduce': instance.introduce,
      'versionTs': instance.versionTs,
      'reciteUserNum': instance.reciteUserNum,
      'bookName': instance.bookName,
      'creatorAvatar': instance.creatorAvatar,
      'creatorNickName': instance.creatorNickName,
      'bookId': instance.bookId,
      'tags': instance.tags,
    };
