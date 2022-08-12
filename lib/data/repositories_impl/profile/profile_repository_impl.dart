import 'package:base_pm2/common/core/sys/api_extension.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/network/client.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/domain/repository/profile/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRepositoryImpl._internal();

  static final ProfileRepositoryImpl _impl = ProfileRepositoryImpl._internal();

  factory ProfileRepositoryImpl() => _impl;

  @override
  Future<ApiResponse<ProfileModel?>> deleteProfileById(String? profileId) async {
    // return await Client().service.deleteProfileById(profileId).wrap();
    return ApiResponse.error();
  }

  @override
  Future<ApiResponse<List<ProfileModel>?>> getAllProfileByModeId(String? modeId) async {
    // return await Client().service.getAllProfilesByModeId(modeId).wrap();
    return ApiResponse.error();
  }

  @override
  Future<ApiResponse<List<ProfileModel?>?>> getProfileDetail(String? deviceId, String? profileId) async {
    return await Client().service.getProfileDetail(profileId,deviceId).wrap(cast: (json)=> ProfileModel.fromJson(json));
  }

  @override
  Future<ApiResponse<List<ProfileModel?>?>> insertProfile(String? deviceId, ProfileModel? profile) async {
    return await Client().service.insertProfile(deviceId, profile).wrap();
  }

  @override
  Future<ApiResponse<ProfileModel?>> updateProfileById(String? profileId, ProfileModel? profile) async {
    // return await Client().service.updateProfileById(profileId,profile).wrap();
    return ApiResponse.error();
  }

  @override
  Future<ApiResponse<List<ProfileModel?>?>> getAllProfileByDeviceId(String? deviceId) async {
    return await Client()
        .service
        .getAllProfilesByDeviceId(deviceId)
        .wrap(cast: (json) => ProfileModel.fromJson(json));
  }

  @override
  Future<ApiResponse<dynamic>> updateProfileModeByProfileId(
      String? deviceId, String? profileId, String? dnsMode) async {
    return Client().service.updateProfileModeByProfileId(deviceId, profileId, {'dnsMode': dnsMode}).wrap();
  }
}
