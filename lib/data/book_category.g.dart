// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookCategory _$BookCategoryFromJson(Map<String, dynamic> json) => BookCategory(
      reason: json['reason'] as String?,
      code: json['code'] as int?,
      data: json['data'] == null
          ? null
          : BookCategoryData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookCategoryToJson(BookCategory instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'code': instance.code,
      'data': instance.data?.toJson(),
    };

BookCategoryData _$BookCategoryDataFromJson(Map<String, dynamic> json) =>
    BookCategoryData(
      normalBooks: json['normalBooks'] == null
          ? null
          : BookCategoryDataNormalBooks.fromJson(
              json['normalBooks'] as Map<String, dynamic>),
      version: json['version'] as int?,
    );

Map<String, dynamic> _$BookCategoryDataToJson(BookCategoryData instance) =>
    <String, dynamic>{
      'normalBooks': instance.normalBooks?.toJson(),
      'version': instance.version,
    };

BookCategoryDataNormalBooks _$BookCategoryDataNormalBooksFromJson(
        Map<String, dynamic> json) =>
    BookCategoryDataNormalBooks(
      cateNames: (json['cateNames'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : BookCategoryDataNormalBooksCateNames.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
      bookList: (json['bookList'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : BookCategoryDataNormalBooksBookList.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookCategoryDataNormalBooksToJson(
        BookCategoryDataNormalBooks instance) =>
    <String, dynamic>{
      'cateNames': instance.cateNames?.map((e) => e?.toJson()).toList(),
      'bookList': instance.bookList?.map((e) => e?.toJson()).toList(),
    };

BookCategoryDataNormalBooksCateNames
    _$BookCategoryDataNormalBooksCateNamesFromJson(Map<String, dynamic> json) =>
        BookCategoryDataNormalBooksCateNames(
          name: json['name'] as String?,
          tags: json['tags'] as List<dynamic>?,
        );

Map<String, dynamic> _$BookCategoryDataNormalBooksCateNamesToJson(
        BookCategoryDataNormalBooksCateNames instance) =>
    <String, dynamic>{
      'name': instance.name,
      'tags': instance.tags,
    };

BookCategoryDataNormalBooksBookList
    _$BookCategoryDataNormalBooksBookListFromJson(Map<String, dynamic> json) =>
        BookCategoryDataNormalBooksBookList(
          isAvailable: json['isAvailable'] as int?,
          introduce: json['introduce'] as String?,
          id: json['id'] as String?,
          cateName: (json['cateName'] as List<dynamic>?)
              ?.map((e) => e == null
                  ? null
                  : BookCategoryDataNormalBooksBookListCateName.fromJson(
                      e as Map<String, dynamic>))
              .toList(),
          tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e == null
                  ? null
                  : BookCategoryDataNormalBooksBookListTags.fromJson(
                      e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$BookCategoryDataNormalBooksBookListToJson(
        BookCategoryDataNormalBooksBookList instance) =>
    <String, dynamic>{
      'isAvailable': instance.isAvailable,
      'introduce': instance.introduce,
      'id': instance.id,
      'cateName': instance.cateName?.map((e) => e?.toJson()).toList(),
      'tags': instance.tags?.map((e) => e?.toJson()).toList(),
    };

BookCategoryDataNormalBooksBookListCateName
    _$BookCategoryDataNormalBooksBookListCateNameFromJson(
            Map<String, dynamic> json) =>
        BookCategoryDataNormalBooksBookListCateName(
          name: json['name'] as String?,
          order: json['order'] as int?,
        );

Map<String, dynamic> _$BookCategoryDataNormalBooksBookListCateNameToJson(
        BookCategoryDataNormalBooksBookListCateName instance) =>
    <String, dynamic>{
      'name': instance.name,
      'order': instance.order,
    };

BookCategoryDataNormalBooksBookListTags
    _$BookCategoryDataNormalBooksBookListTagsFromJson(
            Map<String, dynamic> json) =>
        BookCategoryDataNormalBooksBookListTags(
          tagName: json['tagName'] as String?,
          tagUrl: json['tagUrl'] as String?,
        );

Map<String, dynamic> _$BookCategoryDataNormalBooksBookListTagsToJson(
        BookCategoryDataNormalBooksBookListTags instance) =>
    <String, dynamic>{
      'tagName': instance.tagName,
      'tagUrl': instance.tagUrl,
    };
