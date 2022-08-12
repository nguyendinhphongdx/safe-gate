import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/domain/repository/widget/application_repository.dart';

class ConfirmApplicationUseCase extends BaseUseCase<ApiResponse<dynamic>> {
  final ApplicationRepository applicationRepository;
  final String? deviceId;
  final String? profileId;
  final String? dnsMode;
  final List<ApplicationModel?>? applications;

  ConfirmApplicationUseCase(
      {required this.applicationRepository,
      this.deviceId,
      this.profileId,
      this.dnsMode,
      this.applications});

  @override
  Future<ApiResponse> invoke() async {
    return await applicationRepository.confirmAddApplication(
        deviceId, profileId, dnsMode, applications ?? []);
    // TODO: implement invoke
  }

  @override
  void validate() {
    // TODO: implement validate
  }
}
