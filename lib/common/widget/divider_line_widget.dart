import 'package:flutter/material.dart';

class DividerLineView extends StatelessWidget {
  DividerLineView(
      {super.key, this.height = 1, this.thickness = 1, this.indent = 0, this.endIndent = 0, this.color, this.width});

  double? width;

  double height = 1;
  double? thickness;
  double? indent;
  double? endIndent;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Divider(
        height: height,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
        color: color ?? Theme.of(context).dividerColor,
      ),
    );
  }
}
