import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/config_model.dart';
import 'package:base_pm2/domain/repository/config_repository.dart';

class GetConfigUseCase extends BaseUseCase<ConfigModel> {
  final ConfigRepository repository;

  GetConfigUseCase({required this.repository});

  @override
  Future<ConfigModel> invoke() async {
    return await repository.getConfig();
  }

  @override
  void validate() {}
}
