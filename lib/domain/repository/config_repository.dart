import 'package:base_pm2/common/core/sys/config_model.dart';

abstract class ConfigRepository{
  Future<ConfigModel> getConfig();
}