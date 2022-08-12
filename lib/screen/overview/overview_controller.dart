import 'package:base_pm2/common/core/interface/i_report_listener.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/home/brief_report_model.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/model/report/report_model.dart';
import 'package:base_pm2/data/repositories_impl/device/device_repository_impl.dart';
import 'package:base_pm2/data/repositories_impl/profile/profile_repository_impl.dart';
import 'package:base_pm2/domain/use_case/home/get_ratio_device_online_unknown_use_case.dart';
import 'package:base_pm2/domain/use_case/profile/get_all_profile_context_use_case.dart';
import 'package:base_pm2/domain/use_case/report/get_report_by_device_id_use_case.dart';
import 'package:base_pm2/domain/use_case/widget/get_violation_count_by_device_id_use_case.dart';
import 'package:base_pm2/screen/widget/time_table_edit/edit_user_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverViewController extends IReportListener {
  Rx<BriefReportModel> briefModel = BriefReportModel().obs;
  RxList<ProfileModel?> listUser = <ProfileModel?>[].obs;
  Rx<ReportModel> mReportData = ReportModel().obs;

  @override
  Future<void> initialData() async {
    setStatus(Status.loading);
    fetchStatuses();
    fetchData();

    setStatus(Status.success);
  }

  @override
  Future<void> fetchData() async {
    fetchDeviceConnectingCount();
    fetchUserStatus();
    fetchReport();
    fetchProfiles();
    fetchViolationCount();
  }

  @override
  Future<void> fetchReport() async {
    ApiResponse<ReportModel?> response = await GetReportByDeviceIdUseCase(
            repository: DeviceRepositoryImpl(),
            deviceId: AppConfig().getDeviceId(),
            date: DateTimeUtils.format(DateTime.now(), DateTimeUtils.YYYYMMDD))
        .invoke();
    if (response.data == null) return;
    if (response.err?.code != CodeConstant.OK) return;
    mReportData.value = response.data?? ReportModel();
    mReportData.value.profiles
        ?.removeWhere((element) => element?.reportModels == null || element?.reportModels?.length == 0);
  }

  @override
  Future<void> fetchStatuses() async {
    mStatuses.value = [
      ItemStatus(
          id: 10,
          url: ImageResource.ic_wifi,
          color: [const Color(0xFF72D462), const Color(0xFF6DCF5A)],
          textColor: const Color(0xFF79C32B),
          status: KeyLanguage.unmanaged_device.tr,
          expend: KeyLanguage.device.tr),
      ItemStatus(
          id: 8,
          url: ImageResource.ic_warning,
          color: [const Color(0xFFFC7E5E), const Color(0xFFF4572F)],
          textColor: const Color(0xFFEC4217),
          status: KeyLanguage.violation_of_the_day.tr,
          expend: KeyLanguage.violations.tr),
    ];
  }

  @override
  Future<void> fetchProfiles() async {
    ApiResponse<List<ProfileModel?>?> response = await GetAllProfileContextUseCase(
            repository: ProfileRepositoryImpl(), deviceId: AppConfig().getDeviceId())
        .invoke();

    if (response.err?.code != CodeConstant.OK) return;
    listUser.value = response.data ?? [];
    listUser.removeWhere((element) => !Utils.isNotNullAndEmpty(element?.mEndUserDevices));
  }

  @override
  Future<void> fetchDeviceConnectingCount() async {
    RatioDeviceModel response = await GetRatioDeviceOnlineUnknowUseCase().invoke();

    setDeviceConnectingCount(response.managed ?? 0, response.total ?? 0);
  }

  @override
  Future<void> fetchViolationCount() async {
    int count = await GetViolationCountByDeviceIdUseCase(
        repository: DeviceRepositoryImpl(),
        deviceId: AppConfig().getDeviceId(),
        dateTime: [DateTimeUtils.format(DateTime.now(), DateTimeUtils.YYYYMMDD) ?? '']).invoke();
    setViolationCount(count);
  }

  void setDeviceConnectingCount(int unknown, int total) {
    mStatuses.singleWhereOrNull((element) => element.id == 10)?.data?.value = unknown.toString();
    mStatuses.singleWhereOrNull((element) => element.id == 10)?.total?.value = total.toString();
  }

  @override
  void setViolationCount(int i) {
    mStatuses.singleWhereOrNull((element) => element.id == 8)?.data?.value = i.toString();
  }

  void onDeviceConfig() {
    Get.toNamed(RoutePath.SEARCH_DEVICE);
  }

  void onAddUser() {
    Get.toNamed(RoutePath.TIME_TABLE_EDIT,
        parameters: EditUserArgs(type: UserEditType.PICK_MODE_AND_DEVICE).toJson());
  }

  void onSupport() {
    ViewUtils.openUrl('https://zalo.me/pc');
    // Get.toNamed(RoutePath.ADD_APPLICATION);
  }

  void onNotification() {}

  void onChangeStatus(ProfileModel? listUser) {
    listUser?.status.value =
        listUser.status.value == UserStatus.ACTIVE ? UserStatus.PAUSE : UserStatus.ACTIVE;
  }

  void onUserPressed(ProfileModel? user) {
    ProfileManager().setProfileModel(user);
    Get.toNamed(RoutePath.USER_DETAIL);
  }
}

class ItemStatus {
  int? id;
  String? url;
  String? status;
  RxString? data;
  RxString? total;
  String? expend;
  List<Color>? color;
  Color? textColor;

  ItemStatus(
      {this.id, this.textColor, this.color, this.url, this.status, this.data, this.expend, this.total}) {
    data ??= '0'.obs;
    total ??= ''.obs;
  }
}

class ItemUser {
  RxString? status;

  ItemUser({this.status});
}
