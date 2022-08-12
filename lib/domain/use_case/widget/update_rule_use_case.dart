import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/domain/repository/device/device_repository.dart';

class UpdateRuleUseCase extends BaseUseCase<ApiResponse<dynamic>> {
  final DeviceRepository repository;
  final String? deviceId;
  final String? profileId;
  final String? dnsMode;
  final List<ApplicationModel>? apps;
  UpdateRuleUseCase(
      {this.deviceId,
      this.profileId,
      this.dnsMode,
      this.apps,
      required this.repository});

  @override
  Future<ApiResponse> invoke() async {
    return await repository.updateRuleByApplicationId(deviceId, profileId, dnsMode, apps);
  }

  @override
  void validate() {
    notNullOrEmpty(deviceId);
    notNullOrEmpty(profileId);
    notNullOrEmpty(dnsMode);

  }
}
