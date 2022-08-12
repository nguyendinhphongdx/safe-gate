import 'package:base_pm2/common/core/interface/i_report_listener.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/report/report_by_day_model.dart';
import 'package:base_pm2/data/repositories_impl/device/device_repository_impl.dart';
import 'package:base_pm2/domain/use_case/device/get_violation_count_use_case.dart';
import 'package:base_pm2/domain/use_case/report/get_report_by_profile_id_use_case.dart';
import 'package:base_pm2/screen/overview/overview_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_manager.dart';
import 'package:base_pm2/screen/widget/violation/violation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportLayoutController extends IReportListener {
  @override
  Future initialData() async {
    fetchStatuses();
    getDeviceConnecting();
    await fetchViolationCount();
    await fetchReport();
    setStatus(Status.success);
  }

  @override
  Future<void> fetchReport() async {
    DateTime now = DateTime.now();
    List<String> dates = getListDateFilter(5, now);
    ApiResponse<ReportByDayModel?> response = await GetReportByProfileIdUseCase(
            repository: DeviceRepositoryImpl(),
            deviceId: AppConfig().getDeviceId(),
            profileId: ProfileManager().getProfile().profileId.toString(),
            dateTimes: dates)
        .invoke();
    if (checkCode(response)) return;
    if (checkNull(response)) return;
    mReport.value = response.data ?? ReportByDayModel();
  }

  @override
  Map<String, String> getParamForHistory() {
    return TimeLineHistoryArgs(
      startTime: DateTimeUtils.format(DateTime.now().subtract(const Duration(days: 5)), DateTimeUtils.DDMMYYYY),
      endTime: DateTimeUtils.format(DateTime.now(), DateTimeUtils.DDMMYYYY),
      profileId: ProfileManager().getProfile().profileId.toString(),
    ).toJson();
  }

  @override
  Future<void> fetchStatuses() async {
    mStatuses.value = [
      ItemStatus(
          id: 5,
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

  void getDeviceConnecting() {
    mStatuses.singleWhereOrNull((element) => element.id == 5)?.data?.value =
        (ProfileManager().getProfile().deviceConnecting ?? 0).toString();
  }

  @override
  Future<void> fetchViolationCount() async {
    List<String> dates = getListDateFilter(1, DateTime.now());
    int count = await GetViolationCountByProfileIdUseCase(
            repository: DeviceRepositoryImpl(),
            deviceId: AppConfig().getDeviceId(),
            profileId: ProfileManager().getProfile().profileId.toString(),
            dateTime: dates)
        .invoke();
    setViolationCount(count);
  }
}
