import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/exception/app_exception/validate_exception.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/domain/repository/profile/profile_repository.dart';

class UpdateProfileModeUseCase extends BaseUseCase<ApiResponse<dynamic>> {
  final ProfileRepository repository;
  final String? deviceId;
  final String? profileId;
  final String? dnsMode;

  UpdateProfileModeUseCase({required this.repository, this.profileId, this.dnsMode, this.deviceId});

  @override
  Future<ApiResponse<dynamic>> invoke() async {
    return await repository.updateProfileModeByProfileId(deviceId, profileId, dnsMode);
  }

  @override
  void validate() {
    notNullOrEmpty(dnsMode);
    if (dnsMode != DNSMode.CHILD && dnsMode != DNSMode.ADULT) {
      throw ValidateException('DNS Mode not contain [ DNSMode.CHILD, DNSMode.ADULT ]');
    }
    notNullOrEmpty(deviceId);
    notNullOrEmpty(profileId);
  }
}
