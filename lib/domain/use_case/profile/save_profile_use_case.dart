import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/domain/repository/profile/profile_repository.dart';
import 'package:collection/collection.dart';

class SaveProfileUseCase extends BaseUseCase<ApiResponse<ProfileModel?>> {
  final ProfileRepository repository;
  final String? deviceId;
  final ProfileModel? profileModel;

  SaveProfileUseCase({required this.repository, this.deviceId, this.profileModel});

  @override
  Future<ApiResponse<ProfileModel?>> invoke() async {
    ApiResponse<List<ProfileModel?>?> response = await repository.insertProfile(deviceId, profileModel);
    if (isNotOk(response)) return ApiResponse.error(e: response.err);
    return ApiResponse.success(response.data?.firstOrNull, e: response.err);
  }

  @override
  void validate() {
    notNullOrEmpty(deviceId);
    notNull(profileModel);
  }
}
