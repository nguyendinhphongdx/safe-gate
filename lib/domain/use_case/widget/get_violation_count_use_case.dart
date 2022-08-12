import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/widget/app/app_access_model.dart';
import 'package:base_pm2/data/repositories_impl/device/device_repository_impl.dart';
import 'package:base_pm2/domain/repository/device/device_repository.dart';
import 'package:base_pm2/domain/use_case/profile/get_violation_by_profile_id_use_case.dart';

class GetViolationCountByProfileIdUseCase extends BaseUseCase<int> {
  final DeviceRepository repository;
  final String? deviceId;
  final String? profileId;
  final List<String>? dateTime;

  GetViolationCountByProfileIdUseCase(
      {required this.repository, this.deviceId, this.profileId, this.dateTime});

  @override
  Future<int> invoke() async {
    ApiResponse<List<AppAccessParentModel?>?> response = await GetViolationByProfileIdUseCase(
            repository: DeviceRepositoryImpl(), dateTime: dateTime, profileId: profileId, deviceId: deviceId)
        .invoke();
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
    notNullOrEmpty(profileId);
  }
}
