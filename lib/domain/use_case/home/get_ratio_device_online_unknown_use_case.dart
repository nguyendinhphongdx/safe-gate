import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/data/repositories_impl/device/user_device_management_repository_impl.dart';
import 'package:base_pm2/domain/use_case/device/get_all_device_un_manager_use_case.dart';

class RatioDeviceModel {
  int? managed;
  int? total;

  RatioDeviceModel({this.managed, this.total});
}

class GetRatioDeviceOnlineUnknowUseCase extends BaseUseCase<RatioDeviceModel> {
  @override
  Future<RatioDeviceModel> invoke() async {
    ApiResponse<List<DeviceModel?>?> response = await GetAllDeviceUnManagerUseCase(
            repository: UserDeviceManagementRepositoryImpl(),
            deviceStatus: DeviceStatus.ALL,
            deviceId: AppConfig().getDeviceId())
        .invoke();
    int managed = response.data?.where((element) => element?.status == DeviceType.NONE).length ?? 0;
    int total = response.data?.length ?? 0;
    return RatioDeviceModel(managed: managed, total: total);
  }

  @override
  void validate() {
    // TODO: implement validate
  }
}
