import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../generated/l10n.dart';
import '/common/global/global_constant.dart';
import '../../../../../common/config/application_config.dart';
import '../../../../../common/utils/badge_utils.dart';
import '../../../../../common/widget/main_app_bar.dart';
import '../controller/badge_controller.dart';

class BadgePage extends StatefulWidget {
  const BadgePage({Key? key}) : super(key: key);

  @override
  State<BadgePage> createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (controller) {
        return Scaffold(
          appBar: MainAppBar(
            title: 'Badge',
            rightActionWidgets: [
              const Icon(
                Icons.notifications_off_rounded,
              ),
              const Icon(
                Icons.notifications,
              ),
              const Icon(
                Icons.notification_add_rounded,
              )
            ],
            // rightActions: [],
            onTapFunction: (OnTapModel tapModel) {
              if (tapModel.index == 0) {
                BadgeUtils.clear();
              }
              if (tapModel.index == 1) {
                BadgeUtils.badgeChangeWidget(index: 0, badge: '2');
                BadgeUtils.badgeChangeWidget(index: 1, badge: '90');
                BadgeUtils.badgeChangeWidget(
                    index: 2,
                    badgeWidget: Container(
                      color: Colors.orange,
                      height: 20,
                      width: 20,
                    ));
                BadgeUtils.clear(index: 99);
              } else if (tapModel.index == 2) {
                BadgeUtils.badgeChangeWidget(index: 0, badge: '5');
                BadgeUtils.badgeChangeWidget(index: 1, badge: '105');
                BadgeUtils.badgeChangeWidget(index: 2, badge: '100');
                BadgeUtils.badgeChangeWidget(index: 3, badge: '90');
                BadgeUtils.badgeChangeWidget(index: 99, badge: '20');
              }
            },
          ),
          body: Obx(() => SafeArea(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: <Widget>[
                    Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Default Widget
                        _badgeWidget("右上角数字<100", BadgeUtils.getBadgeWidget(0, badgeColor: Colors.green)),
                        _badgeWidget("右上角红点", BadgeUtils.getBadgeWidget(1, badgeColor: Colors.red, onlyPoint: true)),
                        _badgeWidget("右上角数字>=100", BadgeUtils.getBadgeWidget(2, badgeColor: Colors.green)),
                        _badgeWidget("右上角数字多位", BadgeUtils.getBadgeWidget(3, badgeColor: Colors.green)),
                        _badgeWidget("任意ID取值", BadgeUtils.getBadgeWidget(99, badgeColor: Colors.green)),

                        // Only number
                        _badgeWidget(
                            "只取index=0数字",
                            SizedBox(
                              child: Text('${BadgeUtils.getBadgeNumber(index: 0)}'),
                            )),
                        _badgeWidget(
                            "只取index=1数字",
                            SizedBox(
                              child: Text('${BadgeUtils.getBadgeNumber(index: 1)}'),
                            )),
                        _badgeWidget(
                            "只取index=2数字",
                            SizedBox(
                              child: Text('${BadgeUtils.getBadgeNumber(index: 2)}'),
                            )),
                        _badgeWidget(
                            "只取index=3数字",
                            SizedBox(
                              child: Text('${BadgeUtils.getBadgeNumber(index: 3)}'),
                            )),
                        _badgeWidget(
                            "只取index=99数字",
                            SizedBox(
                              child: Text('${BadgeUtils.getBadgeNumber(index: 99)}'),
                            )),
                        _badgeWidget(
                          "总数\n不包含自定义成widget的消息",
                          SizedBox(
                            child: Text('${BadgeUtils.getBadgeNumber()}'),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            S.current.application_name,
                            style: const TextStyle(
                                color: Color(0xFF00D6F7),
                                fontFamily: ConstantFonts.STLITI,
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              )),
        );
      },
    );
  }

  _badgeWidget(String title, Widget customWidget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Stack(
          fit: StackFit.passthrough,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, right: 20),
              height: 50,
              width: 50,
              child: const Icon(
                Icons.hive_rounded,
                color: Colors.cyan,
                size: 45,
              ),
            ),
            Positioned(
              right: 15,
              top: 15,
              child: customWidget,
            )
          ],
        ),
      ],
    );
  }
}
