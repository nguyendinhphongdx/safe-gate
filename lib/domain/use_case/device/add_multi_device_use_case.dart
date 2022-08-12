import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/repositories_impl/device/user_device_management_repository.dart';

class AddMultiDeviceUseCase extends BaseUseCase<ApiResponse<dynamic>> {
  final UserDeviceManagementRepository repository;
  final List<String>? macIds;
  final String? deviceId;
  final String? profileId;

  AddMultiDeviceUseCase({required this.repository, this.macIds, this.deviceId, this.profileId});

  @override
  Future<ApiResponse> invoke() async {
    return await repository.addMultiDeviceConnected(macIds, deviceId, profileId);
  }

  @override
  void validate() {
    // TODO: implement validate
  }
}
