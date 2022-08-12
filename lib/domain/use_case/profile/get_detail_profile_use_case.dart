import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/domain/repository/profile/profile_repository.dart';
import 'package:collection/collection.dart';

class GetProfileDetailUseCase extends BaseUseCase<ApiResponse<ProfileModel?>> {
  final ProfileRepository repository;
  final String? profileId;
  final String? deviceId;

  GetProfileDetailUseCase({required this.repository, this.profileId, this.deviceId});

  @override
  Future<ApiResponse<ProfileModel?>> invoke() async {
    ApiResponse<List<ProfileModel?>?> response = await repository.getProfileDetail(deviceId, profileId);
    if (isNotOk(response)) return ApiResponse.error(e: response.err);
    return ApiResponse.success(response.data?.firstOrNull, e: response.err);
  }

  @override
  void validate() {
    notNullOrEmpty(profileId);
    notNullOrEmpty(deviceId);
  }
}
