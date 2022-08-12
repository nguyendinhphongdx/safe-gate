import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/data/model/profile/report_profile_model.dart';
import 'package:base_pm2/data/model/widget/app/app_access_model.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';

class ViolationsController extends BaseController {
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

class ViolationHeaderData {
  int? id;
  String? dateTime;
  DateTime? date;
  String? title;
  ExpandableController? expandableController;
  RxBool? isExpanded;
  ReportProfileModel? reportProfileModel;
  Rx<ReportProfileModel>? rxReportProfileModel;
  AppAccessParentModel? accessParentModel;

  ViolationHeaderData(
      {this.id, this.dateTime, this.date, this.title, this.expandableController, this.reportProfileModel}) {
    (expandableController ??= ExpandableController()).addListener(() {
      isExpanded?.value = expandableController?.expanded ?? false;
    });
    isExpanded = expandableController?.expanded.obs;
    rxReportProfileModel = ReportProfileModel().obs;
  }

  void onExpandedClick(List<ViolationHeaderData> mHeader) {
    mHeader.where((element) => element.expandableController?.expanded ?? false).forEach((element) {
      element.expandableController?.expanded = false;
    });
    expandableController?.toggle();
  }
}
