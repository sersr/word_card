// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookInfo _$BookInfoFromJson(Map<String, dynamic> json) => BookInfo(
      reason: json['reason'] as String?,
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : BookInfoData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookInfoToJson(BookInfo instance) => <String, dynamic>{
      'reason': instance.reason,
      'code': instance.code,
      'data': instance.data,
    };

BookInfoData _$BookInfoDataFromJson(Map<String, dynamic> json) => BookInfoData(
      normalBooksInfo: (json['normalBooksInfo'] as List<dynamic>?)
          ?.map((e) =>
              BookInfoDataNormalBooksInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookInfoDataToJson(BookInfoData instance) =>
    <String, dynamic>{
      'normalBooksInfo':
          instance.normalBooksInfo?.map((e) => e.toJson()).toList(),
    };

BookInfoDataNormalBooksInfo _$BookInfoDataNormalBooksInfoFromJson(
        Map<String, dynamic> json) =>
    BookInfoDataNormalBooksInfo(
      cover: json['cover'] as String?,
      bookOrigin: json['bookOrigin'] == null
          ? null
          : BookInfoDataNormalBooksInfoBookOrigin.fromJson(
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
          ?.map((e) => BookInfoDataNormalBooksInfoTags.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookInfoDataNormalBooksInfoToJson(
        BookInfoDataNormalBooksInfo instance) =>
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

BookInfoDataNormalBooksInfoBookOrigin
    _$BookInfoDataNormalBooksInfoBookOriginFromJson(
            Map<String, dynamic> json) =>
        BookInfoDataNormalBooksInfoBookOrigin(
          originUrl: json['originUrl'] as String?,
          desc: json['desc'] as String?,
          originName: json['originName'] as String?,
        );

Map<String, dynamic> _$BookInfoDataNormalBooksInfoBookOriginToJson(
        BookInfoDataNormalBooksInfoBookOrigin instance) =>
    <String, dynamic>{
      'originUrl': instance.originUrl,
      'desc': instance.desc,
      'originName': instance.originName,
    };

BookInfoDataNormalBooksInfoTags _$BookInfoDataNormalBooksInfoTagsFromJson(
        Map<String, dynamic> json) =>
    BookInfoDataNormalBooksInfoTags(
      tagName: json['tagName'] as String?,
      tagUrl: json['tagUrl'] as String?,
    );

Map<String, dynamic> _$BookInfoDataNormalBooksInfoTagsToJson(
        BookInfoDataNormalBooksInfoTags instance) =>
    <String, dynamic>{
      'tagName': instance.tagName,
      'tagUrl': instance.tagUrl,
    };
