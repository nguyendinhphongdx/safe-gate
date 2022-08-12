import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/device/device_connected_model.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/domain/use_case/device/get_all_device_connected_use_case.dart';
import 'package:base_pm2/screen/widget/device/dialog/device_assigned_controller.dart';
import 'package:get/get.dart';

class DeviceController extends BaseController {
  Rx<DeviceConnectedModel?> mConnectedDevice =
      DeviceConnectedModel(devices: [], profiles: []).obs;

  @override
  Future<void> initialData() async {
    fetchData();
  }

  @override
  Future<void> fetchData() async {
    DeviceConnectedModel? response = await GetAllDeviceConnectedUseCase(
            deviceId: AppConfig().getDeviceId(),
            deviceStatus: DeviceStatus.UNKNOWN)
        .invoke();
    mConnectedDevice.value = response;
    setStatus(Status.success);
  }

  void showDialogAddDevice(DeviceModel? deviceModel) {
    Get.toNamed(RoutePath.DEVICE_ASSIGNED,
        arguments: DeviceAssignedArgs(model: deviceModel));
  }

  void onConnectAllDevice({ProfileModel? profileModel}) {}

  Future<void> onConnectDevice(DeviceModel? deviceModel) async {}

  Future<void> onDenyDevice(DeviceModel? deviceModel) async {}
}
