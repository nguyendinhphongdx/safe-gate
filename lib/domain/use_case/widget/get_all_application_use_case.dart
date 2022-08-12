import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/domain/repository/widget/application_repository.dart';

class GetAllApplicationUseCase extends BaseUseCase<ApiResponse<List<ApplicationModel?>?>> {
  final ApplicationRepository repository;

  GetAllApplicationUseCase({required this.repository});

  @override
  Future<ApiResponse<List<ApplicationModel?>?>> invoke() async {
    return await repository.getAllApplications();
  }

  @override
  void validate() {}
}
