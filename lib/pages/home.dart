import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:useful_tools/useful_tools.dart';
import 'dart:math' as math;
import '../provider/home_list.dart';
import '../widgets/search_fake.dart';
import 'book_library.dart';
import 'word_card.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  late HomeListNotifier provider;
  final scrollController = ScrollController();
  bool first = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = context.read();
    if (first) {
      first = false;
      provider.repository.init();
      provider.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    var main = Column(
      children: [
        Container(
          height: 56,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              const Expanded(child: SearchFake(hint: '查询中文或英文')),
              Container(
                padding: const EdgeInsets.only(left: 12, right: 6),
                child: const Icon(
                  Icons.add_alarm,
                  color: Color.fromRGBO(120, 120, 120, 1),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: AnimatedBuilder(
                animation: provider,
                builder: (context, _) {
                  final proViderdata = provider.data;
                  final data = proViderdata?.data;
                  if (proViderdata == null) {
                    return loadingIndicator();
                  } else if (data == null) {
                    // ignore: prefer_const_constructors
                    return Center(child: Text('从书库中添加单词书'));
                  }
                  return ListViewBuilder(
                    scrollController: scrollController,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      final wordCount = item.dataIndex?.length ?? 0;
                      final wordIndex =
                          math.min(wordCount, item.wordIndex ?? 0);
                      final progress = wordIndex == 0 || wordCount == 0
                          ? 0.0
                          : wordIndex / wordCount;
                      return ListItem(
                          onTap: () {
                            final id = item.dictId;
                            final currentIndex = item.wordIndex;
                            if (id != null && currentIndex != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return WordCardProvider(
                                    id: id, currentIndex: currentIndex);
                              }));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${item.name}'),
                                const SizedBox(height: 20),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                                '已完成${progress.toStringAsFixed(2)}%')),
                                        Text('$wordIndex/$wordCount词'),
                                      ],
                                    ),
                                    LinearProgressIndicator(value: progress),
                                  ],
                                )
                              ],
                            ),
                          ));
                    },
                  );
                })),
      ],
    );
    // ignore: prefer_const_constructors
    final children = [main, BookLibrary()];
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
            animation: notifier,
            builder: (context, _) {
              return IndexedStack(children: children, index: notifier.value);
            }),
      ),
      bottomNavigationBar: AnimatedBuilder(
          animation: notifier,
          builder: (context, _) {
            return BottomNavigationBar(
              selectedItemColor: Colors.grey.shade900,
              unselectedItemColor: Colors.grey.shade600,
              currentIndex: notifier.value,
              onTap: changed,
              unselectedFontSize: 14,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: '单词', tooltip: ''),
                BottomNavigationBarItem(
                    icon: Icon(Icons.library_books), label: '书库', tooltip: '')
              ],
            );
          }),
    );
  }

  ValueNotifier<int> notifier = ValueNotifier(0);
  void changed(index) {
    if (notifier.value == index && index == 0) {
      provider.load();
    }
    notifier.value = index;
  }
}
