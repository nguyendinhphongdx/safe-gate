import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/widget/app/app_access_model.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/data/model/context_model.dart';
import 'package:base_pm2/data/model/profile/report_profile_model.dart';
import 'package:base_pm2/data/model/report/report_by_day_model.dart';
import 'package:base_pm2/data/model/report/report_model.dart';

abstract class DeviceRepository {
  Future<ApiResponse<List<ContextModel?>?>> getContextByProfileId(String? deviceId, String? profileId);

  Future<ApiResponse<dynamic>> updateRuleByApplicationId(
      String? deviceId, String? profileId, String? dnsMode, List<ApplicationModel>? applications);

  Future<ApiResponse<ReportModel?>> getReportByDeviceId(String? deviceId, String? date);

  Future<ApiResponse<ReportByDayModel?>> getReportByProfileId(
      String? deviceId, String? profileId, List<String>? date);

  Future<ApiResponse<ReportProfileModel?>> getHistoryByProfileId(
      String? deviceId, String? profileId, String? date);

  Future<ApiResponse<dynamic>> getViolationByProfileId(
      String? deviceId, String? profileId, List<String>? date);

  Future<ApiResponse<dynamic>> getAllDeviceConnectedByProfileId(
      String? deviceId, String? profileId);

  Future<ApiResponse<List<AppAccessParentModel?>?>> getViolationsByDeviceId(String? deviceId,List<String>? dateTimes);

  Future<ApiResponse<dynamic>> deleteUserDevice(String? deviceId, String? profileId, String? macAddress);
}
