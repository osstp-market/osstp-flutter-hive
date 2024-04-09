import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:osstp_dynamic_theme/osstp_dynamic_theme.dart';
import '../../../../../common/widget/elevated_button_widget.dart';
import '../../../../../common/widget/main_app_bar.dart';
import '../../../routers/routers_navigator.dart';

import '../../../../../generated/l10n.dart';

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({super.key, this.themeColorModel});
  final ThemeColorModel? themeColorModel;
  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  late Color screenPickerColor; // Color for picker shown in Card on the screen.
  late Color appBarAndBottomBarThemeColor; // Color for picker in dialog using onChanged
  late Color selectedIconThemeColor; // Color for picker using color select dialog.
  late Color unselectedIconThemeColor; // Color for picker using color select dialog.
  late Color selectedItemColor; // Color for picker using color select dialog.
  late Color unselectedItemColor; // Color for picker using color select dialog.
  late Color scaffoldBackgroundColor; // Color for picker using color select dialog.
  late Color dividerColor; // Color for picker using color select dialog.
  late Color iconThemeColor; // Color for picker using color select dialog.
  late Color elevatedButtonThemeColor; // Color for picker using color select dialog.
  late bool isDark;

  // Define some custom colors for the custom picker segment.
  // The 'guide' color values are from
  // https://material.io/design/color/the-color-system.html#color-theme-creation
  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  // Make a custom ColorSwatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap = <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };

  ThemeColorModel? _themeColorModel = ThemeColorModel();

  @override
  void initState() {
    super.initState();
    _themeColorModel = widget.themeColorModel;
    screenPickerColor = Colors.blue;
    appBarAndBottomBarThemeColor =
        OsstpColorsUtils.colorFromHex(widget.themeColorModel?.appBarAndBottomBarThemeColor) ?? Colors.red;
    selectedIconThemeColor =
        OsstpColorsUtils.colorFromHex(widget.themeColorModel?.selectedIconThemeColor) ?? const Color(0xFFA239CA);
    unselectedIconThemeColor =
        OsstpColorsUtils.colorFromHex(widget.themeColorModel?.unselectedIconThemeColor) ?? const Color(0xFFA239CA);
    selectedItemColor =
        OsstpColorsUtils.colorFromHex(widget.themeColorModel?.selectedItemColor) ?? const Color(0xFFA239CA);
    unselectedItemColor =
        OsstpColorsUtils.colorFromHex(widget.themeColorModel?.unselectedItemColor) ?? const Color(0xFFA239CA);
    scaffoldBackgroundColor =
        OsstpColorsUtils.colorFromHex(widget.themeColorModel?.scaffoldBackgroundColor) ?? Colors.white;
    dividerColor = OsstpColorsUtils.colorFromHex(widget.themeColorModel?.dividerColor) ?? const Color(0xFFA239CA);
    iconThemeColor = OsstpColorsUtils.colorFromHex(widget.themeColorModel?.iconThemeColor) ?? const Color(0xFFA239CA);
    elevatedButtonThemeColor =
        OsstpColorsUtils.colorFromHex(widget.themeColorModel?.elevatedButtonThemeColor) ?? Colors.white;
    isDark = widget.themeColorModel?.brightness == Brightness.dark ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: '颜色选择',
        rightActionWidgets: [
          ElevatedButtonWidget.normal(
            titleText: Text(S.of(context).general_save),
            onPressed: () {
              Application.pop(context, _themeColorModel);
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        children: <Widget>[
          // Theme mode toggle
          SwitchListTile(
            title: const Text('开：文字颜色白色'),
            subtitle: const Text('关：文字颜色黑色\n'
                '自定义主题时用来设置全局文字黑色还是白色'),
            value: isDark,
            onChanged: (bool value) {
              setState(() {
                isDark = value;
                _themeColorModel?.brightness = isDark ? Brightness.dark : Brightness.light;
              });
            },
          ),
          const SizedBox(height: 16),
          // Pick color in a dialog.
          ListTile(
            title: const Text('顶部、底部导航背景颜色'),
            subtitle: Text(
              // ignore: lines_longer_than_80_chars
              '${ColorTools.materialNameAndCode(appBarAndBottomBarThemeColor, colorSwatchNameMap: colorsNameMap)} '
              'aka ${ColorTools.nameThatColor(appBarAndBottomBarThemeColor)}',
            ),
            trailing: ColorIndicator(
              width: 44,
              height: 44,
              borderRadius: 4,
              color: appBarAndBottomBarThemeColor,
              onSelectFocus: false,
              onSelect: () async {
                // Store current color before we open the dialog.
                final Color colorBeforeDialog = appBarAndBottomBarThemeColor;
                // Wait for the picker to close, if dialog was dismissed,
                // then restore the color we had before it was opened.
                if (!(await colorPickerDialog())) {
                  setState(() {
                    appBarAndBottomBarThemeColor = colorBeforeDialog;
                  });
                }
                _themeColorModel?.appBarAndBottomBarThemeColor = ColorTools.colorCode(appBarAndBottomBarThemeColor);
              },
            ),
          ),
          ListTile(
            title: const Text('底部导航图片选中颜色'),
            subtitle: Text(
              // ignore: lines_longer_than_80_chars
              '${ColorTools.materialNameAndCode(selectedIconThemeColor, colorSwatchNameMap: colorsNameMap)} '
              'aka ${ColorTools.nameThatColor(selectedIconThemeColor)}',
            ),
            trailing: ColorIndicator(
                width: 40,
                height: 40,
                borderRadius: 0,
                color: selectedIconThemeColor,
                elevation: 1,
                onSelectFocus: false,
                onSelect: () async {
                  // Wait for the dialog to return color selection result.
                  final newColor = await _colorPicker(selectedIconThemeColor);
                  // We update the dialogSelectColor, to the returned result
                  // color. If the dialog was dismissed it actually returns
                  // the color we started with. The extra update for that
                  // below does not really matter, but if you want you can
                  // check if they are equal and skip the update below.
                  setState(() {
                    selectedIconThemeColor = newColor;
                  });
                  _themeColorModel?.selectedIconThemeColor = ColorTools.colorCode(newColor);
                }),
          ),
          ListTile(
            title: const Text('底部导航图片未选中颜色'),
            subtitle: Text(
              // ignore: lines_longer_than_80_chars
              '${ColorTools.materialNameAndCode(unselectedIconThemeColor, colorSwatchNameMap: colorsNameMap)} '
              'aka ${ColorTools.nameThatColor(unselectedIconThemeColor)}',
            ),
            trailing: ColorIndicator(
                width: 40,
                height: 40,
                borderRadius: 0,
                color: unselectedIconThemeColor,
                elevation: 1,
                onSelectFocus: false,
                onSelect: () async {
                  // Wait for the dialog to return color selection result.
                  final newColor = await _colorPicker(unselectedIconThemeColor);
                  // We update the dialogSelectColor, to the returned result
                  // color. If the dialog was dismissed it actually returns
                  // the color we started with. The extra update for that
                  // below does not really matter, but if you want you can
                  // check if they are equal and skip the update below.
                  setState(() {
                    unselectedIconThemeColor = newColor;
                  });
                  _themeColorModel?.unselectedIconThemeColor = ColorTools.colorCode(newColor);
                }),
          ),
          ListTile(
            title: const Text('底部导航标题选中颜色'),
            subtitle: Text(
              // ignore: lines_longer_than_80_chars
              '${ColorTools.materialNameAndCode(selectedItemColor, colorSwatchNameMap: colorsNameMap)} '
              'aka ${ColorTools.nameThatColor(selectedItemColor)}',
            ),
            trailing: ColorIndicator(
                width: 40,
                height: 40,
                borderRadius: 0,
                color: selectedItemColor,
                elevation: 1,
                onSelectFocus: false,
                onSelect: () async {
                  // Wait for the dialog to return color selection result.
                  final newColor = await _colorPicker(selectedItemColor);
                  // We update the dialogSelectColor, to the returned result
                  // color. If the dialog was dismissed it actually returns
                  // the color we started with. The extra update for that
                  // below does not really matter, but if you want you can
                  // check if they are equal and skip the update below.
                  setState(() {
                    selectedItemColor = newColor;
                  });
                  _themeColorModel?.selectedItemColor = ColorTools.colorCode(newColor);
                }),
          ),
          ListTile(
            title: const Text('底部导航标题未选中颜色'),
            subtitle: Text(
              // ignore: lines_longer_than_80_chars
              '${ColorTools.materialNameAndCode(unselectedItemColor, colorSwatchNameMap: colorsNameMap)} '
              'aka ${ColorTools.nameThatColor(unselectedItemColor)}',
            ),
            trailing: ColorIndicator(
                width: 40,
                height: 40,
                borderRadius: 0,
                color: unselectedItemColor,
                elevation: 1,
                onSelectFocus: false,
                onSelect: () async {
                  // Wait for the dialog to return color selection result.
                  final newColor = await _colorPicker(unselectedItemColor);
                  // We update the dialogSelectColor, to the returned result
                  // color. If the dialog was dismissed it actually returns
                  // the color we started with. The extra update for that
                  // below does not really matter, but if you want you can
                  // check if they are equal and skip the update below.
                  setState(() {
                    unselectedItemColor = newColor;
                  });
                  _themeColorModel?.unselectedItemColor = ColorTools.colorCode(newColor);
                }),
          ),
          ListTile(
            title: const Text('全局背景颜色颜色'),
            subtitle: Text(
              // ignore: lines_longer_than_80_chars
              '${ColorTools.materialNameAndCode(scaffoldBackgroundColor, colorSwatchNameMap: colorsNameMap)} '
              'aka ${ColorTools.nameThatColor(scaffoldBackgroundColor)}',
            ),
            trailing: ColorIndicator(
                width: 40,
                height: 40,
                borderRadius: 0,
                color: scaffoldBackgroundColor,
                elevation: 1,
                onSelectFocus: false,
                onSelect: () async {
                  // Wait for the dialog to return color selection result.
                  final newColor = await _colorPicker(scaffoldBackgroundColor);
                  // We update the dialogSelectColor, to the returned result
                  // color. If the dialog was dismissed it actually returns
                  // the color we started with. The extra update for that
                  // below does not really matter, but if you want you can
                  // check if they are equal and skip the update below.
                  setState(() {
                    scaffoldBackgroundColor = newColor;
                  });
                  print(ColorTools.colorCode(newColor));
                  _themeColorModel?.scaffoldBackgroundColor = ColorTools.colorCode(newColor);
                }),
          ),
          ListTile(
            title: const Text('横线颜色'),
            subtitle: Text(
              // ignore: lines_longer_than_80_chars
              '${ColorTools.materialNameAndCode(dividerColor, colorSwatchNameMap: colorsNameMap)} '
              'aka ${ColorTools.nameThatColor(dividerColor)}',
            ),
            trailing: ColorIndicator(
                width: 40,
                height: 40,
                borderRadius: 0,
                color: dividerColor,
                elevation: 1,
                onSelectFocus: false,
                onSelect: () async {
                  // Wait for the dialog to return color selection result.
                  final newColor = await _colorPicker(dividerColor);
                  // We update the dialogSelectColor, to the returned result
                  // color. If the dialog was dismissed it actually returns
                  // the color we started with. The extra update for that
                  // below does not really matter, but if you want you can
                  // check if they are equal and skip the update below.
                  setState(() {
                    dividerColor = newColor;
                  });
                  print(ColorTools.colorCode(newColor));
                  _themeColorModel?.dividerColor = ColorTools.colorCode(newColor);
                }),
          ),
          ListTile(
            title: const Text('全局图标颜色'),
            subtitle: Text(
              // ignore: lines_longer_than_80_chars
              '${ColorTools.materialNameAndCode(iconThemeColor, colorSwatchNameMap: colorsNameMap)} '
              'aka ${ColorTools.nameThatColor(iconThemeColor)}',
            ),
            trailing: ColorIndicator(
                width: 40,
                height: 40,
                borderRadius: 0,
                color: iconThemeColor,
                elevation: 1,
                onSelectFocus: false,
                onSelect: () async {
                  // Wait for the dialog to return color selection result.
                  final newColor = await _colorPicker(iconThemeColor);
                  // We update the dialogSelectColor, to the returned result
                  // color. If the dialog was dismissed it actually returns
                  // the color we started with. The extra update for that
                  // below does not really matter, but if you want you can
                  // check if they are equal and skip the update below.
                  setState(() {
                    iconThemeColor = newColor;
                  });
                  _themeColorModel?.iconThemeColor = ColorTools.colorCode(newColor);
                }),
          ),
          ListTile(
            title: const Text('按钮背景色'),
            subtitle: Text(
              // ignore: lines_longer_than_80_chars
              '${ColorTools.materialNameAndCode(elevatedButtonThemeColor, colorSwatchNameMap: colorsNameMap)} '
              'aka ${ColorTools.nameThatColor(elevatedButtonThemeColor)}',
            ),
            trailing: ColorIndicator(
                width: 40,
                height: 40,
                borderRadius: 0,
                color: elevatedButtonThemeColor,
                elevation: 1,
                onSelectFocus: false,
                onSelect: () async {
                  // Wait for the dialog to return color selection result.
                  final newColor = await _colorPicker(elevatedButtonThemeColor);
                  // We update the dialogSelectColor, to the returned result
                  // color. If the dialog was dismissed it actually returns
                  // the color we started with. The extra update for that
                  // below does not really matter, but if you want you can
                  // check if they are equal and skip the update below.
                  setState(() {
                    elevatedButtonThemeColor = newColor;
                  });
                  print(ColorTools.colorCode(newColor));
                  _themeColorModel?.elevatedButtonThemeColor = ColorTools.colorCode(newColor);
                }),
          ),
          // Show the selected color.
          ListTile(
            title: const Text('Select color below to change this color'),
            subtitle: Text('${ColorTools.materialNameAndCode(screenPickerColor)} '
                'aka ${ColorTools.nameThatColor(screenPickerColor)}'),
            trailing: ColorIndicator(
              width: 44,
              height: 44,
              borderRadius: 22,
              color: screenPickerColor,
            ),
          ),

          // Show the color picker in sized box in a raised card.
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Card(
                elevation: 2,
                child: ColorPicker(
                  // Use the screenPickerColor as start color.
                  color: screenPickerColor,
                  // Update the screenPickerColor using the callback.
                  onColorChanged: (Color color) => setState(() => screenPickerColor = color),
                  width: 44,
                  height: 44,
                  borderRadius: 22,
                  heading: Text(
                    'Select color',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subheading: Text(
                    'Select color shade',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _colorPicker(Color dialogSelectColor) async {
    final Color newColor = await showColorPickerDialog(
      // The dialog needs a context, we pass it in.
      context,
      // We use the dialogSelectColor, as its starting color.
      dialogSelectColor,
      // title: Text('ColorPicker',
      //     style: Theme.of(context).textTheme.titleLarge),
      width: 40,
      height: 40,
      spacing: 0,
      runSpacing: 0,
      borderRadius: 0,
      wheelDiameter: 165,
      enableOpacity: true,
      showColorCode: true,
      colorCodeHasColor: true,
      pickersEnabled: <ColorPickerType, bool>{
        ColorPickerType.wheel: true,
      },
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        copyButton: true,
        pasteButton: true,
        longPressMenu: true,
      ),
      actionButtons: const ColorPickerActionButtons(
        okButton: true,
        closeButton: true,
        dialogActionButtons: false,
      ),
      transitionBuilder: (BuildContext context, Animation<double> a1, Animation<double> a2, Widget widget) {
        final double curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      constraints: const BoxConstraints(minHeight: 480, minWidth: 320, maxWidth: 320),
    );

    return newColor;
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      color: appBarAndBottomBarThemeColor,
      onColorChanged: (Color color) => setState(() => appBarAndBottomBarThemeColor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyMedium,
      colorCodePrefixStyle: Theme.of(context).textTheme.bodySmall,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      actionsPadding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
    );
  }
}
