import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/resource/enum_resource.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/data/repositories_impl/device/user_device_management_repository_impl.dart';
import 'package:base_pm2/domain/use_case/device/get_all_device_un_manager_use_case.dart';
import 'package:get/get.dart';

class ListDeviceController extends BaseController {
  RxList<DeviceModel?> listDeviceModel = <DeviceModel?>[].obs;

  @override
  Future initialData() async {
    setStatus(Status.loading);
    fetchData();
  }

  @override
  Future<void> fetchData() async {
    ApiResponse<List<DeviceModel?>?> response = await GetAllDeviceUnManagerUseCase(
            repository: UserDeviceManagementRepositoryImpl(),
            deviceId: AppConfig().getDeviceId(),
            deviceStatus: DeviceStatus.UNKNOWN)
        .invoke();
    if (checkCode(response)) return;
    listDeviceModel.value = response.data ?? [];
    setStatus(Status.success);
  }

  void onChangeDeviceStatus(DeviceModel? userDevice) {
    userDevice?.rxStatus?.value = !userDevice.rxStatus!.value;
  }
}
