import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:useful_tools/useful_tools.dart';
import 'package:word_card/provider/home_list.dart';

import '../data/data.dart';
import '../event/repository.dart';
import '../provider/book_library.dart';
import '../widgets/search_fake.dart';

class BookLibrary extends StatefulWidget {
  const BookLibrary({Key? key}) : super(key: key);

  @override
  _BookLibraryState createState() => _BookLibraryState();
}

class _BookLibraryState extends State<BookLibrary> {
  BookLibraryNotifier libraryNotifier = BookLibraryNotifier();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    libraryNotifier.repository = context.read();
    if (!libraryNotifier.loadingOrDone) {
      libraryNotifier.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: libraryNotifier,
        builder: (context, _) {
          // final data = libraryNotifier.data?.bookInfos;

          final cates = libraryNotifier.tagNames;
          final data = libraryNotifier.getCateTagData;
          final curentCate = libraryNotifier.cate;
          if (data == null) {
            return loadingIndicator();
          } else if (data.isEmpty) {
            return reloadBotton(libraryNotifier.load);
          }
          final tags = libraryNotifier.tags;
          var count = data.length + 1;
          final hasTags = tags != null;
          if (hasTags) count += 1;

          return Column(
            children: [
              Container(
                height: 56,
                color: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: const SearchFake(hint: '查找单词书'),
              ),
              Expanded(
                child: ListViewBuilder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    var currentIndex = index;
                    if (currentIndex == 0) {
                      return Container(
                        // height: 100,
                        padding: const EdgeInsets.all(10),
                        child: Wrap(
                          children: [
                            if (cates != null)
                              for (var item in cates)
                                Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: btn1(
                                      shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.green),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      // bgColor: Colors.grey.shade400,
                                      onTap: () {
                                        libraryNotifier.changeCate(
                                            item?.name, null);
                                      },
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      child: Text('${item?.name}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: libraryNotifier
                                                      .eqCate(item?.name)
                                                  ? Colors.green
                                                  : Colors.grey.shade700))),
                                ),
                          ],
                        ),
                      );
                    }
                    currentIndex--;
                    if (hasTags) {
                      if (currentIndex == 0) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Wrap(
                            children: [
                              if (tags.tags != null)
                                for (final item in tags.tags!)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2),
                                    child: btn1(
                                        bgColor: libraryNotifier.eqTag(item)
                                            ? Colors.cyan.shade300
                                            : Colors.grey.shade300,
                                        radius: 5,
                                        onTap: () {
                                          libraryNotifier.changeCate(
                                              curentCate, item);
                                        },
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 4),
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                              color: Colors.grey.shade600),
                                        )),
                                  ),
                            ],
                          ),
                        );
                      }
                      currentIndex--;
                    }

                    final item = data[currentIndex];
                    return ListItem(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 4),
                          child: ImageItemLayout(
                              info: item, notifier: libraryNotifier),
                        ));
                  },
                ),
              ),
            ],
          );
        });
  }
}

class ImageItemLayout extends StatefulWidget {
  const ImageItemLayout({Key? key, required this.info, required this.notifier})
      : super(key: key);
  final BookInfoDataNormalBooksInfo info;
  final BookLibraryNotifier notifier;

  @override
  State<ImageItemLayout> createState() => _ImageItemLayoutState();
}

class _ImageItemLayoutState extends State<ImageItemLayout> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            child: ImageBuilder(url: widget.info.cover, height: 90, width: 67),
            width: 67,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.info.title}'),
                      Text(
                          '${widget.info.tags?.map((e) => e?.tagName).join()}'),
                    ],
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: btn1(
                      bgColor: Colors.cyan,
                      radius: 8,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      child: RepaintBoundary(
                        child: Center(
                            child: FutureBuilder(
                                future: widget.notifier
                                    .getWordState(widget.info.id),
                                builder: (context, snap) {
                                  final has = snap.data == true;
                                  return Text(has ? '已添加' : '添加到列表中');
                                })),
                      ),
                      onTap: () {
                        final homeNotifier = context.read<HomeListNotifier>();
                        widget.notifier
                            .loadAndAdd(widget.info.id, widget.info.offlinedata,
                                widget.info)
                            .whenComplete(homeNotifier.load);
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ImageBuilder extends StatefulWidget {
  const ImageBuilder(
      {Key? key, this.url, required this.height, required this.width})
      : super(key: key);
  final String? url;
  final double height;
  final double width;
  @override
  _ImageBuilderState createState() => _ImageBuilderState();
}

class _ImageBuilderState extends State<ImageBuilder> {
  late Repository repository;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    repository = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return ImageFuture.memory(
        imageKey: [repository, widget.url],
        getMemory: () {
          final url = widget.url;
          if (url == null) {
            return null;
          }
          return repository.event.getImageSource(url);
        },
        height: widget.height,
        width: widget.width);
  }
}
