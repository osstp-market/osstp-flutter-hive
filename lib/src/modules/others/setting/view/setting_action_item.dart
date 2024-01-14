import 'package:flutter/material.dart';

import '../../../../../common/theme/theme.dart';

enum SelectedType { imageWidget, switchWidget }

class SettingActionItem extends StatelessWidget {
  SettingActionItem(
      {Key? key,
      this.titleWidget,
      this.title,
      this.description,
      this.selected = false,
      this.selectedImage,
      this.selectedWidget,
      this.selectedType = SelectedType.imageWidget,
      this.switchValue,
      this.switchOnChanged,
      this.voidCallback})
      : assert((switchValue == null && switchOnChanged == null) || (switchValue != null && switchOnChanged != null)),
        super(key: key);

  Widget? titleWidget;
  String? title;
  String? description;
  IconData? selectedImage;
  Widget? selectedWidget;

  SelectedType selectedType;
  bool? switchValue;
  ValueChanged<bool>? switchOnChanged;

  bool selected;
  VoidCallback? voidCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (voidCallback != null) {
          voidCallback!();
        }
      },
      child: Container(
        color: ThemeColors.listItemBackgroundThemeColor(context),
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        titleWidget ?? Text(title ?? ''),
                      ],
                    ),
                    description == null
                        ? const SizedBox()
                        : Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Text(
                              description ?? "",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            selectedWidget ??
                (selectedType == SelectedType.switchWidget
                    ? Switch(value: switchValue!, onChanged: switchOnChanged!)
                    : (selected
                        ? Icon(selectedImage ?? Icons.beach_access_outlined, size: 16)
                        : const SizedBox())),
          ],
        ),
      ),
    );
  }
}
