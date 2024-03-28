import 'package:flutter/material.dart';

class OnTapModel {
  int? index;
  String? name;
  Widget? child;

  OnTapModel({this.index, this.name, this.child});
}

typedef OnTapFunction = Function(OnTapModel onTapModel);

/// [AppBar]
MainAppBar({
  Key? key,
  String? title,
  Widget? leading,
  bool? useDefaultCustomLeading = false,
  VoidCallback? leadingCallback,
  bool? centerTitle,
  bool automaticallyImplyLeading = true,

  /// custom Widget action
  List<Widget>? rightActionWidgets,
  Color? backgroundColor,
  Color? foregroundColor,
  double? elevation,
}) {
  /// title
  Widget? titleWidget = title == null ? null : Text(title);

  List<Widget> action = [];

  for (Widget widget in rightActionWidgets ?? []) {
    action.add(widget);
  }

  return AppBar(
    key: key,
    leading: leading ?? (useDefaultCustomLeading == true ? _defaultCustomLeading(leadingCallback) : null),
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    elevation: elevation,
    title: titleWidget,
    centerTitle: centerTitle,
    automaticallyImplyLeading: automaticallyImplyLeading,
    actions: action,
  );
}

_defaultCustomLeading(VoidCallback? leadingCallback) {
  return Builder(
    builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          if (leadingCallback != null) {
            leadingCallback();
          } else {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          }
        },
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      );
    },
  );
}

/// only text style
class MainAppBarRightItemWidget extends StatelessWidget {
  MainAppBarRightItemWidget({Key? key, required this.title}) : super(key: key);
  String? title;
  @override
  Widget build(BuildContext context) {
    assert(title != null, 'title is required');
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Text(
        title!,
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
