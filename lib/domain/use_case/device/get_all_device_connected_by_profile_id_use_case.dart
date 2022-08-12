import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/domain/repository/device/device_repository.dart';

class GetAllDeviceByProfileIdUseCase extends BaseUseCase<ApiResponse<List<DeviceModel?>?>> {
  final DeviceRepository repository;
  final String? deviceId;
  final String? profileId;

  GetAllDeviceByProfileIdUseCase({required this.repository, this.deviceId, this.profileId});

  @override
  Future<ApiResponse<List<DeviceModel?>?>> invoke() async {
    ApiResponse<dynamic> apiResponse = await repository.getAllDeviceConnectedByProfileId(deviceId, profileId);
    if (isNotOk(apiResponse)) return ApiResponse.success([], e: apiResponse.err);


    List<String>? keys = apiResponse.allData?['end_user_devices']?.cast<String>();

    if (keys == null) return ApiResponse.success([], e: apiResponse.err);

    Map<String, dynamic>? euDevices = apiResponse.allData?['euDevices'];

    if (euDevices == null) return ApiResponse.success([], e: apiResponse.err);

    List<DeviceModel?>? devices = keys.map<DeviceModel>((e) => DeviceModel.fromJson(euDevices[e])).toList();

    return ApiResponse.success(devices, e: apiResponse.err);
  }

  @override
  void validate() {
    notNullOrEmpty(deviceId);
    notNullOrEmpty(profileId);
  }
}
