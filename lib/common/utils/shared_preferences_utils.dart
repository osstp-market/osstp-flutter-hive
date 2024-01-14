import 'package:osstp_local_storage/osstp_local_storage.dart';

class SharedPreferencesUtils {
  static Future<bool> resetPreferencesData() async {
    bool result1 = await OsstpLocalStorage.removePrefs(LocalStoreKey.guideHasDisplay);
    bool result2 = await OsstpLocalStorage.removePrefs(LocalStoreKey.biometricsEnable);

    return result1 && result2;
  }
}

/// 用来保存 key
class LocalStoreKey {
  /// 介绍画面已经显示过
  static const String guideHasDisplay = "guide_has_display_key";
  static const String biometricsEnable = "biometrics_enable_key";
}