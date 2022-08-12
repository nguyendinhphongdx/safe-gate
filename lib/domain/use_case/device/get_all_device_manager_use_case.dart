import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/repositories_impl/device/user_device_management_repository.dart';
import 'package:base_pm2/data/repositories_impl/profile/profile_repository_impl.dart';
import 'package:base_pm2/domain/use_case/profile/get_all_profile_use_case.dart';

class GetAllDeviceManagerUseCase extends BaseUseCase<ApiResponse<List<ProfileModel?>?>> {
  final UserDeviceManagementRepository repository;
  final String? deviceId;

  GetAllDeviceManagerUseCase({required this.repository,this.deviceId});

  @override
  Future<ApiResponse<List<ProfileModel?>?>> invoke() async {
    ApiResponse<List<ProfileModel?>?> profiles =
        await GetAllProfileUseCase(repository: ProfileRepositoryImpl(), deviceId: deviceId).invoke();
    if (profiles.data == null) return ApiResponse.success([]);
    if (profiles.data!.isEmpty) return ApiResponse.success([]);
    // ApiResponse<ConnectedDevicesModel?> response = await repository.getAllDevicesConnected();
    // if (isNotOk(response)) return response;
    // ConnectedDevicesModel? devicesModel = response.data;
    // //
    // devicesModel?.userStatuses?.forEach((element) {
    //   //  element.user?.uid != e.uid inproduction must change to ==
    //   element.devices =
    //       devicesModel.managedDevices?.singleWhereOrNull((e) => element.user?.uid != e.uid)?.devices;
    // });
    return profiles;
  }

  @override
  void validate() {}
}
