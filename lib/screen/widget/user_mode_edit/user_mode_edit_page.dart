import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/screen/widget/time_table_edit/reponsive/medium_layout.dart';
import 'package:base_pm2/screen/widget/user_mode_edit/user_mode_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserModeEditPage extends GetWidget<UserModeEditController> {
  UserModeEditPage({Key? key}) : super(key: key) {
    Get.lazyPut(() => UserModeEditController());
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout<UserModeEditController>(
        appBar: AppBarComp(
          title: controller.args?.id == null
              ? KeyLanguage.add_user_mode.tr
              : KeyLanguage.edit_user_mode.tr,
        ),
        child: const BaseResponsive(
          mediumScreen: MediumLayout(),
        ));
  }
}
