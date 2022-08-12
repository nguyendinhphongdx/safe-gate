import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/report/comp/report_header_comp.dart';
import 'package:base_pm2/screen/report/comp/report_view.dart';
import 'package:base_pm2/screen/report/comp/tab_report_comp.dart';
import 'package:base_pm2/screen/report/controllers/report_last_week_comp.dart';
import 'package:base_pm2/screen/report/controllers/report_option_comp.dart';
import 'package:base_pm2/screen/report/controllers/report_this_week_comp.dart';
import 'package:base_pm2/screen/report/controllers/report_yesterday_comp.dart';
import 'package:base_pm2/screen/report/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediumLayout extends GetView<ReportController> {
  const MediumLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.getStatus() == Status.loading
          ? IndicatorComp()
          : Column(
              children: [
                const ReportHeaderComp(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TabReportComp(controller: controller.tabController),
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      ReportView(),
                      ReportYesterdayComp(),
                      ReportThisWeekComp(),
                      ReportLastWeekComp(),
                      ReportOptionComp(),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
