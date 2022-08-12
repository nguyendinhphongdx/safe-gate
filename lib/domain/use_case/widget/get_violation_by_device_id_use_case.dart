import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/widget/app/app_access_model.dart';
import 'package:base_pm2/domain/repository/device/device_repository.dart';

class GetViolationByDeviceIdUseCase extends BaseUseCase<ApiResponse<List<AppAccessParentModel?>?>> {
  final DeviceRepository repository;
  final String? deviceId;
  final List<String>? dateTime;

  GetViolationByDeviceIdUseCase({required this.repository, this.deviceId, this.dateTime});

  @override
  Future<ApiResponse<List<AppAccessParentModel?>?>> invoke() async{
    return await repository.getViolationsByDeviceId(deviceId, dateTime);
  }

  @override
  void validate() {
    notNullOrEmpty(deviceId);
  }
}
