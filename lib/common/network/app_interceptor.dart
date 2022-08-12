import 'package:base_pm2/common/core/sys/base_function.dart';
import 'package:base_pm2/common/network/interceptor_catch.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppInterceptor {
  AppInterceptor._internal();

  static final AppInterceptor _instance = AppInterceptor._internal();

  factory AppInterceptor() => _instance;

  bool isDebugMode = true;

  InterceptorsWrapper? wrapper;
  InterceptorCatch? interceptorCatch;
  PrettyDioLogger? logger;

  InterceptorsWrapper getWrapper() => wrapper ??= InterceptorsWrapper();
  InterceptorCatch getInterceptor() => interceptorCatch ??= InterceptorCatch();

  PrettyDioLogger getLogger() => logger ??= PrettyDioLogger(
        logPrint: _logPrint,
        requestHeader: isDebugMode,
        requestBody: isDebugMode,
        responseBody: isDebugMode,
        responseHeader: isDebugMode,
        error: isDebugMode,
      );

  void _logPrint(v) => showDioLog(v);
}
