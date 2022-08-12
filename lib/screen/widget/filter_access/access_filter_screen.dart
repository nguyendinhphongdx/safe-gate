import 'package:base_pm2/screen/widget/filter_access/access_filter_controller.dart';
import 'package:base_pm2/screen/widget/time_table_edit/reponsive/medium_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccessFilterPage extends GetWidget<AccessFilterController> {
  AccessFilterPage({Key? key}) : super(key: key) {
    Get.lazyPut(() => AccessFilterController());
  }

  @override
  Widget build(BuildContext context) {
    return const MediumLayout();
  }
}
