import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/resource/enum_resource.dart';
import 'package:base_pm2/data/model/mode_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PickUserModeController extends BaseController {
  RxList<ModeModel> mModeData = <ModeModel>[].obs;
  RxBool isActiveMode = false.obs;
  RxString error = ''.obs;

  TextEditingController profileName = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Future initialData() async {
    mModeData.value = AppConfig().getConfig().getModes();
    setStatus(Status.success);
  }

  void setError(String? s) {
    error.value = s ?? '';
  }

  void onPressMode(ModeModel? mode) {
    mModeData.forEach((element) => element.isActive?.value = false);
    mode?.isActive?.value = true;
    setError('');
  }

  String? onValidate(String? s) {
    if (s == null) return KeyLanguage.not_empty.tr;
    if (s.trim().isEmpty) return KeyLanguage.not_empty.tr;
    return null;
  }
}
