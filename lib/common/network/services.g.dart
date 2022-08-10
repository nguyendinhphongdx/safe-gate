part of 'services.dart';
// **************************************************************************
// VietPDb create Service API SafeGate
// **************************************************************************

class _Services implements Services {
  _Services(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ConfigModel> getConfig(m) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(m);
    final _data = <String, dynamic>{};
    try {
      final _result = await _dio.fetch<Map<String, dynamic>>(
          _setStreamType<ConfigModel>(Options(
                  method: 'GET', headers: <String, dynamic>{}, extra: _extra)
              .compose(_dio.options, '/app_config/app.config',
                  queryParameters: queryParameters, data: _data)
              .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
      final value = ConfigModel.fromJson(_result.data!);
      return value;
    } catch (e) {
      return  ConfigModel.fromJson(_data);
    }
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
