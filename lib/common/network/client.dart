import 'package:base_pm2/common/helper/constant.dart';
import 'package:base_pm2/common/network/app_interceptor.dart';
import 'package:base_pm2/common/network/interceptor_catch.dart';
import 'package:base_pm2/common/network/services.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Client {
  Client._internal();

  static final Client _instance = Client._internal();

  factory Client() => _instance;

  Dio? _dio;

  Services get service => Services(_build(), baseUrl: _baseUrl);

  Services get serviceStatic => Services(_build(), baseUrl: HttpConstant.STATIC_BASE_URL);

  String _baseUrl = HttpConstant.BASE_URL;

  Map<String, dynamic> _headers = {};

  void setHeader(Map<String, dynamic> m) => _headers = m;

  void setBaseUrl(String url) => _baseUrl = url;

  Dio _build() {
    BaseOptions option = _getOptions();

    PrettyDioLogger logger = AppInterceptor().getLogger();
    InterceptorCatch interceptorCatch = AppInterceptor().getInterceptor();
    return Dio(option)
      ..interceptors.addAll([
        interceptorCatch,
        logger,
        DioCacheManager(CacheConfig(baseUrl: _baseUrl, defaultMaxAge: const Duration(minutes: 1))).interceptor
      ]);
  }

  BaseOptions _getOptions() => BaseOptions(
        contentType: HttpConstant.CONTENT_TYPE,
        connectTimeout: HttpConstant.CONNECT_TIMEOUT,
        receiveTimeout: HttpConstant.RECEIVE_TIMEOUT,
        headers: _headers,
      );
}
