import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/date_time_utils.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:base_pm2/common/resource/keylanguage_resource/key_language.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/model/report/report_by_day_model.dart';
import 'package:base_pm2/data/model/user/user_report/user_status_model.dart';
import 'package:base_pm2/data/model/widget/app/app_access_model.dart';
import 'package:base_pm2/screen/home/panel_controller.dart';
import 'package:base_pm2/screen/overview/overview_controller.dart';
import 'package:base_pm2/screen/profile/user_detail_history/violations/violations_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class IReportListener extends BaseController {
  RxList<UserStatusModel> mUsers = <UserStatusModel>[].obs;
  RxList<ProfileModel?> mProfiles = <ProfileModel?>[].obs;
  RxList<ItemStatus> mStatuses = <ItemStatus>[].obs;
  RxList<ViolationHeaderData> mHeaderData = <ViolationHeaderData>[].obs;
  RxList<AppAccessParentModel?> mDiary = <AppAccessParentModel>[].obs;
  Rx<ReportByDayModel?> mReport = ReportByDayModel().obs;
  Rx<ProfileModel?> profileSelected = ProfileModel().obs;
  RxList<ViolationHeaderData> mHistories = <ViolationHeaderData>[].obs;

  Future<void> fetchUserStatus() async {}

  Future<void> fetchProfiles() async {}

  Future<void> fetchReport() async {}

  Future<void> fetchViolationCount() async {}

  Future<void> fetchDeviceConnectingCount() async {}

  Future<void> fetchHistory() async {}

  Future<void> onProfilePressed(ProfileModel? profile) async {}

  void initHistoryHeader() {}

  void setViolationCount(int i) {
    mStatuses.singleWhereOrNull((element) => element.id == 2)!.data!.value = i.toString();
  }

  void setDeviceUseInDay(int i) {
    mStatuses.singleWhereOrNull((element) => element.id == 4)?.data?.value = i.toString();
  }

  Map<String, String> getParamForHistory() => {};

  Future<void> fetchStatuses() async {
    mStatuses.value = [
      ItemStatus(
          id: -1,
          url: ImageResource.ic_wifi,
          color: [const Color(0xFF72D462), const Color(0xFF6DCF5A)],
          textColor: const Color(0xFF79C32B),
          status: KeyLanguage.connecting.tr,
          expend: KeyLanguage.device.tr),
      ItemStatus(
          id: 2,
          url: ImageResource.ic_warning,
          color: [const Color(0xFFFC7E5E), const Color(0xFFF4572F)],
          textColor: const Color(0xFFEC4217),
          status: KeyLanguage.violation_of_the_day.tr,
          expend: KeyLanguage.violations.tr),
    ];
  }

  void onItemPress(ItemStatus status) {
    switch (status.id) {
      case 1:
        Get.toNamed(RoutePath.FAMILY_STATISTIC);
        break;
      case 2:
        Get.toNamed(RoutePath.VIOLATION, parameters: getParamForHistory());
        break;
      case 3:
      case 4:
        Get.toNamed(RoutePath.ACCESS_HISTORY, parameters: getParamForHistory());
        break;
      case 10:
        Get.find<PanelController>().onChangePage(0);
        break;
    }
  }

  List<String> getListDateFilter(int number, DateTime startTime) {
    return List.generate(
        number,
        (index) =>
            DateTimeUtils.format(startTime.subtract(Duration(days: index)), DateTimeUtils.YYYYMMDD) ?? '');
  }
}
