import 'package:base_pm2/common/helper/constant.dart';

class ApiResponse<T> {
  T? data;
  dynamic allData;
  ErrorCode? err;

  ApiResponse({this.data, this.err, this.allData});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    allData = json['data'];
    if (json['code'] == CodeConstant.OK) {
      err = ErrorCode.success();
    } else {
      err = ErrorCode.error();
    }
  }

  static ApiResponse<T> success<T>(T? data, {ErrorCode? e}) =>
      ApiResponse(err: ErrorCode.success(), data: data);

  static ApiResponse<T> error<T>({ErrorCode? e}) => ApiResponse(err: e ?? ErrorCode.error());
}

class ErrorCode {
  int code;
  String message;

  ErrorCode(this.code, this.message);

  static ErrorCode success() => ErrorCode(CodeConstant.OK, 'Thành công');

  static ErrorCode error({int? code, String? msg}) =>
      ErrorCode(code ?? CodeConstant.UNKNOWN, msg ?? 'Thất bại');
}
