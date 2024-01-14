import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osstp_badge/osstp_badge.dart';

class BadgeUtils {
  static final globalBadge = OsstpBadgeWidget(showBadge: true).obs;

  static badgeChangeWidget({int? index, String? badge, Widget? badgeWidget}) {
    globalBadge.value.setBadgeChange(index: index, badge: badge, badgeWidget: badgeWidget);
  }

  static int getBadgeNumber({int? index}) {
    return globalBadge.value.getBadgeNumber(index: index);
  }

  static Widget getBadgeWidget(int index,
      {bool? onlyPoint,
      Size? pointSize,
      double? fontSize,
      Color? backgroundColor = Colors.red,
      Color? badgeColor = Colors.white}) {
    return globalBadge.value.getBadgeWidget(
      index,
      badgeStyle: OsstpBadgeStyle(
        index: index,
        onlyPoint: onlyPoint,
        pointSize: pointSize,
        fontSize: fontSize,
        backgroundColor: backgroundColor,
        badgeColor: badgeColor,
      ),
    );
  }

  static clear({int? index}) {
    globalBadge.value.clear(index: index);
  }

  static badgeConfig() {
    globalBadge.value.addListener(() {
      globalBadge.refresh();
    });
  }
}
