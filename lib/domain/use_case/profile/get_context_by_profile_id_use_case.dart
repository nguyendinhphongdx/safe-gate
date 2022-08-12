import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/context_model.dart';
import 'package:base_pm2/domain/repository/device/device_repository.dart';

class GetContextByProfileIdUseCase extends BaseUseCase<ApiResponse<ContextModel?>> {
  final DeviceRepository repository;
  final String? deviceId;
  final String? profileId;

  GetContextByProfileIdUseCase({required this.repository, this.profileId, this.deviceId});

  @override
  Future<ApiResponse<ContextModel?>> invoke() async {
    ApiResponse<List<ContextModel?>?> response = await repository.getContextByProfileId(deviceId, profileId);
    return getObject(response);
  }

  @override
  void validate() {
    // TODO: implement validate
  }
}
