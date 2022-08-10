import 'package:dio/dio.dart';

class InterceptorCatch extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 204) {
      return handler.next(
        Response(
            requestOptions: RequestOptions(path: '', data: {'code': 204, 'msg': 'No content'}),
            statusCode: 204,
            statusMessage: 'No content'),
      );
    }

    return handler.next(response);
  }
}
