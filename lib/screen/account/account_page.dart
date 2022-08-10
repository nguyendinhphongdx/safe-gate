import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/screen/account/account_controller.dart';
import 'package:base_pm2/screen/account/reponsive/medium_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends GetWidget<AccountController> {
  AccountPage({Key? key}) : super(key: key) {
    Get.lazyPut(() => AccountController());
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout<AccountController>(
        appBar: AppBarComp(
          title: KeyLanguage.setting.tr,
          isLeading: false,
        ),
        child: const BaseResponsive(
          mediumScreen: MediumLayout(),
        ));
  }
}
