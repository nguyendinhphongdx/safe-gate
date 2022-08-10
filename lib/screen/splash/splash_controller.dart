import 'dart:io';

import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/core/sys/config_model.dart';
import 'package:base_pm2/common/core/widget/dialog/app_dialog_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/network/client.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/data/repositories_impl/config_repository_impl.dart';
import 'package:base_pm2/domain/use_case/get_config_use_case.dart';
import 'package:get/get.dart';

class SplashController extends BaseController {
  @override
  Future initialData() async {
    await fetchData();
  }

  @override
  Future<void> fetchData() async {
    ConfigModel configModel =
        await GetConfigUseCase(repository: ConfigRepositoryImpl()).invoke();
    if (configModel.cdnDomain != null) {
      AppConfig().setConfig(config: configModel);
      Client().setBaseUrl(AppConfig().getConfig().getApiUrl());
      AppConfig().setDeviceId(deviceId: HttpConstant.DEVICE_ID_3);
      AppConfig().randomColor();
      await delay(100);
      Get.offAllNamed(RoutePath.LOGIN);
    } else {
      Get.dialog(const AppDialogComp(
        content: HttpConstant.CONNECT_ERROR,
        showCancel: false,
        showConfirm: false,
      ));
    }
  }
}
