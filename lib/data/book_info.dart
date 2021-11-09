import 'package:json_annotation/json_annotation.dart';

part 'book_info.g.dart';

@JsonSerializable(explicitToJson: true)
class BookInfo {
  const BookInfo({
    this.reason,
    this.code,
    this.data,
  });
  @JsonKey(name: 'reason')
  final String? reason;
  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'data')
  final BookInfoData? data;

  factory BookInfo.fromJson(Map<String,dynamic> json) => _$BookInfoFromJson(json);
  Map<String,dynamic> toJson() => _$BookInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookInfoData {
  const BookInfoData({
    this.normalBooksInfo,
  });
  @JsonKey(name: 'normalBooksInfo')
  final List<BookInfoDataNormalBooksInfo>? normalBooksInfo;

  factory BookInfoData.fromJson(Map<String,dynamic> json) => _$BookInfoDataFromJson(json);
  Map<String,dynamic> toJson() => _$BookInfoDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookInfoDataNormalBooksInfo {
  const BookInfoDataNormalBooksInfo({
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
  final BookInfoDataNormalBooksInfoBookOrigin? bookOrigin;
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
  final List<BookInfoDataNormalBooksInfoTags>? tags;

  factory BookInfoDataNormalBooksInfo.fromJson(Map<String,dynamic> json) => _$BookInfoDataNormalBooksInfoFromJson(json);
  Map<String,dynamic> toJson() => _$BookInfoDataNormalBooksInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookInfoDataNormalBooksInfoBookOrigin {
  const BookInfoDataNormalBooksInfoBookOrigin({
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

  factory BookInfoDataNormalBooksInfoBookOrigin.fromJson(Map<String,dynamic> json) => _$BookInfoDataNormalBooksInfoBookOriginFromJson(json);
  Map<String,dynamic> toJson() => _$BookInfoDataNormalBooksInfoBookOriginToJson(this);
}


@JsonSerializable(explicitToJson: true)
class BookInfoDataNormalBooksInfoTags {
  const BookInfoDataNormalBooksInfoTags({
    this.tagName,
    this.tagUrl,
  });
  @JsonKey(name: 'tagName')
  final String? tagName;
  @JsonKey(name: 'tagUrl')
  final String? tagUrl;

  factory BookInfoDataNormalBooksInfoTags.fromJson(Map<String,dynamic> json) => _$BookInfoDataNormalBooksInfoTagsFromJson(json);
  Map<String,dynamic> toJson() => _$BookInfoDataNormalBooksInfoTagsToJson(this);
}

