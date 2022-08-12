import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/report/report_model.dart';
import 'package:base_pm2/domain/repository/device/device_repository.dart';

class GetReportByDeviceIdUseCase extends BaseUseCase<ApiResponse<ReportModel?>> {
  final DeviceRepository repository;
  final String? deviceId;
  final String? date; //yyyyMMdd

  GetReportByDeviceIdUseCase({required this.repository, this.deviceId, this.date});

  @override
  Future<ApiResponse<ReportModel?>> invoke() async {
    ApiResponse<ReportModel?> response = await repository.getReportByDeviceId(deviceId, date);
    return response;
  }

  @override
  void validate() {
    notNullOrEmpty(deviceId);
    notNullOrEmpty(date);
  }
}
