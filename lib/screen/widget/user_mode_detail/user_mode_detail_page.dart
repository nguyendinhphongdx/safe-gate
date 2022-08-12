import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/screen/widget/time_table_edit/reponsive/medium_layout.dart';
import 'package:base_pm2/screen/widget/user_mode_detail/user_mode_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserModeDetailPage extends GetWidget<UserModeDetailController> {
  UserModeDetailPage({Key? key}) : super(key: key) {
    Get.lazyPut(() => UserModeDetailController());
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout<UserModeDetailController>(
        appBar: AppBarComp(
          title: KeyLanguage.internet_manager.tr,
          isLight: true,
        ),
        child: const BaseResponsive(
          mediumScreen: MediumLayout(),
        ));
  }
}
