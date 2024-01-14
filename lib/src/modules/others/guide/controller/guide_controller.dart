import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuideController extends SuperController {
  /// 系统图
  final List<Widget> imagesData = [
    const Icon(
      Icons.flutter_dash_rounded,
      color: Colors.white,
      size: 160,
    ),
    const Icon(
      Icons.safety_check_rounded,
      color: Colors.white,
      size: 160,
    ),
    const Icon(
      Icons.view_module_rounded,
      color: Colors.white,
      size: 160,
    ),
    const Icon(
      Icons.free_breakfast_rounded,
      color: Colors.white,
      size: 160,
    ),
  ];

  final List<String> titles = ["欢迎使用", "高效稳定", "高度封装", "快速集成"];
  final List<String> subtitles = [
    "HIVE 是功能完善、高性能、可扩展的产品级架构项目",
    "支持Android和iOS跨平台开发，实现移动App快速、稳定版本迭代",
    "基础功能插件高度封装，上手容易，可以把更多的精力专注于产品业务开发",
    "低耦合，可以根据自己的产品需求，快速集成、发布高质量产品",
  ];

  final List<Color> backgroundColors = [
    const Color(0xffF67904),
    const Color(0xffD12D2E),
    const Color(0xff7A1EA1),
    const Color(0xff1773CF)
  ];

  final index = 0.obs;

  @override
  onInit() {}

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
