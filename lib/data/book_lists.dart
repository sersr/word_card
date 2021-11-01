import 'package:json_annotation/json_annotation.dart';

part 'book_lists.g.dart';

@JsonSerializable()
class BookLists {
  const BookLists({
    this.reason,
    this.code,
    this.data,
  });
  @JsonKey(name: 'reason')
  final String? reason;
  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'data')
  final BookListsData? data;

  factory BookLists.fromJson(Map<String,dynamic> json) => _$BookListsFromJson(json);
  Map<String,dynamic> toJson() => _$BookListsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookListsData {
  const BookListsData({
    this.normalBooksInfo,
  });
  @JsonKey(name: 'normalBooksInfo')
  final List<BookListsDataNormalBooksInfo>? normalBooksInfo;

  factory BookListsData.fromJson(Map<String,dynamic> json) => _$BookListsDataFromJson(json);
  Map<String,dynamic> toJson() => _$BookListsDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookListsDataNormalBooksInfo {
  const BookListsDataNormalBooksInfo({
    this.cover,
    this.bookOrigin,
    this.size,
    this.introduce,
    this.wordNum,
    this.reciteUserNum,
    this.id,
    this.title,
    this.offlinedata,
    this.version,
    this.tags,
  });
  @JsonKey(name: 'cover')
  final String? cover;
  @JsonKey(name: 'bookOrigin')
  final BookListsDataNormalBooksInfoBookOrigin? bookOrigin;
  @JsonKey(name: 'size')
  final int? size;
  @JsonKey(name: 'introduce')
  final String? introduce;
  @JsonKey(name: 'wordNum')
  final int? wordNum;
  @JsonKey(name: 'reciteUserNum')
  final int? reciteUserNum;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'offlinedata')
  final String? offlinedata;
  @JsonKey(name: 'version')
  final String? version;
  @JsonKey(name: 'tags')
  final List<BookListsDataNormalBooksInfoTags>? tags;

  factory BookListsDataNormalBooksInfo.fromJson(Map<String,dynamic> json) => _$BookListsDataNormalBooksInfoFromJson(json);
  Map<String,dynamic> toJson() => _$BookListsDataNormalBooksInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookListsDataNormalBooksInfoBookOrigin {
  const BookListsDataNormalBooksInfoBookOrigin({
    this.originUrl,
    this.desc,
    this.originName,
  });
  @JsonKey(name: 'originUrl')
  final String? originUrl;
  @JsonKey(name: 'desc')
  final String? desc;
  @JsonKey(name: 'originName')
  final String? originName;

  factory BookListsDataNormalBooksInfoBookOrigin.fromJson(Map<String,dynamic> json) => _$BookListsDataNormalBooksInfoBookOriginFromJson(json);
  Map<String,dynamic> toJson() => _$BookListsDataNormalBooksInfoBookOriginToJson(this);
}


@JsonSerializable(explicitToJson: true)
class BookListsDataNormalBooksInfoTags {
  const BookListsDataNormalBooksInfoTags({
    this.tagName,
    this.tagUrl,
  });
  @JsonKey(name: 'tagName')
  final String? tagName;
  @JsonKey(name: 'tagUrl')
  final String? tagUrl;

  factory BookListsDataNormalBooksInfoTags.fromJson(Map<String,dynamic> json) => _$BookListsDataNormalBooksInfoTagsFromJson(json);
  Map<String,dynamic> toJson() => _$BookListsDataNormalBooksInfoTagsToJson(this);
}

