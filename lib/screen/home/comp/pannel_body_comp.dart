import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/screen/account/account_page.dart';
import 'package:base_pm2/screen/device/device_page.dart';
import 'package:base_pm2/screen/home/panel_controller.dart';
import 'package:base_pm2/screen/overview/overview_screen.dart';
import 'package:base_pm2/screen/report/report_page.dart';
import 'package:base_pm2/screen/widget/user_list/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PanelBodyComp extends GetView<PanelController> {
  const PanelBodyComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: _buildItem,
      itemCount: 5,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        return DevicePage();
      case 1:
        return UserListPage();
      case 2:
        return OverViewScreen();
      case 3:
        return ReportPage();
      case 4:
        return AccountPage();
    }
    return const UndefinedLayout(name: '');
  }
}
