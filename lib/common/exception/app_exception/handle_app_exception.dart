import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/helper/constant.dart';
import 'package:dio/dio.dart';

class HandleDioException<T> {
  DioError? error;

  HandleDioException(this.error);

  Future<ApiResponse<List<T>>> catchError() {
    switch (error?.type) {
      case DioErrorType.response:
        return _okError();

      case DioErrorType.sendTimeout:
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
        return Future.value(ApiResponse(err: ErrorCode(CodeConstant.TIME_OUT, HttpConstant.TIME_OUT)));

      default:
        return Future.value(ApiResponse(err: ErrorCode(CodeConstant.UNKNOWN, HttpConstant.UNKNOWN)));
    }
  }

  Future<ApiResponse<T>> catchErrorV2() {
    switch (error?.type) {
      case DioErrorType.response:
        return _okErrorV2();

      case DioErrorType.sendTimeout:
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
        return Future.value(ApiResponse(err: ErrorCode(CodeConstant.TIME_OUT, HttpConstant.TIME_OUT)));

      default:
        return Future.value(ApiResponse(err: ErrorCode(CodeConstant.UNKNOWN, HttpConstant.UNKNOWN)));
    }
  }

  Future<ApiResponse<List<T>>> _okError() {
    int? statusCode = error?.response?.statusCode;
    String? message = '$statusCode - ${error?.response?.statusMessage}';

    switch (statusCode) {
      case CodeConstant.FORBIDDEN:
        return Future.value(ApiResponse(err: ErrorCode(CodeConstant.FORBIDDEN, HttpConstant.FORBIDDEN)));

      case CodeConstant.NO_CONTENT:
        return Future.value(ApiResponse(err: ErrorCode(CodeConstant.OK, HttpConstant.NO_CONTENT), data: []));

      case CodeConstant.AUTHENTICATION:
        return Future.value(
            ApiResponse(err: ErrorCode(CodeConstant.AUTHENTICATION, HttpConstant.AUTHENTICATION)));

      case CodeConstant.NOT_FOUND:
        return Future.value(ApiResponse(err: ErrorCode(CodeConstant.NOT_FOUND, HttpConstant.NOT_FOUND)));

      case CodeConstant.ERROR:
        String? messageResponse = error?.response?.data['msg'];
        return Future.value(
            ApiResponse(err: ErrorCode(CodeConstant.ERROR, messageResponse ?? HttpConstant.BAD_GATEWAY)));
      case CodeConstant.BAD_GATEWAY:
        return Future.value(ApiResponse(err: ErrorCode(CodeConstant.ERROR, HttpConstant.BAD_GATEWAY)));

      default:
        return Future.value(ApiResponse(err: ErrorCode(CodeConstant.UNKNOWN, message)));
    }
  }

  Future<ApiResponse<T>> _okErrorV2() {
    int? statusCode = error?.response?.statusCode;
    String? message = '$statusCode - ${error?.response?.statusMessage}';

    switch (statusCode) {
      case CodeConstant.FORBIDDEN:
        return Future.value(ApiResponse(err: ErrorCode(CodeConstant.FORBIDDEN, HttpConstant.FORBIDDEN)));

      case CodeConstant.NO_CONTENT:
        return Future.value(
            ApiResponse(err: ErrorCode(CodeConstant.OK, HttpConstant.NO_CONTENT), data: null));

      case CodeConstant.AUTHENTICATION:
        return Future.value(
            ApiResponse(err: ErrorCode(CodeConstant.AUTHENTICATION, HttpConstant.AUTHENTICATION)));

      case CodeConstant.NOT_FOUND:
        return Future.value(ApiResponse(err: ErrorCode(CodeConstant.NOT_FOUND, HttpConstant.NOT_FOUND)));

      case CodeConstant.ERROR:
        String? messageResponse = error?.response?.data['msg'];
        return Future.value(
            ApiResponse(err: ErrorCode(CodeConstant.ERROR, messageResponse ?? HttpConstant.BAD_GATEWAY)));
      case CodeConstant.BAD_GATEWAY:
        return Future.value(ApiResponse(err: ErrorCode(CodeConstant.ERROR, HttpConstant.BAD_GATEWAY)));

      default:
        return Future.value(ApiResponse(err: ErrorCode(CodeConstant.UNKNOWN, message)));
    }
  }
}
