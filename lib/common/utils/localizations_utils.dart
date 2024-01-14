import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:osstp_local_storage/osstp_local_storage.dart';

import '../config/application_config.dart';

const String localizationsKey = "osstp_localizations_key";

class ResultMap {
  bool? result;
  String? locale;

  ResultMap({this.result, this.locale});
}

class LocalizationsUtils with ChangeNotifier {
  static LocalizationsUtils? _current;

  static LocalizationsUtils get current {
    _current ??= LocalizationsUtils();
    return _current!;
  }

  Future<ResultMap> getLocale({required String defaultLocale}) async {
    dynamic locale = await OsstpLocalStorage.fromPrefs(localizationsKey);
    ResultMap resultMap = ResultMap();
    if (locale == null) {
      bool result = await OsstpLocalStorage.savePrefs(localizationsKey, stringValue: defaultLocale);
      resultMap.result = result;
      resultMap.locale = defaultLocale;
    }
    if (locale is String) {
      resultMap.result = true;
      resultMap.locale = locale;
    }
    return resultMap;
  }

  Future<ResultMap> setLocale({required String locale}) async {
    bool result = await OsstpLocalStorage.savePrefs(localizationsKey, stringValue: locale);
    ResultMap resultMap = ResultMap(result: result, locale: locale);
    return resultMap;
  }

  /// init localization
  initConfig() async {
    ResultMap result = await getLocale(defaultLocale: ApplicationConfig.defaultLanguage);
    if (result.result == true) {
      // set default language
      Get.updateLocale(Locale(result.locale ?? ApplicationConfig.defaultLanguage));
    } else {
      // set default language
      Locale locale = PlatformDispatcher.instance.locale;
      Get.updateLocale(locale);
    }
  }

  Future<bool> setLanguage(String locale) async {
    ResultMap result = await setLocale(locale: locale);
    if (result.result == true) {
      Get.updateLocale(Locale(result.locale ?? ApplicationConfig.defaultLanguage));
    }
    return result.result ?? false;
  }

  Future<String> getLocaleDisplayLanguage() async {
    ResultMap result = await getLocale(defaultLocale: ApplicationConfig.defaultLanguage);
    return result.locale ?? ApplicationConfig.defaultLanguage;
  }
}




