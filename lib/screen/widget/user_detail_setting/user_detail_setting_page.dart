import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/screen/widget/user_detail_setting/reponsive/user_detail_medium_layout.dart';
import 'package:base_pm2/screen/widget/user_detail_setting/user_detail_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailSettingPage extends GetWidget<UserDetailSettingController> {
  final _controller = Get.lazyPut(() => UserDetailSettingController());

  UserDetailSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainLayout<UserDetailSettingController>(
      withImageBackground: false,
      child: BaseResponsive(
        mediumScreen: UDSettingMediumLayout(),
      ),
    );
  }
}
