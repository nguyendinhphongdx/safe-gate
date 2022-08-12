import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/screen/report/report_controller.dart';
import 'package:base_pm2/screen/report/reponsive/medium_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ReportPage extends GetWidget<ReportController> {
  ReportPage({Key? key}) : super(key: key) {
    final _controller = Get.lazyPut(() => ReportController());
  }

  @override
  Widget build(BuildContext context) {
    return const MainLayout<ReportController>(
        child: BaseResponsive(
      mediumScreen: MediumLayout(),
    ));
  }
}
