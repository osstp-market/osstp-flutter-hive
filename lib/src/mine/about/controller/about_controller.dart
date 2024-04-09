import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../../common/config/application_config.dart';
import '../../../../../common/utils/selected_item_model.dart';
import '../../../../../generated/l10n.dart';

class AboutController extends SuperController {
  final version = ApplicationConfig.bundleVersion.obs;

  final itemList = <SelectedItemModel>[].obs;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  void onRefresh() async {
    itemList.add(SelectedItemModel(
        title: S.current.setting_about_function_introduced, child: Text(S.current.setting_about_introduced)));
    itemList.add(SelectedItemModel(
        title: S.current.setting_about_comments_suggestions, image: Icons.edit_rounded, routesName: ""));
    itemList.add(
        SelectedItemModel(title: S.current.setting_about_check_new_version, image: Icons.fiber_new, routesName: ""));

    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1500));

    // itemList.refresh();

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    refreshController.loadNoData();
  }

  @override
  void onInit() {
    super.onInit();

    onRefresh();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
