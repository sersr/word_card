import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:useful_tools/useful_tools.dart';

import '../provider/home_list.dart';
import 'book_library.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  late HomeListNotifier provider;

  bool first = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = context.read();
    if (first) {
      first = false;
      provider.repository.init();
    }
  }

  @override
  Widget build(BuildContext context) {
    var main = Column(
      children: [
        Container(
          height: 56,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: SizedBox.expand(
                        child: Row(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              '查询英文或中文',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey.shade500),
                            ),
                          ),
                        ]),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromRGBO(235, 235, 240, 1),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 6, right: 12),
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
                  return ListViewBuilder(
                    scrollController: ScrollController(),
                    color: Colors.blue,
                    itemCount: 50,
                    itemBuilder: (context, index) {
                      return Container(
                          color: index.isOdd ? Colors.cyan : Colors.deepPurple,
                          height: 50);
                    },
                  );
                })),
      ],
    );
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
    notifier.value = index;
  }
}
