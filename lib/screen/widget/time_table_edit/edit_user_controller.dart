import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/repositories_impl/profile/profile_repository_impl.dart';
import 'package:base_pm2/domain/use_case/profile/save_profile_use_case.dart';
import 'package:base_pm2/screen/device/device_controller.dart';
import 'package:base_pm2/screen/overview/overview_controller.dart';
import 'package:base_pm2/screen/widget/device/dialog/device_assigned_controller.dart';
import 'package:base_pm2/screen/widget/time_table_edit/comp/list_device_controller.dart';
import 'package:base_pm2/screen/widget/time_table_edit/comp/pick_user_mode_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditUserArgs {
  String? type;

  EditUserArgs({this.type});

  EditUserArgs.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['type'] = type ?? '';
    return data;
  }
}

class EditUserController extends BaseController with GetTickerProviderStateMixin {
  TabController? tabController;

  EditUserArgs? args;
  RxList<String> mTextButtons = ['Bỏ qua', 'Tiếp tục'].obs;
  RxInt currentStep = 0.obs;

  @override
  Future initialData() async {
    args = EditUserArgs.fromJson(Get.parameters);
    tabController = TabController(length: 2, vsync: this);
    if (args?.type == UserEditType.ONLY_PICK_MODE) {
      mTextButtons.value = ['Bỏ qua', 'Hoàn tất'];
    }
    setStatus(Status.success);
  }

  void onNextStep() async {
    ViewUtils.hideKeyboard();
    final pickModeController = Get.find<PickUserModeController>();
    if (!(pickModeController.formKey.currentState?.validate() ?? true)) return;
    if (pickModeController.mModeData.where((p0) => p0.isActive?.value ?? false).isEmpty) {
      pickModeController.setError('Vui lòng chọn một chế độ');
      return;
    }
    if (args?.type == UserEditType.ONLY_PICK_MODE) {

      await _onCreateUser();
      Get.back();
      return;
    }
    if (tabController?.index == 1) {
      await _onCreateUser();
      Get.back();
      return;
    }

    mTextButtons.value = ['Quay lại', 'Hoàn tất'];
    animateTo(1);
  }

  void onPreviousStep() {
    ViewUtils.hideKeyboard();
    if (args?.type == UserEditType.ONLY_PICK_MODE) {
      Get.back();
      return;
    }
    if (tabController?.index == 0) {
      Get.back();
      return;
    }
    animateTo(0);
    mTextButtons.value = ['Bỏ qua', 'Tiếp tục'];
  }

  void animateTo(int pageIndex) {
    tabController?.animateTo(pageIndex);
    currentStep.value = pageIndex;
  }

  Future<void> _onCreateUser() async {
    setStatus(Status.waiting);

    if (args?.type == UserEditType.ONLY_PICK_MODE) {
      if (Get.isRegistered<ListDeviceController>()) {
        List<String> macs = Get.find<ListDeviceController>()
            .listDeviceModel
            .where((p0) => p0?.rxStatus?.value ?? false)
            .map((e) => e?.macAddress ?? '')
            .toList();
        await _createProfile(macs: macs);
        return;
      }
      await _createProfile();
      return;
    }
    if (args?.type == UserEditType.PICK_MODE_AND_DEVICE) {
      List<String> macs = Get.find<ListDeviceController>()
          .listDeviceModel
          .where((p0) => p0?.rxStatus?.value ?? false)
          .map((e) => e?.macAddress ?? '')
          .toList();
      await _createProfile(macs: macs);
      return;
    }

  }

  Future<bool> _createProfile({List<String>? macs}) async {
    final pickModeController = Get.find<PickUserModeController>();
    ProfileModel profileModel = ProfileModel(
        profileName: Get.find<PickUserModeController>().profileName.text.trim(),
        profileInfo: '',
        profileAvatar: '',
        dnsMode: pickModeController.mModeData.singleWhereOrNull((p0) => p0.isActive?.value ?? false)?.type,
        endUserDevices: macs ?? []);
    ApiResponse<ProfileModel?> response = await SaveProfileUseCase(
            repository: ProfileRepositoryImpl(),
            deviceId: AppConfig().getDeviceId(),
            profileModel: profileModel)
        .invoke();
    if(checkCode(response)) return checkCode(response);
    if (Get.isRegistered<DeviceController>()) Get.find<DeviceController>().fetchData();
    if (Get.isRegistered<DeviceAssignedController>())  Get.find<DeviceAssignedController>().fetchData();
    if (Get.isRegistered<UserListController>())  Get.find<UserListController>().fetchData();
    if (Get.isRegistered<OverViewController>())  Get.find<OverViewController>().fetchProfiles();
    setStatus(Status.success);
    return checkCode(response);
  }
}

class ModeModel2 {
  int? id;
  String? title;
  RxBool? isActive = false.obs;

  ModeModel2({this.id, this.title, this.isActive});
}
