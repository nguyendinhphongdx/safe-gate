import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/screen/widget/time_table/time_table_controller.dart';
import 'package:base_pm2/screen/widget/time_table_edit/reponsive/medium_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeTablePage extends GetWidget<TimeTableController> {
  TimeTablePage({Key? key}) : super(key: key) {
    Get.lazyPut(() => TimeTableController());
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout<TimeTableController>(
      appBar: AppBarComp(title:  /*controller.args?.title ?? */'Chế độ trẻ em',),
        child: const BaseResponsive(
      mediumScreen: MediumLayout(),
    ));
  }
}
