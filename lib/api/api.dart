class Api {
  static String bookListsUrl() {
    return 'http://reciteword.youdao.com/reciteword/v1/param?key=normalBooks';
  }

  /// post
  static String bookWordsDataUrl() {
    // return 'http://reciteword.youdao.com/reciteword/v1/getBooksInfo';
    return 'http://reciteword.youdao.com/reciteword/v1/getBooksInfo';
  }

  static String wordVoiceUrl(String query) {
    return 'https://dict.youdao.com/dictvoice?audio=$query';
  }
}
// 详细
// https://dict.youdao.com/jsonapi?jsonversion=2&client=mobile&q=meet&le=eng

// 简略
// http://dict.youdao.com/jsonapi?jsonversion=2&client=mobile&le=eng&dicts=%7b%22count%22%3a%2299%22%2c%22dicts%22%3a%5b%5b%22ec%22%5d%2c%5b%22fanyi%22%5d%5d%7d&q=copenhagen

// http://dict.youdao.com/jsonapi?jsonversion=2&client=mobile&le=eng&dicts={"count":"99","dicts":[["ec"],["fanyi"]]}&q=copenhagen


// http://reciteword.youdao.com/reciteword/v1/getBooksInfo?screen=900x1600&mid=7.1.
// 2&imei=CQkxMGI2NTc1YThiZjczNTJlCTc1YThiZjczNTJlMTBiNjU%253D&keyfrom=reciteword.1.5.12.android&vendor=index&version=1.5.12&model=TAS-AN00

// http://reciteword.youdao.com/reciteword/v1/getBooksInfo?screen=900x1600&mid=
// 7.1.2&imei=CQkxMGI2NTc1YThiZjczNTJlCTc1YThiZjczNTJlMTBiNjU%253D&keyfrom=
// reciteword.1.5.12.android&vendor=index&version=1.5.12&model=TAS-AN00
