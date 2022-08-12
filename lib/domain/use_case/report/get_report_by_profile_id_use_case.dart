import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/report/report_by_day_model.dart';
import 'package:base_pm2/domain/repository/device/device_repository.dart';

class GetReportByProfileIdUseCase extends BaseUseCase<ApiResponse<ReportByDayModel?>> {
  final DeviceRepository repository;
  final List<String>? dateTimes;
  final String? deviceId;
  final String? profileId;

  GetReportByProfileIdUseCase({required this.repository, this.dateTimes, this.deviceId, this.profileId});

  @override
  Future<ApiResponse<ReportByDayModel?>> invoke() async {
    return repository.getReportByProfileId(deviceId, profileId, dateTimes);
  }

  @override
  void validate() {
    notNullOrEmpty(deviceId);
    notNullOrEmpty(profileId);
  }
}
