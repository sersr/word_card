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
      realExamSentence: json['realExamSentence'] == null
          ? null
          : WordsContentWordContentRealExamSentence.fromJson(
              json['realExamSentence'] as Map<String, dynamic>),
      usphone: json['usphone'] as String?,
      ukspeech: json['ukspeech'] as String?,
      star: json['star'] as int?,
      usspeech: json['usspeech'] as String?,
      syno: json['syno'] == null
          ? null
          : WordsContentWordContentSyno.fromJson(
              json['syno'] as Map<String, dynamic>),
      ukphone: json['ukphone'] as String?,
      phrase: json['phrase'] == null
          ? null
          : WordsContentWordContentPhrase.fromJson(
              json['phrase'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      speech: json['speech'] as String?,
      remMethod: json['remMethod'] == null
          ? null
          : WordsContentWordContentRemMethod.fromJson(
              json['remMethod'] as Map<String, dynamic>),
      relWord: json['relWord'] == null
          ? null
          : WordsContentWordContentRelWord.fromJson(
              json['relWord'] as Map<String, dynamic>),
      trans: (json['trans'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : WordsContentWordContentTrans.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WordsContentWordContentToJson(
        WordsContentWordContent instance) =>
    <String, dynamic>{
      'sentence': instance.sentence?.toJson(),
      'realExamSentence': instance.realExamSentence?.toJson(),
      'usphone': instance.usphone,
      'ukspeech': instance.ukspeech,
      'star': instance.star,
      'usspeech': instance.usspeech,
      'syno': instance.syno?.toJson(),
      'ukphone': instance.ukphone,
      'phrase': instance.phrase?.toJson(),
      'phone': instance.phone,
      'speech': instance.speech,
      'remMethod': instance.remMethod?.toJson(),
      'relWord': instance.relWord?.toJson(),
      'trans': instance.trans?.map((e) => e?.toJson()).toList(),
    };

WordsContentWordContentSentence _$WordsContentWordContentSentenceFromJson(
        Map<String, dynamic> json) =>
    WordsContentWordContentSentence(
      sentences: (json['sentences'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : WordsContentWordContentSentenceSentences.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$WordsContentWordContentSentenceToJson(
        WordsContentWordContentSentence instance) =>
    <String, dynamic>{
      'sentences': instance.sentences?.map((e) => e?.toJson()).toList(),
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

WordsContentWordContentRealExamSentence
    _$WordsContentWordContentRealExamSentenceFromJson(
            Map<String, dynamic> json) =>
        WordsContentWordContentRealExamSentence(
          sentences: (json['sentences'] as List<dynamic>?)
              ?.map((e) => e == null
                  ? null
                  : WordsContentWordContentRealExamSentenceSentences.fromJson(
                      e as Map<String, dynamic>))
              .toList(),
          desc: json['desc'] as String?,
        );

Map<String, dynamic> _$WordsContentWordContentRealExamSentenceToJson(
        WordsContentWordContentRealExamSentence instance) =>
    <String, dynamic>{
      'sentences': instance.sentences?.map((e) => e?.toJson()).toList(),
      'desc': instance.desc,
    };

WordsContentWordContentRealExamSentenceSentences
    _$WordsContentWordContentRealExamSentenceSentencesFromJson(
            Map<String, dynamic> json) =>
        WordsContentWordContentRealExamSentenceSentences(
          sContent: json['sContent'] as String?,
          sourceInfo: json['sourceInfo'] == null
              ? null
              : WordsContentWordContentRealExamSentenceSentencesSourceInfo
                  .fromJson(json['sourceInfo'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$WordsContentWordContentRealExamSentenceSentencesToJson(
        WordsContentWordContentRealExamSentenceSentences instance) =>
    <String, dynamic>{
      'sContent': instance.sContent,
      'sourceInfo': instance.sourceInfo?.toJson(),
    };

WordsContentWordContentRealExamSentenceSentencesSourceInfo
    _$WordsContentWordContentRealExamSentenceSentencesSourceInfoFromJson(
            Map<String, dynamic> json) =>
        WordsContentWordContentRealExamSentenceSentencesSourceInfo(
          paper: json['paper'] as String?,
          level: json['level'] as String?,
          year: json['year'] as String?,
          type: json['type'] as String?,
        );

Map<String,
    dynamic> _$WordsContentWordContentRealExamSentenceSentencesSourceInfoToJson(
        WordsContentWordContentRealExamSentenceSentencesSourceInfo instance) =>
    <String, dynamic>{
      'paper': instance.paper,
      'level': instance.level,
      'year': instance.year,
      'type': instance.type,
    };

WordsContentWordContentSyno _$WordsContentWordContentSynoFromJson(
        Map<String, dynamic> json) =>
    WordsContentWordContentSyno(
      synos: (json['synos'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : WordsContentWordContentSynoSynos.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$WordsContentWordContentSynoToJson(
        WordsContentWordContentSyno instance) =>
    <String, dynamic>{
      'synos': instance.synos?.map((e) => e?.toJson()).toList(),
      'desc': instance.desc,
    };

WordsContentWordContentSynoSynos _$WordsContentWordContentSynoSynosFromJson(
        Map<String, dynamic> json) =>
    WordsContentWordContentSynoSynos(
      pos: json['pos'] as String?,
      tran: json['tran'] as String?,
      hwds: (json['hwds'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : WordsContentWordContentSynoSynosHwds.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WordsContentWordContentSynoSynosToJson(
        WordsContentWordContentSynoSynos instance) =>
    <String, dynamic>{
      'pos': instance.pos,
      'tran': instance.tran,
      'hwds': instance.hwds?.map((e) => e?.toJson()).toList(),
    };

WordsContentWordContentSynoSynosHwds
    _$WordsContentWordContentSynoSynosHwdsFromJson(Map<String, dynamic> json) =>
        WordsContentWordContentSynoSynosHwds(
          w: json['w'] as String?,
        );

Map<String, dynamic> _$WordsContentWordContentSynoSynosHwdsToJson(
        WordsContentWordContentSynoSynosHwds instance) =>
    <String, dynamic>{
      'w': instance.w,
    };

WordsContentWordContentPhrase _$WordsContentWordContentPhraseFromJson(
        Map<String, dynamic> json) =>
    WordsContentWordContentPhrase(
      phrases: (json['phrases'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : WordsContentWordContentPhrasePhrases.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$WordsContentWordContentPhraseToJson(
        WordsContentWordContentPhrase instance) =>
    <String, dynamic>{
      'phrases': instance.phrases?.map((e) => e?.toJson()).toList(),
      'desc': instance.desc,
    };

WordsContentWordContentPhrasePhrases
    _$WordsContentWordContentPhrasePhrasesFromJson(Map<String, dynamic> json) =>
        WordsContentWordContentPhrasePhrases(
          pContent: json['pContent'] as String?,
          pCn: json['pCn'] as String?,
        );

Map<String, dynamic> _$WordsContentWordContentPhrasePhrasesToJson(
        WordsContentWordContentPhrasePhrases instance) =>
    <String, dynamic>{
      'pContent': instance.pContent,
      'pCn': instance.pCn,
    };

WordsContentWordContentRemMethod _$WordsContentWordContentRemMethodFromJson(
        Map<String, dynamic> json) =>
    WordsContentWordContentRemMethod(
      val: json['val'] as String?,
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$WordsContentWordContentRemMethodToJson(
        WordsContentWordContentRemMethod instance) =>
    <String, dynamic>{
      'val': instance.val,
      'desc': instance.desc,
    };

WordsContentWordContentRelWord _$WordsContentWordContentRelWordFromJson(
        Map<String, dynamic> json) =>
    WordsContentWordContentRelWord(
      rels: (json['rels'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : WordsContentWordContentRelWordRels.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$WordsContentWordContentRelWordToJson(
        WordsContentWordContentRelWord instance) =>
    <String, dynamic>{
      'rels': instance.rels?.map((e) => e?.toJson()).toList(),
      'desc': instance.desc,
    };

WordsContentWordContentRelWordRels _$WordsContentWordContentRelWordRelsFromJson(
        Map<String, dynamic> json) =>
    WordsContentWordContentRelWordRels(
      pos: json['pos'] as String?,
      words: (json['words'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : WordsContentWordContentRelWordRelsWords.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WordsContentWordContentRelWordRelsToJson(
        WordsContentWordContentRelWordRels instance) =>
    <String, dynamic>{
      'pos': instance.pos,
      'words': instance.words?.map((e) => e?.toJson()).toList(),
    };

WordsContentWordContentRelWordRelsWords
    _$WordsContentWordContentRelWordRelsWordsFromJson(
            Map<String, dynamic> json) =>
        WordsContentWordContentRelWordRelsWords(
          hwd: json['hwd'] as String?,
          tran: json['tran'] as String?,
        );

Map<String, dynamic> _$WordsContentWordContentRelWordRelsWordsToJson(
        WordsContentWordContentRelWordRelsWords instance) =>
    <String, dynamic>{
      'hwd': instance.hwd,
      'tran': instance.tran,
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
