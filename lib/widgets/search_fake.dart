import 'package:flutter/material.dart';

class SearchFake extends StatelessWidget {
  const SearchFake({
    Key? key,
    this.hint,
  }) : super(key: key);

  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
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
