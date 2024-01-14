import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import '../../../../../common/utils/selected_item_model.dart';

class DeviceInfoController extends SuperController {
  final version = '1.0.0'.obs;

  RefreshController refreshController = RefreshController(initialRefresh: false);

  void onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1500));

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
