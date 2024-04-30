// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `HIVE`
  String get application_name {
    return Intl.message(
      'HIVE',
      name: 'application_name',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get tabbar_home {
    return Intl.message(
      'Home',
      name: 'tabbar_home',
      desc: '',
      args: [],
    );
  }

  /// `Favor`
  String get tabbar_favor {
    return Intl.message(
      'Favor',
      name: 'tabbar_favor',
      desc: '',
      args: [],
    );
  }

  /// `Me`
  String get tabbar_mine {
    return Intl.message(
      'Me',
      name: 'tabbar_mine',
      desc: '',
      args: [],
    );
  }

  /// `Module`
  String get tabbar_module {
    return Intl.message(
      'Module',
      name: 'tabbar_module',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get tabbar_more {
    return Intl.message(
      'More',
      name: 'tabbar_more',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get general_login {
    return Intl.message(
      'Login',
      name: 'general_login',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get general_logout {
    return Intl.message(
      'Sign out',
      name: 'general_logout',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get general_register {
    return Intl.message(
      'Sign in',
      name: 'general_register',
      desc: '',
      args: [],
    );
  }

  /// `Device Info`
  String get general_device {
    return Intl.message(
      'Device Info',
      name: 'general_device',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get general_edit {
    return Intl.message(
      'Edit',
      name: 'general_edit',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get general_save {
    return Intl.message(
      'Save',
      name: 'general_save',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get general_submit {
    return Intl.message(
      'Submit',
      name: 'general_submit',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get general_confirm {
    return Intl.message(
      'Confirm',
      name: 'general_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get general_close {
    return Intl.message(
      'Close',
      name: 'general_close',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get general_cancel {
    return Intl.message(
      'Cancel',
      name: 'general_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get general_add {
    return Intl.message(
      'Add',
      name: 'general_add',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get general_clear {
    return Intl.message(
      'Clear',
      name: 'general_clear',
      desc: '',
      args: [],
    );
  }

  /// `Please enter...`
  String get general_input_placeholder {
    return Intl.message(
      'Please enter...',
      name: 'general_input_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `Pull up load`
  String get general_pull_up_load {
    return Intl.message(
      'Pull up load',
      name: 'general_pull_up_load',
      desc: '',
      args: [],
    );
  }

  /// `Load Failed!Click retry!`
  String get general_Load_Failed_Click_retry {
    return Intl.message(
      'Load Failed!Click retry!',
      name: 'general_Load_Failed_Click_retry',
      desc: '',
      args: [],
    );
  }

  /// `Release to load more`
  String get general_load_more {
    return Intl.message(
      'Release to load more',
      name: 'general_load_more',
      desc: '',
      args: [],
    );
  }

  /// `No more data`
  String get general_no_more_data {
    return Intl.message(
      'No more data',
      name: 'general_no_more_data',
      desc: '',
      args: [],
    );
  }

  /// `Data on the server is abnormal`
  String get general_service_data_abnormal {
    return Intl.message(
      'Data on the server is abnormal',
      name: 'general_service_data_abnormal',
      desc: '',
      args: [],
    );
  }

  /// `Hello,\nWelcome to HIVE`
  String get login_hello {
    return Intl.message(
      'Hello,\nWelcome to HIVE',
      name: 'login_hello',
      desc: '',
      args: [],
    );
  }

  /// `Read and agree  `
  String get login_read_agree {
    return Intl.message(
      'Read and agree  ',
      name: 'login_read_agree',
      desc: '',
      args: [],
    );
  }

  /// `User Agreement`
  String get login_user_agree {
    return Intl.message(
      'User Agreement',
      name: 'login_user_agree',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get login_and {
    return Intl.message(
      'and',
      name: 'login_and',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get login_privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'login_privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Please read and agree to the User Agreement and Privacy Policy`
  String get login_agree_policy {
    return Intl.message(
      'Please read and agree to the User Agreement and Privacy Policy',
      name: 'login_agree_policy',
      desc: '',
      args: [],
    );
  }

  /// `Please enter phone number`
  String get login_hint_phone {
    return Intl.message(
      'Please enter phone number',
      name: 'login_hint_phone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get login_hint_password {
    return Intl.message(
      'Please enter password',
      name: 'login_hint_password',
      desc: '',
      args: [],
    );
  }

  /// `Get verification code`
  String get login_verification_code {
    return Intl.message(
      'Get verification code',
      name: 'login_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Preview`
  String get home_edit_preview {
    return Intl.message(
      'Preview',
      name: 'home_edit_preview',
      desc: '',
      args: [],
    );
  }

  /// `Rolling Banner`
  String get home_banner {
    return Intl.message(
      'Rolling Banner',
      name: 'home_banner',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting_setting {
    return Intl.message(
      'Setting',
      name: 'setting_setting',
      desc: '',
      args: [],
    );
  }

  /// `Setting Success`
  String get setting_setting_success {
    return Intl.message(
      'Setting Success',
      name: 'setting_setting_success',
      desc: '',
      args: [],
    );
  }

  /// `Modules`
  String get setting_modules {
    return Intl.message(
      'Modules',
      name: 'setting_modules',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get setting_reset {
    return Intl.message(
      'Reset',
      name: 'setting_reset',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to reset?`
  String get setting_reset_or_not {
    return Intl.message(
      'Do you want to reset?',
      name: 'setting_reset_or_not',
      desc: '',
      args: [],
    );
  }

  /// `Note: After the reset (initializing all local configurations), preview the default configuration`
  String get setting_reset_description {
    return Intl.message(
      'Note: After the reset (initializing all local configurations), preview the default configuration',
      name: 'setting_reset_description',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get setting_language {
    return Intl.message(
      'Language',
      name: 'setting_language',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get setting_theme {
    return Intl.message(
      'Dark Mode',
      name: 'setting_theme',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get setting_default_system {
    return Intl.message(
      'System',
      name: 'setting_default_system',
      desc: '',
      args: [],
    );
  }

  /// `After it is enabled, it will follow the system to turn on or off the dark mode`
  String get setting_system_description {
    return Intl.message(
      'After it is enabled, it will follow the system to turn on or off the dark mode',
      name: 'setting_system_description',
      desc: '',
      args: [],
    );
  }

  /// `Manual`
  String get setting_handle_select {
    return Intl.message(
      'Manual',
      name: 'setting_handle_select',
      desc: '',
      args: [],
    );
  }

  /// `Normal`
  String get setting_normal_type {
    return Intl.message(
      'Normal',
      name: 'setting_normal_type',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get setting_dark_type {
    return Intl.message(
      'Dark',
      name: 'setting_dark_type',
      desc: '',
      args: [],
    );
  }

  /// `Custom theme`
  String get setting_custom_theme {
    return Intl.message(
      'Custom theme',
      name: 'setting_custom_theme',
      desc: '',
      args: [],
    );
  }

  /// `Whether biometrics are supported:`
  String get setting_biometrics_support {
    return Intl.message(
      'Whether biometrics are supported:',
      name: 'setting_biometrics_support',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get setting_support {
    return Intl.message(
      'Support',
      name: 'setting_support',
      desc: '',
      args: [],
    );
  }

  /// `non-supported`
  String get setting_not_support {
    return Intl.message(
      'non-supported',
      name: 'setting_not_support',
      desc: '',
      args: [],
    );
  }

  /// `Whether to enable biometrics:`
  String get setting_biometrics_open {
    return Intl.message(
      'Whether to enable biometrics:',
      name: 'setting_biometrics_open',
      desc: '',
      args: [],
    );
  }

  /// `Available biometrics:`
  String get setting_available_biometrics {
    return Intl.message(
      'Available biometrics:',
      name: 'setting_available_biometrics',
      desc: '',
      args: [],
    );
  }

  /// `Unavailable:`
  String get setting_biometrics_unavailable {
    return Intl.message(
      'Unavailable:',
      name: 'setting_biometrics_unavailable',
      desc: '',
      args: [],
    );
  }

  /// `Save the current operation?`
  String get setting_change_alert {
    return Intl.message(
      'Save the current operation?',
      name: 'setting_change_alert',
      desc: '',
      args: [],
    );
  }

  /// `Current Language`
  String get setting_current_language {
    return Intl.message(
      'Current Language',
      name: 'setting_current_language',
      desc: '',
      args: [],
    );
  }

  /// `Authentication`
  String get local_auth {
    return Intl.message(
      'Authentication',
      name: 'local_auth',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get setting_about {
    return Intl.message(
      'About',
      name: 'setting_about',
      desc: '',
      args: [],
    );
  }

  /// `HIVE Intro`
  String get setting_about_function_introduced {
    return Intl.message(
      'HIVE Intro',
      name: 'setting_about_function_introduced',
      desc: '',
      args: [],
    );
  }

  /// `A cross-platform product architecture APP, the basic functional components are highly packaged, low coupling, according to product requirements, rapid integration, release of high-quality products.`
  String get setting_about_introduced {
    return Intl.message(
      'A cross-platform product architecture APP, the basic functional components are highly packaged, low coupling, according to product requirements, rapid integration, release of high-quality products.',
      name: 'setting_about_introduced',
      desc: '',
      args: [],
    );
  }

  /// `Comments or Suggestions`
  String get setting_about_comments_suggestions {
    return Intl.message(
      'Comments or Suggestions',
      name: 'setting_about_comments_suggestions',
      desc: '',
      args: [],
    );
  }

  /// `Checking the new version`
  String get setting_about_check_new_version {
    return Intl.message(
      'Checking the new version',
      name: 'setting_about_check_new_version',
      desc: '',
      args: [],
    );
  }

  /// `All rights reserved`
  String get setting_about_all_rights_reserved {
    return Intl.message(
      'All rights reserved',
      name: 'setting_about_all_rights_reserved',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get mine_profile_edit {
    return Intl.message(
      'Profile',
      name: 'mine_profile_edit',
      desc: '',
      args: [],
    );
  }

  /// `Tailor`
  String get mine_profile_tailor {
    return Intl.message(
      'Tailor',
      name: 'mine_profile_tailor',
      desc: '',
      args: [],
    );
  }

  /// `This image type is not supported`
  String get mine_profile_image_error {
    return Intl.message(
      'This image type is not supported',
      name: 'mine_profile_image_error',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get mine_profile_name {
    return Intl.message(
      'Name',
      name: 'mine_profile_name',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get mine_profile_id {
    return Intl.message(
      'ID',
      name: 'mine_profile_id',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get mine_profile_phone {
    return Intl.message(
      'Phone',
      name: 'mine_profile_phone',
      desc: '',
      args: [],
    );
  }

  /// `My QR Code`
  String get mine_profile_qr_code {
    return Intl.message(
      'My QR Code',
      name: 'mine_profile_qr_code',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
