import 'package:flutter/material.dart';

class ModuleListItem extends StatelessWidget {
  const ModuleListItem(
      {Key? key,
      this.titleWidget,
      required this.title,
      required this.image,
      this.description,
      this.selected = false,
      this.favoriteValueChanged,
      this.voidCallback})
      : super(key: key);

  final Widget? titleWidget;
  final String title;
  final IconData image;
  final String? description;

  final ValueChanged<int>? favoriteValueChanged;

  final bool selected;
  final VoidCallback? voidCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (voidCallback != null) {
          voidCallback!();
        }
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Card(
              child: Row(
                children: [
                  Container(padding: const EdgeInsets.only(left: 10), child: Icon(image, size: 16.0)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: titleWidget ?? Text(title ?? ''),
                        ),
                        Offstage(
                          offstage: description == null,
                          child: Text(
                            description ?? "",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    iconSize: 20,
                    onPressed: () {
                      if (favoriteValueChanged != null) {
                        favoriteValueChanged!(0);
                      }
                    },
                    icon: (selected
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          )
                        : const Icon(
                            Icons.favorite,
                          )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
