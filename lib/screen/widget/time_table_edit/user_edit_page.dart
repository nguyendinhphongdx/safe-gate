import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/account/reponsive/medium_layout.dart';
import 'package:base_pm2/screen/widget/time_table_edit/edit_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditUserPage extends GetWidget<EditUserController> {
  EditUserPage({Key? key}) : super(key: key) {
    Get.lazyPut(() => EditUserController());
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout<EditUserController>(
      backgroundColor: Colors.black.withOpacity(0.2),
      resizeToAvoidBottomInset: false,
      indicatorColor: ColorResource.primary,
      withImageBackground: false,
      child: const BaseResponsive(
        mediumScreen: MediumLayout(),
      ),
    );
  }
}
