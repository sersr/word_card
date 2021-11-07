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
    this.listBooksInfo,
  });
  @JsonKey(name: 'listBooksInfo')
  final List<BookListsDataListBooksInfo>? listBooksInfo;

  factory BookListsData.fromJson(Map<String,dynamic> json) => _$BookListsDataFromJson(json);
  Map<String,dynamic> toJson() => _$BookListsDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookListsDataListBooksInfo {
  const BookListsDataListBooksInfo({
    this.cover,
    this.wordsNum,
    this.introduce,
    this.versionTs,
    this.reciteUserNum,
    this.bookName,
    this.creatorAvatar,
    this.creatorNickName,
    this.bookId,
    this.tags,
  });
  @JsonKey(name: 'cover')
  final String? cover;
  @JsonKey(name: 'wordsNum')
  final int? wordsNum;
  @JsonKey(name: 'introduce')
  final String? introduce;
  @JsonKey(name: 'versionTs')
  final int? versionTs;
  @JsonKey(name: 'reciteUserNum')
  final int? reciteUserNum;
  @JsonKey(name: 'bookName')
  final String? bookName;
  @JsonKey(name: 'creatorAvatar')
  final String? creatorAvatar;
  @JsonKey(name: 'creatorNickName')
  final String? creatorNickName;
  @JsonKey(name: 'bookId')
  final String? bookId;
  @JsonKey(name: 'tags')
  final List<String>? tags;

  factory BookListsDataListBooksInfo.fromJson(Map<String,dynamic> json) => _$BookListsDataListBooksInfoFromJson(json);
  Map<String,dynamic> toJson() => _$BookListsDataListBooksInfoToJson(this);
}

