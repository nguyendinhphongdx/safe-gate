import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';

abstract class ApplicationRepository {
  Future<ApiResponse<List<ApplicationModel?>?>> getAllApplications();

  Future<ApiResponse<List<ApplicationModel?>?>> getApplicationsByIds(
      List<String> appIds);

  Future<ApiResponse<List<ApplicationModel?>?>> getApplicationsByKeyword(String? keyword);

  Future<ApiResponse<List<dynamic>?>> confirmAddApplication(
  String? deviceId, String? profileId,String? dnsMode, List<ApplicationModel?> m);
}
