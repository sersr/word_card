// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'words.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Words _$WordsFromJson(Map<String, dynamic> json) => Words(
      wordRank: json['wordRank'] as int?,
      headWord: json['headWord'] as String?,
      content: json['content'] == null
          ? null
          : WordsContent.fromJson(json['content'] as Map<String, dynamic>),
      bookId: json['bookId'] as String?,
    );

Map<String, dynamic> _$WordsToJson(Words instance) => <String, dynamic>{
      'wordRank': instance.wordRank,
      'headWord': instance.headWord,
      'content': instance.content?.toJson(),
      'bookId': instance.bookId,
    };

WordsContent _$WordsContentFromJson(Map<String, dynamic> json) => WordsContent(
      word: json['word'] == null
          ? null
          : WordsContentWord.fromJson(json['word'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WordsContentToJson(WordsContent instance) =>
    <String, dynamic>{
      'word': instance.word?.toJson(),
    };

WordsContentWord _$WordsContentWordFromJson(Map<String, dynamic> json) =>
    WordsContentWord(
      wordHead: json['wordHead'] as String?,
      wordId: json['wordId'] as String?,
      content: json['content'] == null
          ? null
          : WordsContentWordContent.fromJson(
              json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WordsContentWordToJson(WordsContentWord instance) =>
    <String, dynamic>{
      'wordHead': instance.wordHead,
      'wordId': instance.wordId,
      'content': instance.content?.toJson(),
    };

WordsContentWordContent _$WordsContentWordContentFromJson(
        Map<String, dynamic> json) =>
    WordsContentWordContent(
      sentence: json['sentence'] == null
          ? null
          : WordsContentWordContentSentence.fromJson(
              json['sentence'] as Map<String, dynamic>),
      usphone: json['usphone'] as String?,
      ukphone: json['ukphone'] as String?,
      ukspeech: json['ukspeech'] as String?,
      star: json['star'] as int?,
      speech: json['speech'] as String?,
      usspeech: json['usspeech'] as String?,
      trans: (json['trans'] as List<dynamic>?)
          ?.map((e) =>
              WordsContentWordContentTrans.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WordsContentWordContentToJson(
        WordsContentWordContent instance) =>
    <String, dynamic>{
      'sentence': instance.sentence?.toJson(),
      'usphone': instance.usphone,
      'ukphone': instance.ukphone,
      'ukspeech': instance.ukspeech,
      'star': instance.star,
      'speech': instance.speech,
      'usspeech': instance.usspeech,
      'trans': instance.trans?.map((e) => e.toJson()).toList(),
    };

WordsContentWordContentSentence _$WordsContentWordContentSentenceFromJson(
        Map<String, dynamic> json) =>
    WordsContentWordContentSentence(
      sentences: (json['sentences'] as List<dynamic>?)
          ?.map((e) => WordsContentWordContentSentenceSentences.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$WordsContentWordContentSentenceToJson(
        WordsContentWordContentSentence instance) =>
    <String, dynamic>{
      'sentences': instance.sentences?.map((e) => e.toJson()).toList(),
      'desc': instance.desc,
    };

WordsContentWordContentSentenceSentences
    _$WordsContentWordContentSentenceSentencesFromJson(
            Map<String, dynamic> json) =>
        WordsContentWordContentSentenceSentences(
          sContent: json['sContent'] as String?,
          sCn: json['sCn'] as String?,
        );

Map<String, dynamic> _$WordsContentWordContentSentenceSentencesToJson(
        WordsContentWordContentSentenceSentences instance) =>
    <String, dynamic>{
      'sContent': instance.sContent,
      'sCn': instance.sCn,
    };

WordsContentWordContentTrans _$WordsContentWordContentTransFromJson(
        Map<String, dynamic> json) =>
    WordsContentWordContentTrans(
      tranCn: json['tranCn'] as String?,
      descOther: json['descOther'] as String?,
      descCn: json['descCn'] as String?,
      pos: json['pos'] as String?,
      tranOther: json['tranOther'] as String?,
    );

Map<String, dynamic> _$WordsContentWordContentTransToJson(
        WordsContentWordContentTrans instance) =>
    <String, dynamic>{
      'tranCn': instance.tranCn,
      'descOther': instance.descOther,
      'descCn': instance.descCn,
      'pos': instance.pos,
      'tranOther': instance.tranOther,
    };
