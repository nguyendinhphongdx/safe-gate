import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/user/user_report/user_status_model.dart';
import 'package:base_pm2/domain/repository/profile/user_repository.dart';

class GetAllUserUseCase extends BaseUseCase<ApiResponse<List<UserStatusModel>?>> {
  final UserRepository repository;

  GetAllUserUseCase({required this.repository});

  @override
  Future<ApiResponse<List<UserStatusModel>?>> invoke() async {
    return await repository.getAllUsers();
  }

  @override
  void validate() {}
}
