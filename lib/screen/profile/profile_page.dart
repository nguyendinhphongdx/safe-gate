import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/screen/profile/profile_controller.dart';
import 'package:base_pm2/screen/profile/reponsive/profile_medium_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetWidget<ProfileController> {
  final _controller = Get.lazyPut(() => ProfileController());

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout<ProfileController>(
      appBar: AppBarComp(
        title: KeyLanguage.my_info.tr,
      ),
      child: const BaseResponsive(
        mediumScreen: ProfileMediumLayout(),
      ),
    );
  }
}
