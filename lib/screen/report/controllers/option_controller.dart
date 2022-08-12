import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/interface/i_date_picker_listener.dart';
import 'package:base_pm2/common/core/interface/i_report_listener.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/count_down.dart';
import 'package:base_pm2/common/core/widget/date_picker/body_picker.dart';
import 'package:base_pm2/common/core/widget/date_picker/body_picker_controller.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/model/profile/report_profile_model.dart';
import 'package:base_pm2/data/model/report/report_by_day_model.dart';
import 'package:base_pm2/data/repositories_impl/device/device_repository_impl.dart';
import 'package:base_pm2/domain/use_case/report/get_report_by_profile_id_use_case.dart';
import 'package:base_pm2/domain/use_case/widget/get_violation_and_device_count_by_profile_use_case.dart';
import 'package:base_pm2/screen/overview/overview_controller.dart';
import 'package:base_pm2/screen/profile/user_detail_history/violations/violations_controller.dart';
import 'package:base_pm2/screen/report/report_controller.dart';
import 'package:base_pm2/screen/widget/violation/violation_controller.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OptionController extends IReportListener with IDatePickerListener {
  CountTimer countTimer = CountTimer(500);
  Rx<ReportProfileModel?> mReportProfileModel = ReportProfileModel().obs;
  PickTimeModel? pickTimeModel;

  @override
  Future initialData() async {
    pickTimeModel = PickTimeModel(DateTime.now().subtract(const Duration(days: 30)), DateTime.now());
    mProfiles = Get.find<ReportController>().mProfiles;
    await fetchStatuses();
    await fetchData();

    setStatus(Status.success);
  }

  List<String> getDateStringsFromTimes() {
    int diff = pickTimeModel?.rxEndTime?.value.difference(pickTimeModel!.rxStartTime!.value).inDays ?? 0;
    showLog(diff);
    return List.generate(diff + 1,
        (index) => DateTimeUtils.format(pickTimeModel?.rxEndTime?.value.subtract(Duration(days: index)), DateTimeUtils.YYYYMMDD) ?? '');
  }

  Future<void> _callDataByUserSelected() async {
    ProfileModel? selectedTmp = mProfiles.singleWhereOrNull((element) => element?.isSelected.value == true);
    if (selectedTmp?.profileId == null) return;
    if (selectedTmp?.profileId == profileSelected.value?.profileId) return;
    profileSelected.value = selectedTmp;
    await fetchViolationCount();
    await fetchReport();
    await fetchHistory();

  }

  @override
  Map<String, String> getParamForHistory() {
    return TimeLineHistoryArgs(
      startTime: DateTimeUtils.format(pickTimeModel?.rxStartTime?.value, DateTimeUtils.DDMMYYYY),
      endTime: DateTimeUtils.format(pickTimeModel?.rxEndTime?.value, DateTimeUtils.DDMMYYYY),
      profileId: profileSelected.value?.profileId.toString(),
    ).toJson();
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
  Future<void> onPicker() async {
    var result = await Get.toNamed(RoutePath.DATE_PICKER,
        parameters: BodyPickerArgs(
                startTime: DateTimeUtils.format(pickTimeModel?.rxStartTime?.value, DateTimeUtils.DDMMYYYY),
                endTime: DateTimeUtils.format(pickTimeModel?.rxEndTime?.value, DateTimeUtils.DDMMYYYY))
            .toJson());
    if (result == null) return;
    pickTimeModel?.rxStartTime?.value = result.startTime;
    pickTimeModel?.rxEndTime?.value = result.endTime;
    await fetchViolationCount();
    fetchStatuses();
    await fetchReport();
    await fetchHistory();
  }

  @override
  Future<void> fetchReport() async {
    ApiResponse<ReportByDayModel?> response = await GetReportByProfileIdUseCase(
            repository: DeviceRepositoryImpl(),
            deviceId: AppConfig().getDeviceId(),
            profileId: profileSelected.value?.profileId.toString(),
            dateTimes: getDateStringsFromTimes())
        .invoke();
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
    int diff = pickTimeModel?.rxEndTime?.value.difference(pickTimeModel!.rxStartTime!.value).inDays ?? 0;
    mHistories.clear();
    await delay(100);
    mHistories.value = List.generate(
        diff + 1,
        (index) => ViolationHeaderData(
            dateTime: DateTimeUtils.format(
                pickTimeModel?.rxEndTime?.value.subtract(Duration(days: index)), DateTimeUtils.YYYYMMDD),
            id: index,
            date: pickTimeModel?.rxEndTime?.value.subtract(Duration(days: index)),
            expandableController: (index == 0) ? (ExpandableController()..toggle()) : null,
            title: DateTimeUtils.getTitleByIndex(index, pickTimeModel!.rxEndTime!.value)));
  }

  @override
  Future<void> fetchViolationCount() async {
    ViolationDeviceModel violationDeviceModel = await GetViolationAndDeviceCountByProfileUseCase(
            deviceId: AppConfig().getDeviceId(),
            profileId: profileSelected.value?.profileId.toString(),
            dateTimes: getDateStringsFromTimes())
        .invoke();
    setViolationCount(violationDeviceModel.violationCount ?? 0);
    setDeviceUseInDay(violationDeviceModel.deviceUsedCount ?? 0);
  }

  @override
  Future<void> fetchData() async {
    await _callDataByUserSelected();
  }
}
