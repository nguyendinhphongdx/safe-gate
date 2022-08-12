import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/screen/widget/time_table_edit/reponsive/medium_layout.dart';
import 'package:base_pm2/screen/widget/user_mode_list/user_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserModePage extends GetWidget<UserModeController> {
  UserModePage({Key? key}) : super(key: key) {
    Get.lazyPut(() => UserModeController());
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout<UserModeController>(
      appBar: AppBarComp(title: KeyLanguage.user_mode.tr),
      child: BaseResponsive(
        mediumScreen: MediumLayout(),
      ),
    );
  }
}
