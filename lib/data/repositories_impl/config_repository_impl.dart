import 'package:base_pm2/common/core/sys/config_model.dart';
import 'package:base_pm2/common/network/client.dart';
import 'package:base_pm2/domain/repository/config_repository.dart';

class ConfigRepositoryImpl implements ConfigRepository {
  ConfigRepositoryImpl._internal();

  static final ConfigRepositoryImpl _impl = ConfigRepositoryImpl._internal();

  factory ConfigRepositoryImpl() => _impl;

  @override
  Future<ConfigModel> getConfig() async{
    return await Client().serviceStatic.getConfig({});
  }
}
