import 'package:json_annotation/json_annotation.dart';

part 'words.g.dart';

@JsonSerializable(explicitToJson: true)
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
    this.realExamSentence,
    this.usphone,
    this.ukspeech,
    this.star,
    this.usspeech,
    this.syno,
    this.ukphone,
    this.phrase,
    this.phone,
    this.speech,
    this.remMethod,
    this.relWord,
    this.trans,
  });
  @JsonKey(name: 'sentence')
  final WordsContentWordContentSentence? sentence;
  @JsonKey(name: 'realExamSentence')
  final WordsContentWordContentRealExamSentence? realExamSentence;
  @JsonKey(name: 'usphone')
  final String? usphone;
  @JsonKey(name: 'ukspeech')
  final String? ukspeech;
  @JsonKey(name: 'star')
  final int? star;
  @JsonKey(name: 'usspeech')
  final String? usspeech;
  @JsonKey(name: 'syno')
  final WordsContentWordContentSyno? syno;
  @JsonKey(name: 'ukphone')
  final String? ukphone;
  @JsonKey(name: 'phrase')
  final WordsContentWordContentPhrase? phrase;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'speech')
  final String? speech;
  @JsonKey(name: 'remMethod')
  final WordsContentWordContentRemMethod? remMethod;
  @JsonKey(name: 'relWord')
  final WordsContentWordContentRelWord? relWord;
  @JsonKey(name: 'trans')
  final List<WordsContentWordContentTrans?>? trans;

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
  final List<WordsContentWordContentSentenceSentences?>? sentences;
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
class WordsContentWordContentRealExamSentence {
  const WordsContentWordContentRealExamSentence({
    this.sentences,
    this.desc,
  });
  @JsonKey(name: 'sentences')
  final List<WordsContentWordContentRealExamSentenceSentences?>? sentences;
  @JsonKey(name: 'desc')
  final String? desc;

  factory WordsContentWordContentRealExamSentence.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentRealExamSentenceFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentRealExamSentenceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WordsContentWordContentRealExamSentenceSentences {
  const WordsContentWordContentRealExamSentenceSentences({
    this.sContent,
    this.sourceInfo,
  });
  @JsonKey(name: 'sContent')
  final String? sContent;
  @JsonKey(name: 'sourceInfo')
  final WordsContentWordContentRealExamSentenceSentencesSourceInfo? sourceInfo;

  factory WordsContentWordContentRealExamSentenceSentences.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentRealExamSentenceSentencesFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentRealExamSentenceSentencesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WordsContentWordContentRealExamSentenceSentencesSourceInfo {
  const WordsContentWordContentRealExamSentenceSentencesSourceInfo({
    this.paper,
    this.level,
    this.year,
    this.type,
  });
  @JsonKey(name: 'paper')
  final String? paper;
  @JsonKey(name: 'level')
  final String? level;
  @JsonKey(name: 'year')
  final String? year;
  @JsonKey(name: 'type')
  final String? type;

  factory WordsContentWordContentRealExamSentenceSentencesSourceInfo.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentRealExamSentenceSentencesSourceInfoFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentRealExamSentenceSentencesSourceInfoToJson(this);
}


@JsonSerializable(explicitToJson: true)
class WordsContentWordContentSyno {
  const WordsContentWordContentSyno({
    this.synos,
    this.desc,
  });
  @JsonKey(name: 'synos')
  final List<WordsContentWordContentSynoSynos?>? synos;
  @JsonKey(name: 'desc')
  final String? desc;

  factory WordsContentWordContentSyno.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentSynoFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentSynoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WordsContentWordContentSynoSynos {
  const WordsContentWordContentSynoSynos({
    this.pos,
    this.tran,
    this.hwds,
  });
  @JsonKey(name: 'pos')
  final String? pos;
  @JsonKey(name: 'tran')
  final String? tran;
  @JsonKey(name: 'hwds')
  final List<WordsContentWordContentSynoSynosHwds?>? hwds;

  factory WordsContentWordContentSynoSynos.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentSynoSynosFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentSynoSynosToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WordsContentWordContentSynoSynosHwds {
  const WordsContentWordContentSynoSynosHwds({
    this.w,
  });
  @JsonKey(name: 'w')
  final String? w;

  factory WordsContentWordContentSynoSynosHwds.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentSynoSynosHwdsFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentSynoSynosHwdsToJson(this);
}


@JsonSerializable(explicitToJson: true)
class WordsContentWordContentPhrase {
  const WordsContentWordContentPhrase({
    this.phrases,
    this.desc,
  });
  @JsonKey(name: 'phrases')
  final List<WordsContentWordContentPhrasePhrases?>? phrases;
  @JsonKey(name: 'desc')
  final String? desc;

  factory WordsContentWordContentPhrase.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentPhraseFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentPhraseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WordsContentWordContentPhrasePhrases {
  const WordsContentWordContentPhrasePhrases({
    this.pContent,
    this.pCn,
  });
  @JsonKey(name: 'pContent')
  final String? pContent;
  @JsonKey(name: 'pCn')
  final String? pCn;

  factory WordsContentWordContentPhrasePhrases.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentPhrasePhrasesFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentPhrasePhrasesToJson(this);
}


@JsonSerializable(explicitToJson: true)
class WordsContentWordContentRemMethod {
  const WordsContentWordContentRemMethod({
    this.val,
    this.desc,
  });
  @JsonKey(name: 'val')
  final String? val;
  @JsonKey(name: 'desc')
  final String? desc;

  factory WordsContentWordContentRemMethod.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentRemMethodFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentRemMethodToJson(this);
}


@JsonSerializable(explicitToJson: true)
class WordsContentWordContentRelWord {
  const WordsContentWordContentRelWord({
    this.rels,
    this.desc,
  });
  @JsonKey(name: 'rels')
  final List<WordsContentWordContentRelWordRels?>? rels;
  @JsonKey(name: 'desc')
  final String? desc;

  factory WordsContentWordContentRelWord.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentRelWordFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentRelWordToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WordsContentWordContentRelWordRels {
  const WordsContentWordContentRelWordRels({
    this.pos,
    this.words,
  });
  @JsonKey(name: 'pos')
  final String? pos;
  @JsonKey(name: 'words')
  final List<WordsContentWordContentRelWordRelsWords?>? words;

  factory WordsContentWordContentRelWordRels.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentRelWordRelsFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentRelWordRelsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WordsContentWordContentRelWordRelsWords {
  const WordsContentWordContentRelWordRelsWords({
    this.hwd,
    this.tran,
  });
  @JsonKey(name: 'hwd')
  final String? hwd;
  @JsonKey(name: 'tran')
  final String? tran;

  factory WordsContentWordContentRelWordRelsWords.fromJson(Map<String,dynamic> json) => _$WordsContentWordContentRelWordRelsWordsFromJson(json);
  Map<String,dynamic> toJson() => _$WordsContentWordContentRelWordRelsWordsToJson(this);
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

