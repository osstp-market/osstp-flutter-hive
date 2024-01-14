import 'crypto_utils.dart';

extension StringExtension on String {
  int? toInt() {
    return int.tryParse(this);
  }

  double? toDouble() {
    return double.tryParse(this);
  }

  String toMD5() {
    return cryptoMD5(this);
  }
}

bool itIsEmpty(dynamic value) {
  if (value == null || value == "") {
    return true;
  }
  return false;
}

bool itIsNotEmpty(dynamic value) {
  return !itIsEmpty(value);
}

bool itIsInt(dynamic value) {
  if (!itIsEmpty(value) && value is int) {
    return true;
  }
  return false;
}

bool itIsDouble(dynamic value) {
  if (!itIsEmpty(value) && value is double) {
    return true;
  }
  return false;
}

bool itIsString(dynamic value) {
  if (!itIsEmpty(value) && value is String) {
    return true;
  }
  return false;
}

/// Forced return string
///
/// value = null 时，
/// return [""] or [placeholder]
String stringValue(String? value, {String? placeholder}) {
  if (itIsEmpty(value)) {
    return placeholder ?? "";
  } else {
    return value!;
  }
}
