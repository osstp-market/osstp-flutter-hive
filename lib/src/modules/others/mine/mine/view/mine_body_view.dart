import 'package:flutter/material.dart';
import '/common/widget/inkWell_button.dart';

import '../../../../../../common/theme/theme.dart';
import '../../../../../../common/utils/selected_item_model.dart';
import '../../../../../../common/widget/divider_line_widget.dart';


class MineBodyWidget extends StatefulWidget {
  const MineBodyWidget({
    Key? key,
    required this.context,
    required this.itemList,
    required this.index,
    this.authed,
    this.notAuthedCallback,
    required this.onTapCallback,
  }) : super(key: key);

  final BuildContext context;
  final List<SelectedItemModel> itemList;
  final int index;

  /// 认证成功
  final ValueChanged onTapCallback;

  /// 如果未认证
  final ValueChanged? notAuthedCallback;
  final bool? authed;

  @override
  State<MineBodyWidget> createState() => _MineBodyWidgetState();
}

class _MineBodyWidgetState extends State<MineBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildListItem(widget.index, widget.onTapCallback);
  }

  _buildListItem(int index, ValueChanged onTapCallback) {
    return Container(
      margin: widget.itemList[index].needSpace == true ? const EdgeInsets.only(bottom: 10) : null,
      child: Column(
        children: [
          index == 0 || (widget.itemList[index - 1].needSpace == true) ? DividerLineView() : const SizedBox(),
          InkWellButton.InkWell(
            backgroundColor: ThemeColors.listItemBackgroundThemeColor(context),
            onTap: () {
              onTapCallback(index);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
              child: Row(
                children: [
                  Container(
                      padding: const EdgeInsets.only(right: 10), child: Icon(widget.itemList[index].image, size: 16.0)),
                  Expanded(
                      child: Text(
                    widget.itemList[index].title ?? "",
                    style: ThemeTextStyle.firstTitleStyle,
                  )),
                  const Icon(Icons.arrow_forward_ios, size: 16.0),
                ],
              ),
            ),
          ),
          index == widget.itemList.length - 1 || widget.itemList[index].needSpace == true
              ? DividerLineView()
              : Row(
                  children: [
                    DividerLineView(
                      color: ThemeColors.listItemBackgroundThemeColor(context),
                      width: 30,
                    ),
                    Expanded(child: DividerLineView())
                  ],
                ),
        ],
      ),
    );
  }
}
