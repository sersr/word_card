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
      'data': instance.data,
    };

BookListsData _$BookListsDataFromJson(Map<String, dynamic> json) =>
    BookListsData(
      normalBooksInfo: (json['normalBooksInfo'] as List<dynamic>?)
          ?.map((e) =>
              BookListsDataNormalBooksInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookListsDataToJson(BookListsData instance) =>
    <String, dynamic>{
      'normalBooksInfo':
          instance.normalBooksInfo?.map((e) => e.toJson()).toList(),
    };

BookListsDataNormalBooksInfo _$BookListsDataNormalBooksInfoFromJson(
        Map<String, dynamic> json) =>
    BookListsDataNormalBooksInfo(
      cover: json['cover'] as String?,
      bookOrigin: json['bookOrigin'] == null
          ? null
          : BookListsDataNormalBooksInfoBookOrigin.fromJson(
              json['bookOrigin'] as Map<String, dynamic>),
      size: json['size'] as int?,
      introduce: json['introduce'] as String?,
      wordNum: json['wordNum'] as int?,
      reciteUserNum: json['reciteUserNum'] as int?,
      id: json['id'] as String?,
      title: json['title'] as String?,
      offlinedata: json['offlinedata'] as String?,
      version: json['version'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => BookListsDataNormalBooksInfoTags.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookListsDataNormalBooksInfoToJson(
        BookListsDataNormalBooksInfo instance) =>
    <String, dynamic>{
      'cover': instance.cover,
      'bookOrigin': instance.bookOrigin?.toJson(),
      'size': instance.size,
      'introduce': instance.introduce,
      'wordNum': instance.wordNum,
      'reciteUserNum': instance.reciteUserNum,
      'id': instance.id,
      'title': instance.title,
      'offlinedata': instance.offlinedata,
      'version': instance.version,
      'tags': instance.tags?.map((e) => e.toJson()).toList(),
    };

BookListsDataNormalBooksInfoBookOrigin
    _$BookListsDataNormalBooksInfoBookOriginFromJson(
            Map<String, dynamic> json) =>
        BookListsDataNormalBooksInfoBookOrigin(
          originUrl: json['originUrl'] as String?,
          desc: json['desc'] as String?,
          originName: json['originName'] as String?,
        );

Map<String, dynamic> _$BookListsDataNormalBooksInfoBookOriginToJson(
        BookListsDataNormalBooksInfoBookOrigin instance) =>
    <String, dynamic>{
      'originUrl': instance.originUrl,
      'desc': instance.desc,
      'originName': instance.originName,
    };

BookListsDataNormalBooksInfoTags _$BookListsDataNormalBooksInfoTagsFromJson(
        Map<String, dynamic> json) =>
    BookListsDataNormalBooksInfoTags(
      tagName: json['tagName'] as String?,
      tagUrl: json['tagUrl'] as String?,
    );

Map<String, dynamic> _$BookListsDataNormalBooksInfoTagsToJson(
        BookListsDataNormalBooksInfoTags instance) =>
    <String, dynamic>{
      'tagName': instance.tagName,
      'tagUrl': instance.tagUrl,
    };
