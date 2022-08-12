import 'package:base_pm2/common/core/sys/api_extension.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/network/client.dart';
import 'package:base_pm2/data/model/profile/report_profile_model.dart';
import 'package:base_pm2/data/model/widget/app/app_access_model.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/data/model/context_model.dart';
import 'package:base_pm2/data/model/report/report_by_day_model.dart';
import 'package:base_pm2/data/model/report/report_model.dart';
import 'package:base_pm2/domain/repository/device/device_repository.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  DeviceRepositoryImpl._internal();

  static final DeviceRepositoryImpl _impl = DeviceRepositoryImpl._internal();

  factory DeviceRepositoryImpl() => _impl;

  @override
  Future<ApiResponse<List<ContextModel?>?>> getContextByProfileId(String? deviceId, String? profileId) async {
    return Client()
        .service
        .getContextByProfileId(deviceId, profileId)
        .wrap(cast: (json) => ContextModel.fromJson(json));
  }

  @override
  Future<ApiResponse<dynamic>> updateRuleByApplicationId(
      String? deviceId, String? profileId, String? dnsMode, List<ApplicationModel>? applications) async {
    Map<String, dynamic> contexts = {};
    applications?.forEach((element) {
      contexts
          .addAll({element.applicationId.toString(): element.ruleModels?.map((e) => e.toJson()).toList()});
    });

    Map<String, dynamic> body = {'dnsMode': dnsMode, 'contexts': contexts};
    return Client().service.updateRuleByApplicationId(deviceId, profileId, body).wrap();
  }

  @override
  Future<ApiResponse<ReportModel?>> getReportByDeviceId(String? deviceId, String? date) {
    return Client().service.getReportsByDeviceId(deviceId, {'datetime': date}).wrapV2(
        cast: (json) => ReportModel.fromJson(json));
  }

  @override
  Future<ApiResponse<ReportByDayModel?>> getReportByProfileId(
      String? deviceId, String? profileId, List<String>? date) {
    return Client().service.getReportByProfileId(deviceId, profileId, {'datetime': date}).wrapV2(
        cast: (json) => ReportByDayModel.fromJson(json));
  }

  @override
  Future<ApiResponse<ReportProfileModel?>> getHistoryByProfileId(
      String? deviceId, String? profileId, String? date) {
    return Client().service.getHistoryByProfileId(deviceId, profileId, {'datetime': date}).wrapV2(cast: (json)=> ReportProfileModel.fromJson(json));
  }

  @override
  Future<ApiResponse<dynamic>> getViolationByProfileId(
      String? deviceId, String? profileId, List<String>? date) {
    return Client().service.getViolationsByProfileId(deviceId, profileId, {'datetime': date}).wrap();
  }

  @override
  Future<ApiResponse<dynamic>> getAllDeviceConnectedByProfileId(
      String? deviceId, String? profileId) {
    return Client().service.getAllDeviceConnectedByProfileId(deviceId, profileId, {}).wrap();
  }

  @override
  Future<ApiResponse> deleteUserDevice(String? deviceId, String? profileId, String? macAddress) {
    return Client().service.deleteUserDevice(deviceId, profileId, macAddress).wrap();
  }

  @override
  Future<ApiResponse<List<AppAccessParentModel?>?>> getViolationsByDeviceId(
      String? deviceId, List<String>? dateTimes) {
    return Client().service.getViolationsByDeviceId(deviceId, {'datetime': dateTimes}).wrap(
        cast: (json) => AppAccessParentModel.fromJson(json));
  }
}
