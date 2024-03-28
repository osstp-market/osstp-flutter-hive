import 'package:date_format/date_format.dart';

class DateFormatUtils {
  static List<String> yyyymmdd = [yyyy, '/', mm, '/', dd];
  static List<String> ymd = [yyyy, '-', mm, '-', dd];
  static List<String> yyyymm = [yyyy, '/', mm];
  static List<String> ym = [yyyy, '-', mm];
  static List<String> ymdhns = [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss];
  static List<String> ymdhn = [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn];
  static List<String> ymdh = [yyyy, '-', mm, '-', dd, ' ', HH];
  static List<String> yearMonth = [yyyy, '年', mm, '月'];


  // 【日期方法一】： 输入对象月，可以得到对象月的末日
  String getCurrentMonthLastDay(String date) {
    DateTime currentDate = DateTime.parse('$date-01');
    DateTime newDate = DateTime(currentDate.year, currentDate.month + 1, 0);
    return formatDate(newDate, DateFormatUtils.ymd);
  }

  // 【日期方法二】： 输入对象月，可以得到対象月前月初日
  String getLastMonthFirstDay(String date) {
    DateTime currentDate = DateTime.parse('$date-00');
    DateTime newDate = DateTime(currentDate.year, currentDate.month, 1);
    return formatDate(newDate, DateFormatUtils.ymd);
  }

  //【日期方法三】 输入对象月，可以得到当前月日期
  String getCurrentDay(String date) {
    DateTime currentDate = DateTime.parse('$date-01');

    var nowDate = DateTime.now();
    int nowYear = nowDate.year;
    int nowMonth = nowDate.month;

    /// 如果系统时间的年月 和 当前月的年月不相等， 则当前月日期 为 当前月日期的末日
    if (nowYear != currentDate.year && nowMonth != currentDate.month) {
      DateTime newDate = DateTime(currentDate.year, currentDate.month + 1, 0);
      return formatDate(newDate, DateFormatUtils.ymd);
    } else {
      return formatDate(nowDate, DateFormatUtils.ymd);
    }
  }

// 用来计算距离终了月的前13个月的月份
//   DateTime tempFromDate = DateTime(fromDate.year, fromDate.month, toDate.day - 1);
//   DateTime tempToDate = DateTime(toDate.year - 1, toDate.month - 1, toDate.day);


}
