import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/core/widget/dialog/app_dialog_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:get/get.dart';

class AccountController extends BaseController {
  @override
  Future initialData() async {
    setStatus(Status.success);
    await super.initialData();
  }

  void logout() {
    Get.dialog(AppDialogComp(
      content: KeyLanguage.exit_app.tr,
      onConfirm: _onConfirm,
    ));
  }

  void _onConfirm() {
    AppConfig().unAuthenticate();
    Get.back();
    Get.offAndToNamed(RoutePath.REMEMBER_LOGIN);
  }
}
