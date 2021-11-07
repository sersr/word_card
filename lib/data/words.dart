import 'package:json_annotation/json_annotation.dart';

part 'words.g.dart';

@JsonSerializable()
class Words {
  const Words({
    this.wordRank,
    this.headWord,
    this.content,
    this.bookId,
  });
  @JsonKey(name: 'wordRank')
  final int? wordRank;
  @JsonKey(name: 'headWord')
  final String? headWord;
  @JsonKey(name: 'content')
  final WordsContent? content;
  @JsonKey(name: 'bookId')
  final String? bookId;

  factory Words.fromJson(Map<String,dynamic> json) => _$WordsFromJson(json);
  Map<String,dynamic> toJson() => _$WordsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WordsContent {
  const WordsContent({
    this.word,
  });
  @JsonKey(name: 'word')
  final WordsContentWord? word;

  factory WordsContent.fromJson(Map<String,dynamic> json) => _$WordsContentFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WordsContentWord {
  const WordsContentWord({
    this.wordHead,
    this.wordId,
    this.content,
  });
  @JsonKey(name: 'wordHead')
  final String? wordHead;
  @JsonKey(name: 'wordId')
  final String? wordId;
  @JsonKey(name: 'content')
  final WordsContentWordContent? content;

  factory WordsContentWord.fromJson(Map<String,dynamic> json) => _$WordsContentWordFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WordsContentWordContent {
  const WordsContentWordContent({
    this.sentence,
    this.usphone,
    this.ukphone,
    this.ukspeech,
    this.star,
    this.speech,
    this.usspeech,
    this.trans,
  });
  @JsonKey(name: 'sentence')
  final WordsContentWordContentSentence? sentence;
  @JsonKey(name: 'usphone')
  final String? usphone;
  @JsonKey(name: 'ukphone')
  final String? ukphone;
  @JsonKey(name: 'ukspeech')
  final String? ukspeech;
  @JsonKey(name: 'star')
  final int? star;
  @JsonKey(name: 'speech')
  final String? speech;
  @JsonKey(name: 'usspeech')
  final String? usspeech;
  @JsonKey(name: 'trans')
  final List<WordsContentWordContentTrans>? trans;

  factory WordsContentWordContent.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WordsContentWordContentSentence {
  const WordsContentWordContentSentence({
    this.sentences,
    this.desc,
  });
  @JsonKey(name: 'sentences')
  final List<WordsContentWordContentSentenceSentences>? sentences;
  @JsonKey(name: 'desc')
  final String? desc;

  factory WordsContentWordContentSentence.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentSentenceFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentSentenceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WordsContentWordContentSentenceSentences {
  const WordsContentWordContentSentenceSentences({
    this.sContent,
    this.sCn,
  });
  @JsonKey(name: 'sContent')
  final String? sContent;
  @JsonKey(name: 'sCn')
  final String? sCn;

  factory WordsContentWordContentSentenceSentences.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentSentenceSentencesFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentSentenceSentencesToJson(this);
}


@JsonSerializable(explicitToJson: true)
class WordsContentWordContentTrans {
  const WordsContentWordContentTrans({
    this.tranCn,
    this.descOther,
    this.descCn,
    this.pos,
    this.tranOther,
  });
  @JsonKey(name: 'tranCn')
  final String? tranCn;
  @JsonKey(name: 'descOther')
  final String? descOther;
  @JsonKey(name: 'descCn')
  final String? descCn;
  @JsonKey(name: 'pos')
  final String? pos;
  @JsonKey(name: 'tranOther')
  final String? tranOther;

  factory WordsContentWordContentTrans.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentTransFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentTransToJson(this);
}

