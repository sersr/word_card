import 'package:json_annotation/json_annotation.dart';

part 'book_category.g.dart';

@JsonSerializable(explicitToJson: true)
class BookCategory {
  const BookCategory({
    this.reason,
    this.code,
    this.data,
  });
  @JsonKey(name: 'reason')
  final String? reason;
  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'data')
  final BookCategoryData? data;

  factory BookCategory.fromJson(Map<String,dynamic> json) => _$BookCategoryFromJson(json);
  Map<String,dynamic> toJson() => _$BookCategoryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookCategoryData {
  const BookCategoryData({
    this.normalBooks,
    this.version,
  });
  @JsonKey(name: 'normalBooks')
  final BookCategoryDataNormalBooks? normalBooks;
  @JsonKey(name: 'version')
  final int? version;

  factory BookCategoryData.fromJson(Map<String,dynamic> json) => _$BookCategoryDataFromJson(json);
  Map<String,dynamic> toJson() => _$BookCategoryDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookCategoryDataNormalBooks {
  const BookCategoryDataNormalBooks({
    this.cateNames,
    this.bookList,
  });
  @JsonKey(name: 'cateNames')
  final List<BookCategoryDataNormalBooksCateNames?>? cateNames;
  @JsonKey(name: 'bookList')
  final List<BookCategoryDataNormalBooksBookList?>? bookList;

  factory BookCategoryDataNormalBooks.fromJson(Map<String,dynamic> json) => _$BookCategoryDataNormalBooksFromJson(json);
  Map<String,dynamic> toJson() => _$BookCategoryDataNormalBooksToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookCategoryDataNormalBooksCateNames {
  const BookCategoryDataNormalBooksCateNames({
    this.name,
    this.tags,
  });
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'tags')
  final List<dynamic>? tags;

  factory BookCategoryDataNormalBooksCateNames.fromJson(Map<String,dynamic> json) => _$BookCategoryDataNormalBooksCateNamesFromJson(json);
  Map<String,dynamic> toJson() => _$BookCategoryDataNormalBooksCateNamesToJson(this);
}


@JsonSerializable(explicitToJson: true)
class BookCategoryDataNormalBooksBookList {
  const BookCategoryDataNormalBooksBookList({
    this.isAvailable,
    this.introduce,
    this.id,
    this.cateName,
    this.tags,
  });
  @JsonKey(name: 'isAvailable')
  final int? isAvailable;
  @JsonKey(name: 'introduce')
  final String? introduce;
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'cateName')
  final List<BookCategoryDataNormalBooksBookListCateName?>? cateName;
  @JsonKey(name: 'tags')
  final List<BookCategoryDataNormalBooksBookListTags?>? tags;

  factory BookCategoryDataNormalBooksBookList.fromJson(Map<String,dynamic> json) => _$BookCategoryDataNormalBooksBookListFromJson(json);
  Map<String,dynamic> toJson() => _$BookCategoryDataNormalBooksBookListToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BookCategoryDataNormalBooksBookListCateName {
  const BookCategoryDataNormalBooksBookListCateName({
    this.name,
    this.order,
  });
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'order')
  final int? order;

  factory BookCategoryDataNormalBooksBookListCateName.fromJson(Map<String,dynamic> json) => _$BookCategoryDataNormalBooksBookListCateNameFromJson(json);
  Map<String,dynamic> toJson() => _$BookCategoryDataNormalBooksBookListCateNameToJson(this);
}


@JsonSerializable(explicitToJson: true)
class BookCategoryDataNormalBooksBookListTags {
  const BookCategoryDataNormalBooksBookListTags({
    this.tagName,
    this.tagUrl,
  });
  @JsonKey(name: 'tagName')
  final String? tagName;
  @JsonKey(name: 'tagUrl')
  final String? tagUrl;

  factory BookCategoryDataNormalBooksBookListTags.fromJson(Map<String,dynamic> json) => _$BookCategoryDataNormalBooksBookListTagsFromJson(json);
  Map<String,dynamic> toJson() => _$BookCategoryDataNormalBooksBookListTagsToJson(this);
}

