import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';

abstract class ProfileRepository {
  Future<ApiResponse<List<ProfileModel?>?>> getAllProfileByDeviceId(String? deviceId);

  Future<ApiResponse<List<ProfileModel?>?>> insertProfile(String? deviceId, ProfileModel? profile);

  Future<ApiResponse<List<ProfileModel?>?>> getProfileDetail(String? deviceId, String? profileId);

  Future<ApiResponse<ProfileModel?>> updateProfileById(String? profileId, ProfileModel? profile);

  Future<ApiResponse<ProfileModel?>> deleteProfileById(String? profileId);

  Future<ApiResponse<dynamic>> updateProfileModeByProfileId(
      String? deviceId, String? profileId, String? dnsMode);
}
