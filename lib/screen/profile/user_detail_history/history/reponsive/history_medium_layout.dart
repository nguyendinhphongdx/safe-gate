import 'package:base_pm2/common/core/widget/tab_bar/no_color_tab_bar_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/screen/profile/user_detail_history/accessed/access_page.dart';
import 'package:base_pm2/screen/profile/user_detail_history/history/history_controller.dart';
import 'package:base_pm2/screen/profile/user_detail_history/violations/violations_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryMediumLayout extends GetView<HistoryController> {
  const HistoryMediumLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          SizedBox(
            height: 44,
            child: NoColorTabBarComp(
                tabController: controller.tabController,
                tabs: [Tab(text: KeyLanguage.accessed.tr), Tab(text: KeyLanguage.violations.tr)]),
          ),
          Expanded(
            child: pageViewComp,
          )
        ],
      ),
    );
  }

  Widget get pageViewComp => TabBarView(
        controller: controller.tabController,
        children: [
          AccessPage(),
          ViolationsPage(),
        ],
      );
}
