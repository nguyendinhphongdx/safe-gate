import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

class TabReportComp extends StatelessWidget {
  const TabReportComp({Key? key, this.controller}) : super(key: key);
  final TabController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            labelStyle: appStyle.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600,color: Colors.white),
            unselectedLabelStyle: appStyle.textTheme.subtitle1,
            unselectedLabelColor: Colors.white.withOpacity(0.6),
            padding: EdgeInsets.zero,
            // indicatorSize: TabBarIndicatorSize.tab,
            // labelPadding: EdgeInsets.symmetric(horizontal: 8),
            // indicator: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            indicator: MaterialIndicator(
              color: Colors.white,
              strokeWidth: 1,
height: 2,
bottomLeftRadius: 100,
              bottomRightRadius: 100,
              topLeftRadius: 100,topRightRadius: 100,
              paintingStyle: PaintingStyle.fill,
            ),
            controller: controller,
            tabs: [
              Tab(text: KeyLanguage.today.tr),
              Tab(text: KeyLanguage.yesterday.tr),
              Tab(text: KeyLanguage.this_week.tr),
              Tab(text: KeyLanguage.last_week.tr),
              Tab(text: KeyLanguage.option.tr),
            ],
          ),
          Positioned(
              bottom: 0.5,
              child: Container(
                height: 0.5,
                width: ViewUtils.width,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
