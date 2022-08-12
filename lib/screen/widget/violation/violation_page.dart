import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/screen/widget/time_table_edit/reponsive/medium_layout.dart';
import 'package:base_pm2/screen/widget/violation/violation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViolationPage extends GetWidget<ViolationController> {
  ViolationPage({Key? key}) : super(key: key) {
    Get.lazyPut(() => ViolationController());
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout<ViolationController>(
        appBar: AppBarComp(
          title: 'Chi tiết vi phạm',
        ),
        child: const BaseResponsive(
          mediumScreen: MediumLayout(),
        ));
  }
}
