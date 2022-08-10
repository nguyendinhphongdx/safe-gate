import 'package:base_pm2/common/core/sys/app_config_base.dart';
import 'package:base_pm2/common/local_storage/local_storage.dart';


class AppConfig extends AppConfigBase {
  AppConfig._internal();

  static final AppConfig _config = AppConfig._internal();

  factory AppConfig() => _config;

  @override
  Future<void> authenticate() async {
  }

  @override
  Future<void> unAuthenticate() async {
    await LocalStorage().clearAll();
    setHasAuthenticated(false);
  }
}
