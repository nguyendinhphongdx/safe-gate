import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/constant.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/enum_resource.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/repositories_impl/device/user_device_management_repository_impl.dart';
import 'package:base_pm2/data/repositories_impl/profile/profile_repository_impl.dart';
import 'package:base_pm2/domain/use_case/device/add_multi_device_use_case.dart';
import 'package:base_pm2/domain/use_case/profile/get_all_profile_context_use_case.dart';
import 'package:base_pm2/screen/device/device_controller.dart';
import 'package:base_pm2/screen/overview/overview_controller.dart';
import 'package:base_pm2/screen/widget/time_table_edit/edit_user_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_list_controller.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';

class DeviceAssignedArgs {
  DeviceModel? model;

  DeviceAssignedArgs({this.model});
}

class DeviceAssignedController extends BaseController {
  DeviceAssignedArgs? args;
  RxList<ProfileModel?> mProfiles = <ProfileModel?>[].obs;
  RxList<ProfileModel?> mProfilesReversed = <ProfileModel?>[].obs;

  Future<void> onSaveData() async {
    ProfileModel? profile = mProfiles.singleWhereOrNull((element) => element?.isSelected.value ?? false);
    ApiResponse<dynamic> response = await AddMultiDeviceUseCase(
            repository: UserDeviceManagementRepositoryImpl(),
            macIds: [
              ...profile?.mEndUserDevices?.map((e) => e?.macAddress ?? '').toList() ?? [],
              args?.model?.macAddress ?? ''
            ],
            deviceId: AppConfig().getDeviceId(),
            profileId: profile?.profileId.toString())
        .invoke();
    // ApiResponse<dynamic> response = await AddDeviceConnectedUseCase(
    //         repository: UserDeviceManagementRepositoryImpl(),
    //         devicesModel: DeviceModel(macAddress: args?.model?.macAddress,),
    //         deviceId:  AppConfig().getDeviceId(),
    //         profileId: profile?.profileId.toString())
    //     .invoke();
    if (checkCode(response)) return;
    if (Get.isRegistered<DeviceController>()) Get.find<DeviceController>().fetchData();
    if (Get.isRegistered<UserListController>()) Get.find<UserListController>().fetchData();
    if (Get.isRegistered<OverViewController>()) Get.find<OverViewController>().fetchData();
    Get.back();
  }

  Future<void> onDisconnect() async {
    // ConnectedDevicesModel deviceModel = ConnectedDevicesModel(device: args?.model);
    // String? userId =
    //     mUsers.singleWhereOrNull((element) => element.user?.isSelected?.value == true)?.user?.uid;
    // deviceModel.uid = userId;
    // deviceModel.permitStatus = false;
    // ApiResponse<ConnectedDevicesModel?> response = await AddDeviceConnectedUseCase(
    //         repository: UserDeviceManagementRepositoryImpl(), devicesModel: deviceModel)
    //     .invoke();
    // if (checkCode(response)) return;
    Get.back();
  }

  @override
  Future<void> initialData() async {
    args = Get.arguments;
    await fetchData();
    setStatus(Status.success);
  }

  @override
  Future<void> fetchData() async {
    ApiResponse<List<ProfileModel?>?> response = await GetAllProfileContextUseCase(
            repository: ProfileRepositoryImpl(), deviceId: AppConfig().getDeviceId())
        .invoke();
    if (checkCode(response)) return;
    mProfiles.value = response.data ?? [];
    mProfiles.firstOrNull?.isSelected.value = true;
  }

  void onUserPressed(ProfileModel? profileModel) {
    for (var element in mProfiles) {
      element?.isSelected.value = false;
    }
    profileModel?.isSelected.value = true;
  }

  void onAddUser() {
    Get.toNamed(RoutePath.TIME_TABLE_EDIT,
        parameters: EditUserArgs(type: UserEditType.ONLY_PICK_MODE).toJson());
  }
}
