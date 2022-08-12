import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/screen/widget/user_detail/reponsive/user_detail_layout.dart';
import 'package:base_pm2/screen/widget/user_detail/user_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailPage extends GetWidget<UserDetailController> {
  final _controller = Get.lazyPut(() => UserDetailController());

  UserDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout<UserDetailController>(
        appBar: AppBarComp(title: KeyLanguage.userProfile.tr, isLight: true),
        child: const BaseResponsive(
          mediumScreen: UserDetailLayout(),
        ));
  }
}
