import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/domain/repository/widget/application_repository.dart';

class GetApplicationByIdsUseCase extends BaseUseCase<ApiResponse<List<ApplicationModel?>?>> {
  final ApplicationRepository repository;
  final List<String>? appIds;

  GetApplicationByIdsUseCase({required this.repository, this.appIds});

  @override
  Future<ApiResponse<List<ApplicationModel?>?>> invoke() async {
    return await repository.getApplicationsByIds(appIds ?? []);
  }

  @override
  void validate() {}
}
