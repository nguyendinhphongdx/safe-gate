import 'package:base_pm2/common/core/widget/tab_bar/no_color_tab_bar_comp.dart';
import 'package:base_pm2/screen/widget/filter_access/access_filter_controller.dart';
import 'package:base_pm2/screen/widget/filter_access/app_web/app_web_tab.dart';
import 'package:base_pm2/screen/widget/filter_access/group/group_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediumLayout extends GetView<AccessFilterController> {
  const MediumLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 44,
          child: NoColorTabBarComp(
              tabController: controller.tabController,
              tabs: const [Tab(text: 'Ứng dụng & web'), Tab(text: 'Nhóm')]),
        ),
        const SizedBox(height: 16),
        TabBarView(controller: controller.tabController, children: [
          AppWebTab(),
          GroupTab(),
        ])
      ],
    );
  }
}
