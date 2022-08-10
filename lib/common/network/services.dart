import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/config_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';


part 'services.g.dart';

@RestApi()
abstract class Services {
  factory Services(Dio dio, {String? baseUrl}) = _Services;

  @GET('/app_config/app.config')
  Future<ConfigModel> getConfig(@Queries() Map<String, dynamic> m);

}
