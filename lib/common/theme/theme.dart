import 'package:flutter/material.dart';

/// TIP：保存所有文本样式
class ThemeTextStyle {
  static const TextStyle titleBarStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold, letterSpacing: 1.5);
  static const TextStyle firstTitleStyle = TextStyle(fontSize: 16);
  static const TextStyle secondTitleStyle = TextStyle(fontSize: 14);
  static const TextStyle smallTextStyle = TextStyle(fontSize: 12);
  static final TextStyle hintTextStyle = TextStyle(fontSize: 16, color: Colors.grey[800]);
}

class ThemeColors {
  /// TIP：main color, navigator and main tab bar background color
  static Color primaryThemeColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  /// TIP：scaffold default background color
  static Color scaffoldThemeColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  /// TIP：list item background color
  static Color listItemBackgroundThemeColor(BuildContext context) {
    return Theme.of(context).primaryColorLight;
  }

  /// TIP：line color
  static Color listItemDividerThemeColor(BuildContext context) {
    return Theme.of(context).dividerColor;
  }

  /// TIP：rich text color
  static Color richTextThemeColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }

  /// TIP：Radio color
  static Color radioThemeColor(BuildContext context) {
    return Colors.blue;
  }

  static Color linkTextAndLineColor = Colors.blue;
  static Color blueColor = Colors.blue;
}
