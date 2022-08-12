import 'package:base_pm2/common/core/sys/api_extension.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/network/client.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/data/repositories_impl/device/user_device_management_repository.dart';

class UserDeviceManagementRepositoryImpl implements UserDeviceManagementRepository {
  UserDeviceManagementRepositoryImpl._internal();

  static final UserDeviceManagementRepositoryImpl _impl = UserDeviceManagementRepositoryImpl._internal();

  factory UserDeviceManagementRepositoryImpl() => _impl;

  @override
  Future<ApiResponse<dynamic>> addDeviceConnected(
      DeviceModel? model, String? deviceId, String? profileId) async {
    return await Client().service.addDeviceConnected(model, deviceId, profileId).wrap();
  }

  @override
  Future<ApiResponse<List<DeviceInfo>?>> getAllDeviceByUserId(String? userId) async {
    return ApiResponse.error();
    // return await Client().service.getAllDeviceByUserId(userId).wrap();
  }

  @override
  Future<ApiResponse<List<DeviceModel?>?>> getAllDevicesConnected(
      String? deviceId, String? deviceStatus) async {
    return await Client().service.getAllDeviceConnected(deviceId, {'filter': deviceStatus}).wrap(
        cast: (json) => DeviceModel.fromJson(json));
  }

  @override
  Future<ApiResponse<List<DeviceModel?>?>> getAllDevicesConnectedByProfile(String? deviceId) async {
    return await Client()
        .service
        .getAllDeviceConnectedByProfile(deviceId)
        .wrap(cast: (json) => DeviceModel.fromJson(json));
  }

  @override
  Future<ApiResponse> addMultiDeviceConnected(List<String>? macIds, String? deviceId, String? profileId) {
    return Client().service.addMultiDeviceConnected({'end_user_devices': macIds}, deviceId, profileId).wrap();
  }
}
