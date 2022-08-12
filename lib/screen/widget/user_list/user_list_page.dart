import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/screen/widget/user_list/layout/user_list_medium_layout.dart';
import 'package:base_pm2/screen/widget/user_list/user_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListPage extends GetWidget<UserListController> {
  final _controller= Get.lazyPut(() => UserListController());
   UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MainLayout<UserListController>(
      appBar: AppBarComp(title: KeyLanguage.userProfile.tr,isLeading: false),
      child:const BaseResponsive(
        mediumScreen: UserListMediumLayout(),
      ),
    );
  }
}
