import 'package:base_pm2/common/core/sys/base_function.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeUtils {
  static const String DDMMYYYYHMS = 'dd/MM/yyyy HH:mm:ss';
  static const String YYYYMMDDHMS = 'yyyy/MM/dd HH:mm:ss';
  static const String YYYYMMDDHMS_ = 'yyyy-MM-dd HH:mm:ss';
  static const String HM_DDMMYYYY = 'HH:mm dd/MM/yyyy';
  static const String HHMM = 'HH:mm';
  static const String YYYYMMDD = 'yyyyMMdd';
  static const String DDMMYYYY = 'dd/MM/yyyy';
  static const String MMMMDDYYYY = 'MMMM dd, yyyy';
  static const String DDMMMMYYYY = ' dd MMMM, yyyy';

  static String? convertTo(String? data, String currentPattern, String toPattern) {
    if (data == null) return null;
    try {
      return DateFormat(toPattern).format(DateFormat(currentPattern).parse(data));
    } catch (exception) {
      showError(exception.toString());
    }
    return null;
  }

  static String? intToFormat(int? data, String toPattern) {
    if (data == null) return null;
    try {
      return DateFormat(toPattern).format(DateTime.fromMillisecondsSinceEpoch(data * 1000));
    } catch (exception) {
      showError(exception.toString());
    }
    return null;
  }

  static String? format(DateTime? currentDate, String toPattern) {
    if (currentDate == null) return null;
    try {
      return DateFormat(toPattern, Get.locale?.languageCode).format(currentDate);
    } catch (exception) {
      showError(exception.toString());
    }
    return null;
  }

  static DateTime? parse(String? data, String toPattern, {bool isUTC = false}) {
    if (data == null) return null;
    try {
      return DateFormat(toPattern).parse(data, isUTC);
    } catch (exception) {
      showError(exception.toString());
    }
    return null;
  }

  static DateTime? intParse(int data) {
    try {
      return DateTime.fromMillisecondsSinceEpoch(data * 1000);
    } catch (exception) {
      showError(exception.toString());
    }
    return null;
  }

  static DateTime? dToD(DateTime data, String fromPattern, String toPattern) {
    try {
      return parse(format(data, fromPattern) ?? '', toPattern);
    } catch (exception) {
      showError(exception.toString());
    }
    return null;
  }

  static DateTime custom({int? mYear, int? mMonth, int? mDay, int? mHour, int? mMinute}) {
    DateTime now = DateTime.now();
    return DateTime(
        mYear ?? now.year, mMonth ?? now.month, mDay ?? now.day, mHour ?? now.hour, mMinute ?? now.hour);
  }

  static int getSeconds({DateTime? date}) {
    DateTime now = date ?? DateTime.now();
    return now.millisecondsSinceEpoch ~/ 1000;
  }

  static String getTitleByIndex(int index, DateTime now) {
    String s = format(now.subtract(Duration(days: index)), MMMMDDYYYY) ?? '';
    switch (index) {
      case 0:
        String sNow = format(DateTime.now().subtract(const Duration(days: 0)), MMMMDDYYYY) ?? '';
        return s == sNow ? 'Hôm nay' : s;
      case 1:
        String sSecond = format(DateTime.now().subtract(const Duration(days: 1)), MMMMDDYYYY) ?? '';
        return s == sSecond ? 'Hôm qua' : s;
      case 2:
        String sThird = format(DateTime.now().subtract(const Duration(days: 2)), MMMMDDYYYY) ?? '';
        return s == sThird ? 'Hôm kia' : s;
    }
    return s;
  }

  static String getTitleByDate(DateTime? now) {
    String s = format(now, DDMMMMYYYY) ?? '';

    String sNow = format(DateTime.now().subtract(const Duration(days: 0)), DDMMMMYYYY) ?? '';
    if (s == sNow) return 'Hôm nay';

    String sSecond = format(DateTime.now().subtract(const Duration(days: 1)), DDMMMMYYYY) ?? '';
    if (s == sSecond) return 'Hôm qua';

    String sThird = format(DateTime.now().subtract(const Duration(days: 2)), DDMMMMYYYY) ?? '';
    if (s == sThird) return 'Hôm kia';

    return s;
  }

  static String getTitleReport(String? now, {bool withTextConverter = true}) {
    String? year = now?.substring(0, 4);
    String? month = now?.substring(4, 6);
    String? day = now?.substring(6, 8);
    String s = '$day/$month/$year';
    if (s == format(DateTime.now(), DateTimeUtils.DDMMYYYY) && withTextConverter) return 'Hôm nay';
    return s;
  }

  static String convertWeekDay(int? weekday) {
    switch (weekday) {
      case 2:
        return KeyLanguage.mon.tr;
      case 3:
        return KeyLanguage.tue.tr;
      case 4:
        return KeyLanguage.wed.tr;
      case 5:
        return KeyLanguage.thu.tr;
      case 6:
        return KeyLanguage.fri.tr;

      case 7:
        return KeyLanguage.sat.tr;
      case 8:
        return KeyLanguage.sun.tr;
    }
    return '';
  }

  static String toTimeFormat(String key) {
    int size = key.length;
    if (size == 1) return '00:0$key';
    if (size == 2) return '00:$key';
    if (size == 3) return '0${key.substring(0, 1)}:${key.substring(1, 3)}';
    if (size == 4) return '${key.substring(0, 2)}:${key.substring(2, 4)}';

    return '';
  }
}
