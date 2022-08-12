import 'package:base_pm2/common/core/interface/i_avatar_listener.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/repositories_impl/profile/profile_repository_impl.dart';
import 'package:base_pm2/domain/use_case/profile/get_detail_profile_use_case.dart';
import 'package:base_pm2/screen/widget/user_detail_setting/user_detail_setting_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserDetailArgs {
  String? userId;

  UserDetailArgs({this.userId});

  UserDetailArgs.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['user_id'] = userId ?? '';
    return data;
  }
}

class UserDetailController extends BaseController with GetTickerProviderStateMixin, IAvatarListener {
  late TabController tabController;

  String value = '2 giờ';
  RxInt valueNumberPicker = 5.obs;
  RxInt selectedTab = 0.obs;
  RxString dnsMode = DNSMode.CHILD.obs;

  @override
  Future<void> initialData() async {
    tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        selectedTab.value = tabController.index;
      });
    setAvatar(ProfileManager().getProfile().profileAvatar ?? '');
    setName(ProfileManager().getProfile().profileName ?? '');
    setStatus(Status.success);
  }

  @override
  Future<void> fetchData() async {
    ApiResponse<ProfileModel?> response = await GetProfileDetailUseCase(
            repository: ProfileRepositoryImpl(),
            deviceId:  AppConfig().getDeviceId(),
            profileId: ProfileManager().getProfile().profileId.toString())
        .invoke();
    if (checkCode(response)) return;
    setAvatar(response.data?.profileAvatar ?? '');
    setName(response.data?.profileName ?? '');
    if (Get.isRegistered<UserDetailSettingController>()) {
      Get.find<UserDetailSettingController>().setCurrentMode(response.data?.dnsMode);
    }
    setStatus(Status.success);
  }

  void showPauseDialog() {
    Get.toNamed(RoutePath.PAUSE_DIALOG);
  }

  void showTemporarilyOpenDL() {
    Get.toNamed(RoutePath.OPEN_TMP);
  }

  void updateNumberPicker(int value) {
    valueNumberPicker.value = value;
  }

  String mapToDatetime(String numberText) {
    switch (numberText) {
      case '1':
        return '1 giờ';
      case '2':
        return '1 giờ 30 phút';
      case '3':
        return '2 giờ';
      case '4':
        return '2 giờ 30 phút';
      case '5':
        return '3 giờ';
      default:
        return '3 giờ 30 phút';
    }
  }

  @override
  void onImagePicked(XFile? file) {
    // TODO: implement onImagePicked
  }
}
