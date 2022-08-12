import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/screen/profile/user_detail_history/history/history_controller.dart';
import 'package:base_pm2/screen/profile/user_detail_history/history/reponsive/history_medium_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryPage extends GetWidget<HistoryController> {
  // ignore: unused_field
  final _controller = Get.lazyPut(() => HistoryController());

  HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BaseResponsive(
      mediumScreen: HistoryMediumLayout(),
    );
  }
}
