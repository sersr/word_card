class Api {
  static bookListsUrl() {
    return 'http://reciteword.youdao.com/reciteword/v1/param?key=normalBooks';
  }
  /// post
  static bookWordsDataUrl() {
    // return 'http://reciteword.youdao.com/reciteword/v1/getBooksInfo';
    return 'http://reciteword.youdao.com/reciteword/v1/getBooksInfo';
  }
}
// http://reciteword.youdao.com/reciteword/v1/getBooksInfo?screen=900x1600&mid=7.1.
// 2&imei=CQkxMGI2NTc1YThiZjczNTJlCTc1YThiZjczNTJlMTBiNjU%253D&keyfrom=reciteword.1.5.12.android&vendor=index&version=1.5.12&model=TAS-AN00

// http://reciteword.youdao.com/reciteword/v1/getBooksInfo?screen=900x1600&mid=
// 7.1.2&imei=CQkxMGI2NTc1YThiZjczNTJlCTc1YThiZjczNTJlMTBiNjU%253D&keyfrom=
// reciteword.1.5.12.android&vendor=index&version=1.5.12&model=TAS-AN00
