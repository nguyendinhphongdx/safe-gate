import 'package:base_pm2/common/core/interface/i_report_listener.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/count_down.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/model/profile/report_profile_model.dart';
import 'package:base_pm2/data/model/report/report_by_day_model.dart';
import 'package:base_pm2/data/repositories_impl/device/device_repository_impl.dart';
import 'package:base_pm2/domain/use_case/device/get_history_by_device_id_use_case.dart';
import 'package:base_pm2/domain/use_case/report/get_report_by_profile_id_use_case.dart';
import 'package:base_pm2/domain/use_case/widget/get_violation_and_device_count_by_profile_use_case.dart';
import 'package:base_pm2/screen/overview/overview_controller.dart';
import 'package:base_pm2/screen/report/report_controller.dart';
import 'package:base_pm2/screen/widget/violation/violation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayController extends IReportListener {
  CountTimer countTimer = CountTimer(500);
  Rx<ReportProfileModel?> mReportProfileModel = ReportProfileModel().obs;

  @override
  Future initialData() async {
    mProfiles = Get.find<ReportController>().mProfiles;
    await fetchStatuses();
    await fetchData();

    setStatus(Status.success);
  }

  Future<void> _callDataByUserSelected() async {
    ProfileModel? selectedTmp = mProfiles.singleWhereOrNull((element) => element?.isSelected.value == true);
    if (selectedTmp?.profileId == null) return;
    if (selectedTmp?.profileId == profileSelected.value?.profileId) return;
    profileSelected.value = selectedTmp;

    await fetchViolationCount();
    await fetchUserStatus();

    await fetchReport();
    await fetchHistory();
  }

  @override
  Future<void> fetchStatuses() async {
    mStatuses.value = [
      ItemStatus(
        id: 2,
        url: ImageResource.ic_warning,
        color: [
          const Color(0xFFFC7E5E),
          const Color(0xFFF4572F),
        ],
        textColor: const Color(0xFFEC4217),
        status: KeyLanguage.violation_of_the_day.tr,
        expend: KeyLanguage.violations.tr,
      ),
      ItemStatus(
          id: 4,
          url: ImageResource.ic_clock_1,
          color: [
            const Color(0xFFF6A200),
            const Color(0xFFE79900),
          ],
          textColor: const Color(0xFFDC9100),
          status: KeyLanguage.device_use_in_day.tr,
          expend: KeyLanguage.device.tr),
    ];
  }

  @override
  Map<String, String> getParamForHistory() {
    return TimeLineHistoryArgs(
      startTime: DateTimeUtils.format(DateTime.now(), DateTimeUtils.DDMMYYYY),
      endTime: DateTimeUtils.format(DateTime.now(), DateTimeUtils.DDMMYYYY),
      profileId: profileSelected.value?.profileId.toString(),
    ).toJson();
  }

  @override
  Future<void> fetchReport() async {
    ApiResponse<ReportByDayModel?> response = await GetReportByProfileIdUseCase(
        repository: DeviceRepositoryImpl(),
        deviceId: AppConfig().getDeviceId(),
        profileId: profileSelected.value?.profileId.toString(),
        dateTimes: [DateTimeUtils.format(DateTime.now(), DateTimeUtils.YYYYMMDD) ?? '']).invoke();
    // if (checkCode(response)) return;
    // if (checkNull(response.data)) return;

    mReport.value = response.data ?? ReportByDayModel();
  }

  @override
  Future<void> onProfilePressed(ProfileModel? profile) async {
    mProfiles.forEach((element) => element?.isSelected.value = false);
    profile?.isSelected.value = true;
    countTimer.start(_callDataByUserSelected);
  }

  @override
  Future<void> fetchHistory() async {
    ApiResponse<ReportProfileModel?> response = await GetHistoryByDeviceIdUseCase(
            repository: DeviceRepositoryImpl(),
            deviceId: AppConfig().getDeviceId(),
            profileId: profileSelected.value?.profileId.toString(),
            dateTime: DateTimeUtils.format(DateTime.now(), DateTimeUtils.YYYYMMDD))
        .invoke();
    // if (response.data == null) return;
    mReportProfileModel.value = response.data ?? ReportProfileModel();
  }

  @override
  Future<void> fetchViolationCount() async {
    ViolationDeviceModel violationDeviceModel = await GetViolationAndDeviceCountByProfileUseCase(
        deviceId: AppConfig().getDeviceId(),
        profileId: profileSelected.value?.profileId.toString(),
        dateTimes: [DateTimeUtils.format(DateTime.now(), DateTimeUtils.YYYYMMDD) ?? '']).invoke();

    setViolationCount(violationDeviceModel.violationCount ?? 0);
    setDeviceUseInDay(violationDeviceModel.deviceUsedCount ?? 0);
  }

  @override
  Future<void> fetchData() async {
    await _callDataByUserSelected();
  }
}
