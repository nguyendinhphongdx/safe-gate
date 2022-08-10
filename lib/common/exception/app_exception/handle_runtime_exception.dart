import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/helper/constant.dart';

class HandleRuntimeException<T> {
  Object? error;

  HandleRuntimeException(this.error);

  Future<ApiResponse<List<T>>> catchError() {
    return Future.value(ApiResponse(err: ErrorCode(CodeConstant.UNKNOWN, HttpConstant.UNKNOWN)));
  }
  Future<ApiResponse<T>> catchErrorV2() {
    return Future.value(ApiResponse(err: ErrorCode(CodeConstant.UNKNOWN, HttpConstant.UNKNOWN)));
  }
}
