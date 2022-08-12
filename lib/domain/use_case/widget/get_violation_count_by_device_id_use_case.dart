import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/widget/app/app_access_model.dart';
import 'package:base_pm2/domain/repository/device/device_repository.dart';

class GetViolationCountByDeviceIdUseCase extends BaseUseCase<int> {
  final DeviceRepository repository;
  final String? deviceId;
  final List<String>? dateTime;

  GetViolationCountByDeviceIdUseCase({required this.repository, this.deviceId, this.dateTime});

  @override
  Future<int> invoke() async {
    ApiResponse<List<AppAccessParentModel?>?> response =
    await repository.getViolationsByDeviceId(deviceId, dateTime);
    if (isNotOk(response)) return 0;
    int i = 0;
    response.data?.forEach((element) {
      element?.appAccess?.forEach((element1) {
        i += (element1.count ?? 0);
      });
    });
    return i;
  }

  @override
  void validate() {
    notNullOrEmpty(deviceId);
  }
}
