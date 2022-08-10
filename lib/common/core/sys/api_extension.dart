import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/base_function.dart';
import 'package:base_pm2/common/core/sys/json_parser.dart';
import 'package:base_pm2/common/exception/app_exception/handle_app_exception.dart';
import 'package:base_pm2/common/exception/app_exception/handle_runtime_exception.dart';
import 'package:base_pm2/common/helper/constant.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

extension FutureExtensions<T> on Future<HttpResponse<ApiResponse<T?>?>> {
  Future<ApiResponse<List<T?>?>> wrap({T Function(dynamic json)? cast}) async {
    try {
      HttpResponse<ApiResponse<T?>?> httpResponse = await this;

      return await HandleSuccess<T?>(httpResponse, cast: cast).success();
     } catch (error) {
      showError(error);

      if (error is DioError) return HandleDioException<T>(error).catchError();

      return HandleRuntimeException<T>(error).catchError();
    }
  }

  Future<ApiResponse<T?>> wrapV2({T Function(dynamic json)? cast}) async {
    try {
      HttpResponse<ApiResponse<T?>?> httpResponse = await this;

      return await HandleSuccess<T?>(httpResponse, cast: cast).successV2();
      } catch (error) {
      showError(error);

      if (error is DioError) return HandleDioException<T>(error).catchErrorV2();

      return HandleRuntimeException<T>(error).catchErrorV2();
    }
  }
}

class HandleSuccess<T> {
  HttpResponse<ApiResponse<T?>?> httpResponse;
  T? Function(dynamic json)? cast;

  HandleSuccess(this.httpResponse, {this.cast});

  Future<ApiResponse<List<T?>?>> success() {
    final responseData = httpResponse.response.data;

    String okMessage = 'Thành công';
    int okErrorCode = CodeConstant.OK;

    // if (responseData['code'] != CodeConstant.OK) {
    //   okMessage = responseData['message'] ?? HttpConstant.UNKNOWN;
    //   okErrorCode = responseData['code'] ?? CodeConstant.UNKNOWN;
    // }

    if (cast == null) {
      return Future.value(
          ApiResponse<List<T?>>(err: ErrorCode(okErrorCode, okMessage), allData: httpResponse.data?.allData));
    }

    if (httpResponse.data?.allData != null) {
      return Future.value(ApiResponse<List<T?>>(
          err: ErrorCode(okErrorCode, okMessage),
          data: JsonParser().parse<T>(httpResponse.data?.allData, fromJson: cast)));
    }

    return Future.value(
        ApiResponse<List<T?>>(err: ErrorCode(okErrorCode, okMessage), data: httpResponse.data?.allData));
  }

  Future<ApiResponse<T?>> successV2() {
    final responseData = httpResponse.response.data;

    String okMessage = 'Thành công';
    int okErrorCode = CodeConstant.OK;

    // if (responseData['code'] != CodeConstant.OK) {
    //   okMessage = responseData['message'] ?? HttpConstant.UNKNOWN;
    //   okErrorCode = responseData['code'] ?? CodeConstant.UNKNOWN;
    // }

    if (cast == null) {
      return Future.value(
          ApiResponse<T?>(err: ErrorCode(okErrorCode, okMessage), allData: httpResponse.data?.allData));
    }

    if (httpResponse.data?.allData != null) {
      return Future.value(ApiResponse<T>(
          err: ErrorCode(okErrorCode, okMessage), data: cast?.call(httpResponse.data?.allData)));
    }

    return Future.value(
        ApiResponse<T>(err: ErrorCode(okErrorCode, okMessage), data: httpResponse.data?.allData));
  }
}
