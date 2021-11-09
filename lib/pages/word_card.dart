// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:useful_tools/useful_tools.dart';

import '../data/words.dart';
import '../provider/home_list.dart';
import '../provider/word_card.dart';
import '../widgets/search_fake.dart';

class WordCardProvider extends StatelessWidget {
  const WordCardProvider({
    Key? key,
    required this.id,
    required this.currentIndex,
  }) : super(key: key);
  final String id;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WordCardNotifier(context.read()),
      child: _WordCardMain(id: id, currentIndex: currentIndex),
    );
  }
}

class _WordCardMain extends StatefulWidget {
  const _WordCardMain({
    Key? key,
    required this.id,
    required this.currentIndex,
  }) : super(key: key);
  final String id;
  final int currentIndex;
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  btn1(
                      onTap: () {
                        Navigator.maybePop(context);
                      },
                      child: Center(child: Icon(Icons.arrow_back))),
                  Expanded(child: SearchFake(hint: '查找单词')),
                  // const Expanded(child: SizedBox()),
                  // btn1(onTap: () {}, child: Icon(Icons.search)),
                ],
              ),
            ),
            Expanded(
                child: AnimatedBuilder(
              animation: wordCardNotifier,
              builder: (context, _) {
                final data = wordCardNotifier.data;
                if (data == null) {
                  return loadingIndicator();
                } else if (data.isEmpty) {
                  return reloadBotton(() {
                    wordCardNotifier.loadData(widget.id);
                  });
                }
                return WordCard(
                  words: data,
                  currentIndex: widget.currentIndex,
                  dictId: widget.id,
                );
              },
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
      required this.words,
      required this.currentIndex,
      required this.dictId})
      : super(key: key);
  final List<Words> words;
  final int currentIndex;
  final String dictId;
  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  late PageController controller;
  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.currentIndex - 1);
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

  bool get show =>
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
            controller: controller,
            itemCount: widget.words.length,
            allowImplicitScrolling: true,
            itemBuilder: (context, index) {
              final data = widget.words[index];
              final content = data.content;
              final trans = content?.word?.content?.trans;
              final cenences = content?.word?.content?.sentence;
              return SingleChildScrollView(
                  controller: ScrollController(),
                  child: Container(
                    // color: Color.fromRGBO(180, 180, 180, 1),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Bannel(
                          radius: 8,
                          color: Colors.grey.shade200,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${data.content?.word?.wordHead}',
                                        style: const TextStyle(
                                            fontSize: 35,
                                            leadingDistribution:
                                                TextLeadingDistribution.even),
                                      ),
                                    ),
                                    const Icon(Icons.volume_up_rounded,
                                        size: 35,
                                        color: Color.fromRGBO(40, 160, 40, 1))
                                  ],
                                ),
                                Text(
                                  '/${content?.word?.content?.usphone}/',
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16),
                                )
                              ]),
                        ),
                        const SizedBox(height: 5),
                        Bannel(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('释义',
                                        style: const TextStyle(
                                            color: Color.fromRGBO(
                                                140, 150, 145, 1))),
                                    genTrans('中', trans?.map((e) => e.tranCn)),
                                    const SizedBox(height: 4),
                                    genTrans(
                                        '英', trans?.map((e) => e.tranOther)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          color: Colors.grey.shade200,
                          radius: 8,
                        ),
                        const SizedBox(height: 5),
                        Bannel(
                            color: Colors.grey.shade200,
                            radius: 8,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (cenences?.desc != null)
                                        Text(
                                          '${cenences?.desc}',
                                          style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  140, 150, 145, 1)),
                                        ),
                                      if (cenences?.sentences != null)
                                        for (var item in cenences!.sentences!)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${item.sContent}',
                                                  style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          40, 30, 40, 1),
                                                      fontSize: 15),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  '${item.sCn}',
                                                  style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          100, 90, 100, 1),
                                                      fontSize: 15),
                                                )
                                              ],
                                            ),
                                          )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        // Text(
                        //   '${data.toJson()}',
                        //   style: TextStyle(fontSize: 18, height: 1.8),
                        // ),
                        const SizedBox(height: 50)
                      ],
                    ),
                  ));
            }),
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
                        max: widget.words.length,
                        controller: controller);
                  }),
            ))
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
    final currentValue = widget.controller.page?.round() ?? _currentValue;
    if (_currentValue != currentValue) {
      Log.i('update: $currentValue');
      setState(() {
        _currentValue = currentValue;
        notifier.updateDict(widget.dictId, _currentValue.toInt());
      });
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
