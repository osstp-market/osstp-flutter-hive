import 'package:flutter/material.dart';

class SelectedItemModel {
  final String? title;
  final IconData? image;
  final Widget? child;
  final String? routesName;
  final bool? needSpace;
  final RouteSettings? routeSettings;
  SelectedItemModel({
    required this.title,
    this.image,
    this.child,
    this.routesName,
    this.needSpace,
    this.routeSettings,
  });
}

