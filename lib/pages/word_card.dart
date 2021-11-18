// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:useful_tools/useful_tools.dart';

import '../data/words.dart';
import '../database/dict_database.dart';
import '../provider/home_list.dart';
import '../provider/word_card.dart';
import '../widgets/search_fake.dart';

class WordCardProvider extends StatelessWidget {
  const WordCardProvider({
    Key? key,
    required this.id,
    required this.currentIndex,
    required this.max,
  }) : super(key: key);
  final String id;
  final int currentIndex;
  final int max;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WordCardNotifier(context.read()),
      child: _WordCardMain(id: id, currentIndex: currentIndex, max: max),
    );
  }
}

class _WordCardMain extends StatefulWidget {
  const _WordCardMain({
    Key? key,
    required this.id,
    required this.currentIndex,
    required this.max,
  }) : super(key: key);
  final String id;
  final int currentIndex;
  final int max;
  @override
  State<_WordCardMain> createState() => _WordCardMainState();
}

class _WordCardMainState extends State<_WordCardMain> {
  late WordCardNotifier wordCardNotifier;
  late HomeListNotifier homeListNotifier;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    wordCardNotifier = context.read();
    homeListNotifier = context.read();
    wordCardNotifier.loadData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await homeListNotifier.load();
        return true;
      },
      child: Scaffold(
          body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 56,
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: const [
                  Back(),
                  SizedBox(width: 5),
                  Expanded(child: SearchFake(hint: '查找单词')),
                ],
              ),
            ),
            Expanded(
                child: WordCard(
              max: widget.max,
              currentIndex: widget.currentIndex,
              dictId: widget.id,
            ))
          ],
        ),
      )),
    );
  }
}

