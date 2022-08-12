import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/config_model.dart';
import 'package:base_pm2/data/model/context_model.dart';
import 'package:base_pm2/data/model/profile/report_profile_model.dart';
import 'package:base_pm2/data/model/report/report_by_day_model.dart';
import 'package:base_pm2/data/model/report/report_model.dart';
import 'package:base_pm2/data/model/widget/app/app_access_model.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/model/widget/category_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';


part 'services.g.dart';

@RestApi()
abstract class Services {
  factory Services(Dio dio, {String? baseUrl}) = _Services;
  // report
    @GET('/device/{deviceId}/report')
  Future<HttpResponse<ApiResponse<ReportModel?>?>> getReportsByDeviceId(
      @Path() String? deviceId, @Queries() Map<String, dynamic>? q);
      
  @GET('/device/{deviceId}/report/{profileId}')
  Future<HttpResponse<ApiResponse<ReportByDayModel?>?>> getReportByProfileId(
      @Path() String? deviceId, @Path() String? profileId, @Queries() Map<String, dynamic> m);

      @GET('/device/{deviceId}/history/{profileId}')
  Future<HttpResponse<ApiResponse<ReportProfileModel?>?>> getHistoryByProfileId(
      @Path() String? deviceId, @Path() String? profileId, @Queries() Map<String, dynamic> m);

  @GET('/device/{deviceId}/violation/{profileId}')
  Future<HttpResponse<ApiResponse<AppAccessParentModel?>?>> getViolationsByProfileId(
      @Path() String? deviceId, @Path() String? profileId, @Queries() Map<String, dynamic> m);

  @GET('/device/{deviceId}/violation')
  Future<HttpResponse<ApiResponse<AppAccessParentModel?>?>> getViolationsByDeviceId(
      @Path() String? deviceId, @Queries() Map<String, dynamic> m);
// device

  @GET('/device/{deviceId}/context/{profileId}')
  Future<HttpResponse<ApiResponse<ContextModel?>?>> getContextByProfileId(
      @Path() String? deviceId, @Path() String? profileId);
      
  @PATCH('/device/{deviceId}/profile/{profileId}')
  Future<HttpResponse<ApiResponse<dynamic>>> addDeviceConnected(
      @Body() DeviceModel? model, @Path() String? deviceId, @Path() String? profileId);

  @PATCH('/device/{deviceId}/profile/{profileId}')
  Future<HttpResponse<ApiResponse<dynamic>>> addMultiDeviceConnected(
      @Body() Map<String, dynamic> macIds, @Path() String? deviceId, @Path() String? profileId);

  @GET('/app_config/app.config')
  Future<ConfigModel> getConfig(@Queries() Map<String, dynamic> m);


  @GET('/device/{deviceId}/end_user_devices')
  Future<HttpResponse<ApiResponse<DeviceModel?>?>> getAllDeviceConnected(
      @Path() String? deviceId, @Queries() Map<String, dynamic> q);

  @GET('/device/{deviceId}/end_user_devices/{profileId}')
  Future<HttpResponse<ApiResponse<DeviceModel?>?>> getAllDeviceConnectedByProfileId(
      @Path() String? deviceId, @Path() String? profileId, @Queries() Map<String, dynamic> q);

  @GET('/device/{{deviceId}}/profiles')
  Future<HttpResponse<ApiResponse<DeviceModel?>?>> getAllDeviceConnectedByProfile(@Path() String? deviceId);

  @GET('/applications/search/{keyword}')
  Future<HttpResponse<ApiResponse<ApplicationModel>>> addApplicationDevice(@Path() String? keyword);

    @DELETE('/device/{deviceId}/profile/{profileId}/{macAddress}')
  Future<HttpResponse<ApiResponse<dynamic>?>> deleteUserDevice(
      @Path() String? deviceId, @Path() String? profileId, @Path() String? macAddress);
// end device
// profile
@PATCH('/device/{deviceId}/context/{profileId}')
  Future<HttpResponse<ApiResponse<dynamic>?>> updateProfileModeByProfileId(
      @Path() String? deviceId, @Path() String? profileId, @Body() Map<String, dynamic> m);
      
 @GET('/device/{deviceId}/profiles')
  Future<HttpResponse<ApiResponse<ProfileModel?>?>> getAllProfilesByDeviceId(@Path() String? deviceId);

  @POST('/device/{deviceId}/profiles')
  Future<HttpResponse<ApiResponse<ProfileModel?>?>> insertProfile(
      @Path() String? deviceId, @Body() ProfileModel? profile);

  @GET('/device/{deviceId}/profile/{profileId}')
  Future<HttpResponse<ApiResponse<ProfileModel?>>> getProfileDetail(
      @Path() String? profileId, @Path() String? deviceId);
// widget
  @GET('/applications')
  Future<HttpResponse<ApiResponse<ApplicationModel?>?>> getApplicationByIds(
      @Queries() Map<String, dynamic> m);

  @GET('/applications')
  Future<HttpResponse<ApiResponse<ApplicationModel?>?>> getAllDefaultApplication();

  @GET('/categories')
  Future<HttpResponse<ApiResponse<CategoryModel?>?>> getAllGroupAppliction(@Queries() Map<String, dynamic> m);

  @GET('/categories/search/{keyword}')
  Future<HttpResponse<ApiResponse<CategoryModel?>?>> findAllGroupAppByKey(@Path() String? keyword);

    @PATCH('/device/{deviceId}/context/{profileId}')
  Future<HttpResponse<ApiResponse<CategoryModel?>?>> updateRuleByApplicationId(
      @Path() String? deviceId, @Path() String? profileId, @Body() Map<String, dynamic> m);

        @PUT('/device/{deviceId}/context/{profileId}')
  Future<HttpResponse<ApiResponse<ApplicationModel?>?>> confirmAddApplication(
      @Path() String? deviceId, @Path() String? profileId, @Body() Map<String, dynamic> m);

}
