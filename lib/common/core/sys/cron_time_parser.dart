import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/constant.dart';

class CronTimeParser {
  String? minute = '00';
  String? hour = '00';
  List<int>? weekday = [];

  CronTimeParser({this.minute, this.hour, this.weekday});

  void parse(String? cron) {
    if (cron == null) return;

    List<String> splits = cron.split(' ');
    showLog(splits);
    minute = splits[0];
    hour = splits[1];
    if (splits[4] == '*') {
      weekday = [2, 3, 4, 5, 6, 7, 8];
      return;
    }
    weekday = splits[4].split(',').map((e) => _cronToInt(e)).toList();
  }

  int _cronToInt(String s) {
    switch (s) {
      case CronWeekDay.MON:
        return 2;
      case CronWeekDay.TUE:
        return 3;
      case CronWeekDay.WED:
        return 4;
      case CronWeekDay.THU:
        return 5;
      case CronWeekDay.FRI:
        return 6;
      case CronWeekDay.SAT:
        return 7;
      case CronWeekDay.SUN:
        return 8;
    }
    return -1;
  }

  String _cronToString(int i) {
    switch (i) {
      case 2:
        return CronWeekDay.MON;
      case 3:
        return CronWeekDay.TUE;
      case 4:
        return CronWeekDay.WED;
      case 5:
        return CronWeekDay.THU;
      case 6:
        return CronWeekDay.FRI;
      case 7:
        return CronWeekDay.SAT;
      case 8:
        return CronWeekDay.SUN;
    }
    return '';
  }

  String toCron() => '$minute $hour * * ${weekday?.map((e) => _cronToString(e)).join(',')}';

  static String getHour(String? s) => s?.substring(0, 2) ?? '';

  static String getMinute(String? s) => s?.substring(3, 5) ?? '';

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }
}
