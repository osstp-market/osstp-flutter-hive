import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OsstpEmptyWidget extends StatefulWidget {
  const OsstpEmptyWidget({
    super.key,
    this.title,
    this.subTitle,
    this.image,
    this.subtitleTextStyle,
    this.titleTextStyle,
    this.packageImage,
    this.hideBackgroundAnimation = false,
  });

  /// Display images from project assets
  final String? image; /*!*/

  /// Display image from package assets
  final PackageImage? packageImage; /*!*/

  /// Set text for subTitle
  final String? subTitle; /*!*/

  /// Set text style for subTitle
  final TextStyle? subtitleTextStyle; /*!*/

  /// Set text for title
  final String? title; /*!*/

  /// Text style for title
  final TextStyle? titleTextStyle; /*!*/

  /// Hides the background circular ball animation
  ///
  /// By default `false` value is set
  final bool? hideBackgroundAnimation;

  @override
  State<StatefulWidget> createState() => _OsstpEmptyListWidgetState();
}

class _OsstpEmptyListWidgetState extends State<OsstpEmptyWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.image == null) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.title == null
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              widget.title!,
                              style: widget.titleTextStyle ??
                                  const TextStyle(
                                    fontSize: 22,
                                    color: Color(0xff9da9c7),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                    widget.subTitle == null
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              widget.subTitle!,
                              style: widget.subtitleTextStyle ??
                                  const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffabb8d6),
                                  ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
    return EmptyWidget(
      image: widget.image,
      packageImage: widget.packageImage,
      title: widget.title,
      subTitle: widget.subTitle,
      hideBackgroundAnimation: true,
      titleTextStyle: const TextStyle(
        fontSize: 22,
        color: Color(0xff9da9c7),
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xffabb8d6),
      ),
    );
  }
}