class WordCard extends StatefulWidget {
  const WordCard(
      {Key? key,
      required this.max,
      required this.currentIndex,
      required this.dictId})
      : super(key: key);
  final int max;
  final int currentIndex;
  final String dictId;
  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  late PageController controller;
  late WordCardNotifier notifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    notifier = context.read();
  }

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.currentIndex - 1);
  }

  void Function(TextSelection selection, SelectionChangedCause cause) {}

  Widget genTrans(String lan, Iterable<String?>? data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$lan: ',
          style: const TextStyle(
              color: Color.fromRGBO(100, 90, 100, 1), fontSize: 15),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data != null)
                for (var item in data)
                  WordCardSelection(
                    text: '$item',
                    style: const TextStyle(
                        color: Color.fromRGBO(100, 90, 100, 1), fontSize: 15),
                  )
            ],
          ),
        )
      ],
    );
  }

  bool get show =>
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux;

  /// 头部，显示单词
  Widget wordWidget(String? word, String? usphone, String? ukphone,
      String? usspeech, String? ukspeech) {
    return Bannel(
      radius: 8,
      color: Colors.grey.shade200,
      child: InkWell(
        onTap: () {
          notifier.play(usspeech);
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  '$word',
                  style: const TextStyle(
                      fontSize: 35,
                      leadingDistribution: TextLeadingDistribution.even),
                ),
              ),
              const Icon(Icons.volume_up_rounded,
                  size: 35, color: Color.fromRGBO(40, 160, 40, 1))
            ],
          ),
          if (usphone != null || ukphone != null)
            Row(
              children: [
                if (usphone != null)
                  btn1(
                    bgColor: Colors.grey.shade200,
                    splashColor: Colors.grey.shade400,
                    onTap: () {
                      notifier.play(usspeech);
                    },
                    child: Text(
                      '美: [$usphone]',
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 15),
                    ),
                  ),
                if (usphone != null) const SizedBox(width: 5),
                if (ukphone != null)
                  btn1(
                    bgColor: Colors.grey.shade200,
                    splashColor: Colors.grey.shade400,
                    onTap: () {
                      notifier.play(ukspeech);
                    },
                    child: Text(
                      '英: [$ukphone]',
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 15),
                    ),
                  )
              ],
            )
        ]),
      ),
    );
  }

  /// 单词释义
  Widget tranWidget(Iterable<String?>? tranCn, Iterable<String?>? tranOther) {
    final tranOtherIsNotEmpty = tranOther?.isNotEmpty == true;
    final tranCnIsNotEmpty = tranCn?.isNotEmpty == true;
    return Bannel(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('释义',
                    style: const TextStyle(
                        color: Color.fromRGBO(140, 150, 145, 1))),
                if (tranCnIsNotEmpty) genTrans('中', tranCn),
                if (tranOtherIsNotEmpty) const SizedBox(height: 4),
                if (tranOtherIsNotEmpty) genTrans('英', tranOther),
              ],
            ),
          ),
        ],
      ),
      color: Colors.grey.shade200,
      radius: 8,
    );
  }

  /// 例句
  Widget sentencesWidget(
      String? desc, List<WordsContentWordContentSentenceSentences?> sentences) {
    return Bannel(
      color: Colors.grey.shade200,
      radius: 8,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (desc != null)
                  Text(
                    desc,
                    style: const TextStyle(
                      color: Color.fromRGBO(140, 150, 145, 1),
                    ),
                  ),
                for (var item in sentences)
                  if ((item?.sCn != null || item?.sContent != null) &&
                      item != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                WordCardSelection(
                                  text: '${item.sContent}',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(40, 30, 40, 1),
                                      fontSize: 15),
                                ),
                                if (item.sCn != null) const SizedBox(height: 2),
                                if (item.sCn != null)
                                  Text(
                                    '${item.sCn}',
                                    style: const TextStyle(
                                        color: Color.fromRGBO(100, 90, 100, 1),
                                        fontSize: 13),
                                  )
                              ],
                            ),
                          ),
                          playButton(item.sContent),
                        ],
                      ),
                    )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget realSentenceWiget(String? desc,
      List<WordsContentWordContentRealExamSentenceSentences?> sentences) {
    return Bannel(
      color: Colors.grey.shade200,
      radius: 8,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (desc != null)
                  Text(
                    desc,
                    style: const TextStyle(
                      color: Color.fromRGBO(140, 150, 145, 1),
                    ),
                  ),
                for (var item in sentences)
                  if (item?.sContent != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: WordCardSelection(
                                  text:
                                      '${item!.sContent?.trim().replaceAll('\u3000|', ' ')}',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(40, 30, 40, 1),
                                      fontSize: 15),
                                ),
                              ),
                              playButton(item.sContent),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            ' > ${genInfo(item.sourceInfo)}',
                            style: const TextStyle(
                                color: Color.fromRGBO(125, 130, 125, 1),
                                fontSize: 14),
                          )
                        ],
                      ),
                    )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String genInfo(
      WordsContentWordContentRealExamSentenceSentencesSourceInfo? sourceInfo) {
    if (sourceInfo == null) return '';
    final list = <String>[];
    if (sourceInfo.type != null) {
      list.add(sourceInfo.type!);
    }
    if (sourceInfo.year != null) {
      list.add(sourceInfo.year!);
    }
    if (sourceInfo.level != null) {
      list.add(sourceInfo.level!);
    }
    if (sourceInfo.paper != null) {
      list.add(sourceInfo.paper!);
    }
    return list.join(' · ');
  }

  /// TODO:
  Widget synoWidget() {
    return Container();
  }

  Widget playButton(String? content) {
    return btn1(
      bgColor: Colors.grey.shade200,
      splashColor: Colors.grey.shade400,
      radius: 30,
      padding: const EdgeInsets.all(4),
      onTap: () {
        notifier.playSentence(content);
      },
      child: const Icon(Icons.volume_up_rounded,
          size: 22, color: Color.fromRGBO(90, 210, 90, 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<WordCardNotifier>();
    final page = PageView.builder(
        controller: controller,
        itemCount: widget.max,
        allowImplicitScrolling: true,
        itemBuilder: (context, index) {
          final success = notifier.getCurrentState(index);
          if (!success) {
            return loadingIndicator();
          }
          final words = notifier.data;
          if (index > words.length - 1) {
            return reloadBotton(() => notifier.loadData(widget.dictId));
          }
          final data = words[index];
          final content = data.content;
          final trans = content?.content?.trans;
          final sentence = content?.content?.sentence;
          final word = content?.wordHead;
          final usphone = content?.content?.usphone;
          final ukphone = content?.content?.ukphone;
          final usspeech = content?.content?.usspeech;
          final ukspeech = content?.content?.ukspeech;
          final tranCn = trans?.map((e) => e?.tranCn).whereType<String>();
          final tranOther = trans?.map((e) => e?.tranOther).whereType<String>();

          final showTran = tranCn != null || tranOther != null;
          final desc = sentence?.desc;
          final sentences = sentence?.sentences;
          final showSentences = sentences != null;

          final realSentence = content?.content?.realExamSentence;
          final realDesc = realSentence?.desc;
          final realSentences = realSentence?.sentences;
          final showRealSentences = realSentences != null;
          final syno = content?.content?.syno;
          return SingleChildScrollView(
              controller: ScrollController(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    wordWidget(word, usphone, ukphone, usspeech, ukspeech),
                    if (showTran) const SizedBox(height: 5),
                    if (showTran) tranWidget(tranCn, tranOther),
                    if (showSentences) const SizedBox(height: 5),
                    if (showSentences) sentencesWidget(desc, sentences),
                    if (showRealSentences) const SizedBox(height: 5),
                    if (showRealSentences)
                      realSentenceWiget(realDesc, realSentences),
                    const SizedBox(height: 50)
                  ],
                ),
              ));
        });

    return Stack(
      children: [
        page,
        if (show)
          Positioned(
            left: 10,
            bottom: 10,
            child: RepaintBoundary(
              child: ElevatedButton(
                onPressed: () {
                  controller.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
                child: Text('上一页'),
              ),
            ),
          ),
        if (show)
          Positioned(
            right: 10,
            bottom: 10,
            child: RepaintBoundary(
              child: ElevatedButton(
                onPressed: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
                child: Text('下一页'),
              ),
            ),
          ),
        Positioned(
          bottom: 0,
          left: 32,
          right: 32,
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return ProgressPage(
                  dictId: widget.dictId,
                  initValue: widget.currentIndex,
                  max: widget.max,
                  controller: controller,
                );
              },
            ),
          ),
        )
      ],
    );
  }
}

