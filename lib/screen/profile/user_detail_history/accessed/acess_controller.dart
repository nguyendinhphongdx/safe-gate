import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/screen/profile/user_detail_history/violations/violations_controller.dart';
import 'package:expandable/expandable.dart';

class AccessController extends BaseController {
  List<ViolationHeaderData> violationHeaders = [];

  @override
  Future<void> initialData() async {
    DateTime now = DateTime.now();
    violationHeaders = [
      ViolationHeaderData(
          id: 0,
          title: DateTimeUtils.getTitleByIndex(0, now),
          date: now,
          dateTime: DateTimeUtils.format(now, DateTimeUtils.YYYYMMDD),
          expandableController: ExpandableController()..toggle()),
      ViolationHeaderData(
          id: 1,
          title: DateTimeUtils.getTitleByIndex(1, now),
          date: now.subtract(const Duration(days: 1)),
          dateTime: DateTimeUtils.format(now.subtract(const Duration(days: 1)), DateTimeUtils.YYYYMMDD)),
      ViolationHeaderData(
          id: 2,
          title: DateTimeUtils.getTitleByIndex(2, now),
          date: now.subtract(const Duration(days: 2)),
          dateTime: DateTimeUtils.format(now.subtract(const Duration(days: 2)), DateTimeUtils.YYYYMMDD)),
    ];
  }
}
