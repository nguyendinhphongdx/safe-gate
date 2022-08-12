import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/domain/repository/profile/profile_repository.dart';

class GetAllProfileUseCase extends BaseUseCase<ApiResponse<List<ProfileModel?>?>> {
  final ProfileRepository repository;
  final String? deviceId;

  GetAllProfileUseCase({required this.repository, this.deviceId});

  @override
  Future<ApiResponse<List<ProfileModel?>?>> invoke() async {
    return await repository.getAllProfileByDeviceId(deviceId);
  }

  @override
  void validate() {
    notNullOrEmpty(deviceId);
  }
}
