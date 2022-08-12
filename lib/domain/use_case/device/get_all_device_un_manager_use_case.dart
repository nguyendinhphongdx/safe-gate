import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/data/repositories_impl/device/user_device_management_repository.dart';

class GetAllDeviceUnManagerUseCase extends BaseUseCase<ApiResponse<List<DeviceModel?>?>> {
  final UserDeviceManagementRepository repository;
  final String? deviceId;
  final String? deviceStatus;

  GetAllDeviceUnManagerUseCase({this.deviceId, required this.repository, this.deviceStatus});

  @override
  Future<ApiResponse<List<DeviceModel?>?>> invoke() async {
    ApiResponse<List<DeviceModel?>?> response =
        await repository.getAllDevicesConnected(deviceId, deviceStatus);
    if (isNotOk(response)) return response;
    response.data?.sort((d1, d2) => d2?.createdTime?.compareTo(d1?.createdTime ?? -1) ?? 0);
    return response;
  }

  @override
  void validate() {
    notNullOrEmpty(deviceId);
  }
}