class ProgressPage extends StatefulWidget {
  const ProgressPage({
    Key? key,
    required this.controller,
    required this.initValue,
    required this.max,
    required this.dictId,
  }) : super(key: key);
  final PageController controller;
  final int initValue;
  final int max;
  final String dictId;
  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  late int _currentValue;
  late PageController controller;
  late WordCardNotifier notifier;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initValue;
    controller = widget.controller;
    controller.addListener(_listenning);
  }

  @override
  void didUpdateWidget(covariant ProgressPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (controller != widget.controller) {
      controller.removeListener(_listenning);
      controller = widget.controller;
      controller.addListener(_listenning);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    notifier = context.read();
  }

  @override
  void dispose() {
    controller.removeListener(_listenning);
    super.dispose();
  }

  void _listenning() {
    var currentValue = widget.controller.page?.round();
    if (currentValue != null) {
      currentValue += 1;
      if (_currentValue != currentValue) {
        Log.i('update: $currentValue');
        setState(() {
          _currentValue = currentValue!;
          notifier.updateDict(widget.dictId, _currentValue);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$_currentValue'),
        LinearProgressIndicator(
          value: _currentValue / widget.max,
          backgroundColor: Colors.grey.shade400,
          color: Colors.blue,
        ),
      ],
    );
  }
}

class Bannel extends StatelessWidget {
  const Bannel({
    Key? key,
    required this.child,
    this.color,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.radius,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final EdgeInsets? padding;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    Widget base = child;
    if (padding != null) {
      base = Padding(padding: padding!, child: base);
    }
    if (radius != null) {
      final decoration = BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(radius!));
      base = DecoratedBox(decoration: decoration, child: base);
    } else {
      if (color != null) {
        base = ColoredBox(color: color!, child: base);
      }
    }
    return base;
  }
}

class WordCardSelection extends StatefulWidget {
  const WordCardSelection({Key? key, required this.text, required this.style})
      : super(key: key);
  final String text;
  final TextStyle style;
  @override
  WordCardSelectionState createState() => WordCardSelectionState();
}

class WordCardSelectionState extends State<WordCardSelection> {
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  final GlobalKey<EditableTextState> editableTextKey =
      GlobalKey<EditableTextState>();

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.text);
    focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant WordCardSelection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      textEditingController.text = widget.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    // [EditableText] 不满足要求，需要对其进行魔改
    return EditableText(
      key: editableTextKey,
      controller: textEditingController,
      focusNode: focusNode,
      style: widget.style,
      cursorColor: Colors.lightBlue.shade200,
      showCursor: false,
      maxLines: null,
      readOnly: true,
      onChanged: (v) {
        Log.i('v:$v');
      },
      onSelectionHandleTapped: () {
        Log.i('tap');
      },
      onSubmitted: (v) {
        Log.i('s: $v');
      },
      selectionColor: Colors.lightBlue.shade200,
      onSelectionChanged: (textSelection, selectionChangedCause) {
        final word = textSelection.textInside(widget.text);
        if (textIsEmpty(word)) return;
        final notifier = context.read<WordCardNotifier>();

        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: 240,
                color: Colors.white,
                padding: const EdgeInsets.only(top: 8),
                child: Scaffold(
                    body: RepaintBoundary(
                        child: SelectWord(word: word, notifier: notifier))),
              );
            }).then((_) {
          if (mounted) {
            editableTextKey.currentState!.userUpdateTextEditingValue(
                TextEditingValue(
                    text: widget.text,
                    selection: TextSelection(baseOffset: 0, extentOffset: 0)),
                selectionChangedCause);
          }
        });
      },
      textDirection: TextDirection.ltr,
      backgroundCursorColor: Colors.yellow,
    );
  }

  bool textIsEmpty(String text) {
    return text.replaceAll(RegExp('[^a-zA-Z]|\\.| '), '').isEmpty;
  }
}

