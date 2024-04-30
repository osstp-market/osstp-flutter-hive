import 'package:flutter/cupertino.dart';
import 'package:osstp_flutter_hive/common/utils/show_dialog.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

enum DateTimePickerType {
  date,
  time,
  datetime,
  yearMonth,
  year,
  month,
  week,
  hourMinute,
  hourMinuteSecond,
  minuteSecond,
  second,
  yearMonthDay,
  yearMonthDayHourMinute,
  yearMonthDayHourMinuteSecond,
  yearMonthDayHourMinuteSecondMs,
  yearMonthDayHourMinuteSecondMsMs,
  yearMonthDayHourMinuteSecondMsMsMs,
  yearMonthDayHourMinuteSecondMsMsMsMs,
}

class DateTimePicker {
  static show(BuildContext context,
      {required String title,
      DateTimePickerType type = DateTimePickerType.yearMonthDayHourMinute,
      DateTime? checkStartDateTime,
      DateTime? checkEndDateTime,
      ValueChanged? onCancel,
      ValueChanged<DateTime>? onConfirm,
      DateTime? initialDate}) {
    List<int>? initDate;
    if (initialDate != null) {
      initDate = [
        initialDate.year,
        initialDate.month,
        initialDate.day,
        initialDate.hour,
        initialDate.minute,
        initialDate.second
      ];
    }

    bool useHour = false;
    bool useMinute = false;
    if (type == DateTimePickerType.yearMonthDayHourMinute) {
      useHour = true;
      useMinute = true;
    }

    TDPicker.showDatePicker(context,
        title: title,
        useHour: useHour,
        useMinute: useMinute,
        initialDate: initDate,
        dateEnd: [3000, 12, 31], onCancel: (result) {
      if (onCancel != null) onCancel(result);
      Navigator.of(context).pop();
    }, onConfirm: (result) {
      if (checkStartDateTime != null) {
        if (checkStartDateTime.isAfter(DateTime(result['year']!.toInt(), result['month']!.toInt(),
            result['day']!.toInt(), result['hour']!.toInt(), result['minute']!.toInt()))) {
          showGetXGeneralDialog(title: "提醒", content: "结束时间不能早于开始时间");
        } else {
          _popFormat(context, type, result, onConfirm);
        }
      } else if (checkEndDateTime != null) {
        if (checkEndDateTime.isBefore(DateTime(result['year']!.toInt(), result['month']!.toInt(),
            result['day']!.toInt(), result['hour']!.toInt(), result['minute']!.toInt()))) {
          showGetXGeneralDialog(title: "提醒", content: "开始时间不能晚于结束时间");
        } else {
          _popFormat(context, type, result, onConfirm);
        }
      } else {
        _popFormat(context, type, result, onConfirm);
      }
    });
  }

  static _popFormat(
      BuildContext context, DateTimePickerType type, Map<String, int> result, ValueChanged<DateTime>? onConfirm) {
    switch (type) {
      case DateTimePickerType.yearMonthDayHourMinute:
        DateTime datetime = DateTime(
          result['year']!.toInt(),
          result['month']!.toInt(),
          result['day']!.toInt(),
          result['hour']!.toInt(),
          result['minute']!.toInt(),
        );

        if (onConfirm != null) onConfirm(datetime);
        break;
      case DateTimePickerType.hourMinute:
        DateTime dateTime = DateTime.now();
        DateTime datetime = DateTime(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          result['hour']!.toInt(),
          result['minute']!.toInt(),
        );

        if (onConfirm != null) onConfirm(datetime);
        break;
      case DateTimePickerType.yearMonthDay:
        DateTime datetime = DateTime(
          result['year']!.toInt(),
          result['month']!.toInt(),
          result['day']!.toInt(),
        );

        if (onConfirm != null) onConfirm(datetime);
        break;
    }
    Navigator.of(context).pop();
  }
}
