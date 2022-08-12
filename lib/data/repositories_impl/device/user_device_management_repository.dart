import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/device/device_model.dart';

abstract class UserDeviceManagementRepository {
  Future<ApiResponse<List<DeviceModel?>?>> getAllDevicesConnected(String? deviceId,String? deviceStatus);
  Future<ApiResponse<List<DeviceModel?>?>> getAllDevicesConnectedByProfile(String? deviceId);

  Future<ApiResponse<List<DeviceInfo>?>> getAllDeviceByUserId(String? userId);

  Future<ApiResponse<dynamic>> addDeviceConnected(DeviceModel? model,String? deviceId,String? profileId);

  Future<ApiResponse<dynamic>> addMultiDeviceConnected(List<String>? macIds,String? deviceId,String? profileId);
}