class SelectWord extends StatefulWidget {
  const SelectWord({Key? key, required this.word, required this.notifier})
      : super(key: key);
  final String word;
  final WordCardNotifier notifier;

  @override
  _SelectWordState createState() => _SelectWordState();
}

class _SelectWordState extends State<SelectWord> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WordTable?>(
      future: widget.notifier.getWord(widget.word),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return loadingIndicator();
        }

        final data = widget.notifier.data;
        WordTable? words = snap.data;

        if (data == null || words == null) {
          return SizedBox(
              height: 40, child: Center(child: Text('在本地中没有找到${widget.word}')));
        }

        final content = words.content;
        final trans = content?.content?.trans;

        final word = content?.wordHead;
        final usphone = content?.content?.usphone;
        final ukphone = content?.content?.ukphone;
        final usspeech = content?.content?.usspeech;
        final ukspeech = content?.content?.ukspeech;
        final tranCn = trans?.map((e) => e?.tranCn).whereType<String>();
        final tranOther = trans?.map((e) => e?.tranOther).whereType<String>();

        final showTran = tranCn != null || tranOther != null;
        return SingleChildScrollView(
            controller: ScrollController(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  wordWidget(word, usphone, ukphone, usspeech, ukspeech),
                  if (showTran) const SizedBox(height: 5),
                  if (showTran) tranWidget(tranCn, tranOther),
                  const SizedBox(height: 10)
                ],
              ),
            ));
      },
    );
  }

  /// copy
  Widget wordWidget(String? word, String? usphone, String? ukphone,
      String? usspeech, String? ukspeech) {
    return Bannel(
      radius: 8,
      color: Colors.grey.shade200,
      child: InkWell(
        onTap: () {
          widget.notifier.play(usspeech);
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  '$word',
                  style: const TextStyle(
                      fontSize: 35,
                      leadingDistribution: TextLeadingDistribution.even),
                ),
              ),
              const Icon(Icons.volume_up_rounded,
                  size: 35, color: Color.fromRGBO(40, 160, 40, 1))
            ],
          ),
          if (usphone != null || ukphone != null)
            Row(
              children: [
                if (usphone != null)
                  btn1(
                    bgColor: Colors.grey.shade200,
                    splashColor: Colors.grey.shade400,
                    onTap: () {
                      widget.notifier.play(usspeech);
                    },
                    child: Text(
                      '美: [$usphone]',
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 15),
                    ),
                  ),
                if (usphone != null) const SizedBox(width: 5),
                if (ukphone != null)
                  btn1(
                    bgColor: Colors.grey.shade200,
                    splashColor: Colors.grey.shade400,
                    onTap: () {
                      widget.notifier.play(ukspeech);
                    },
                    child: Text(
                      '英: [$ukphone]',
                      style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 15),
                    ),
                  )
              ],
            )
        ]),
      ),
    );
  }

  /// 单词释义
  Widget tranWidget(Iterable<String?>? tranCn, Iterable<String?>? tranOther) {
    final tranOtherIsNotEmpty = tranOther?.isNotEmpty == true;
    final tranCnIsNotEmpty = tranCn?.isNotEmpty == true;
    return Bannel(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('释义',
                    style: const TextStyle(
                        color: Color.fromRGBO(140, 150, 145, 1))),
                if (tranCnIsNotEmpty) genTrans('中', tranCn),
                if (tranOtherIsNotEmpty) const SizedBox(height: 4),
                if (tranOtherIsNotEmpty) genTrans('英', tranOther),
              ],
            ),
          ),
        ],
      ),
      color: Colors.grey.shade200,
      radius: 8,
    );
  }

  Widget genTrans(String lan, Iterable<String?>? data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$lan: ',
          style: const TextStyle(
              color: Color.fromRGBO(100, 90, 100, 1), fontSize: 15),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data != null)
                for (var item in data)
                  Text(
                    '$item',
                    style: const TextStyle(
                        color: Color.fromRGBO(100, 90, 100, 1), fontSize: 15),
                  )
            ],
          ),
        )
      ],
    );
  }
}
