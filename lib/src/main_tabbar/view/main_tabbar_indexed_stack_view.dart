import 'package:flutter/material.dart';

typedef MainIndexedStackViewComplete = Widget Function(BuildContext context, int num);

class MainIndexedStackView extends StatefulWidget {
  final int index;
  final int itemCount;
  final MainIndexedStackViewComplete currentItem;

  const MainIndexedStackView({
    Key? key,
    required this.index,
    required this.itemCount,
    required this.currentItem,
  }) : super(key: key);

  @override
  _MainIndexedStackViewState createState() => _MainIndexedStackViewState();
}

class _MainIndexedStackViewState extends State<MainIndexedStackView> {
  List<Widget> items = [];

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      for (int i = 0; i < widget.itemCount; i++) {
        items.add(SizedBox(
          key: Key(i.toString()),
        ));
      }
    }

    if (items[widget.index].key == Key(widget.index.toString())) {
      items[widget.index] = widget.currentItem(context, widget.index);
    }

    return IndexedStack(
      index: widget.index,
      children: items,
    );
  }
}
