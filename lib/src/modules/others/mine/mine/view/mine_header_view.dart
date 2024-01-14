import 'package:flutter/material.dart';
import '/common/widget/divider_line_widget.dart';
import '/src/modules/others/login/model/user_info_model.dart';

import '../../../../../../common/theme/theme.dart';
import '../../../../../../common/utils/string_utils.dart';
import '../../../../../../common/widget/inkWell_button.dart';


class MineHeaderView extends StatelessWidget {
  /// 认证成功
  VoidCallback? itemCallback;
  VoidCallback? avatarCallback;
  UserInfoModel? userInfo;

  /// 如果未认证
  VoidCallback? notAuthedCallback;
  bool? authed;

  MineHeaderView({Key? key, this.notAuthedCallback, this.itemCallback, this.authed, this.userInfo, this.avatarCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWellButton.InkWell(
          backgroundColor: ThemeColors.listItemBackgroundThemeColor(context),
          authed: authed,
          notAuthedCallback: () {
            notAuthedCallback!();
          },
          onTap: () {
            itemCallback!();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWellButton.normal(
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: const Icon(Icons.photo_library),
                          ),
                          onTap: () {
                            if (avatarCallback != null) {
                              avatarCallback!();
                            }
                          },
                        ),
                        Container(
                          height: 60,
                          margin: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  stringValue(userInfo?.nickname, placeholder: '--'),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(stringValue("${userInfo?.id}", placeholder: '--')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.arrow_forward_ios, size: 16.0),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: DividerLineView(),
        )
      ],
    );
  }
}
