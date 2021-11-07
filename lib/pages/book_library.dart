import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:useful_tools/useful_tools.dart';
import 'package:word_card/data/data.dart';
import 'package:word_card/event/repository.dart';
import 'package:word_card/provider/book_library.dart';
import 'package:useful_tools/ui_config.dart';

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
              Container(height: 56, color: Colors.blue),
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
                                            item.name, null);
                                      },
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      child: Text('${item.name}',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: libraryNotifier
                                                      .eqCate(item.name)
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
                          child: ImageItemLayout(info: item),
                        ));
                  },
                ),
              ),
            ],
          );
        });
  }
}

class ImageItemLayout extends StatelessWidget {
  const ImageItemLayout({Key? key, required this.info}) : super(key: key);
  final BookInfoDataNormalBooksInfo info;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            child: ImageBuilder(url: info.cover),
            width: 134,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${info.title}'),
                Text('${info.tags?.map((e) => e.tagName).join()}')
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ImageBuilder extends StatefulWidget {
  const ImageBuilder({Key? key, this.url}) : super(key: key);
  final String? url;
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
        height: 180,
        width: 134);
  }
}
