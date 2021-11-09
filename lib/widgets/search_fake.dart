import 'package:flutter/material.dart';
import 'package:useful_tools/widgets.dart';

class Back extends StatelessWidget {
  const Back({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 56,
      child: OverflowBox(
        maxHeight: 60,
        maxWidth: 60,
        child: btn1(
            radius: 100,
            onTap: () {
              Navigator.maybePop(context);
            },
            child: const Center(child: Icon(Icons.arrow_back))),
      ),
    );
  }
}

class SearchFake extends StatelessWidget {
  const SearchFake({
    Key? key,
    this.hint,
  }) : super(key: key);

  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
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
              if (hint != null)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    hint!,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
                  ),
                ),
            ]),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromRGBO(235, 235, 240, 1),
          ),
        ),
      ),
    );
  }
}
