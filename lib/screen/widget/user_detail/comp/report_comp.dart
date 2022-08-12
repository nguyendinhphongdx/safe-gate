import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/keylanguage_resource/key_language.dart';
import 'package:base_pm2/data/model/report/report_model.dart';
import 'package:base_pm2/screen/report/comp/item_chart_horizontal.dart';
import 'package:base_pm2/screen/report/comp/item_report_comp.dart';
import 'package:base_pm2/screen/widget/user_detail/comp/report_chart_by_day_comp.dart';
import 'package:base_pm2/screen/widget/user_detail/comp/report_layout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportComp extends GetWidget<ReportLayoutController> {
  ReportComp({Key? key}) : super(key: key) {
    Get.lazyPut(() => ReportLayoutController());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(KeyLanguage.overview.tr, style: appStyle.textTheme.bodyText1),
          const SizedBox(height: 8),
          const ItemReportComp<ReportLayoutController>(),
          const SizedBox(height: 28),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(KeyLanguage.condition_use.tr, style: appStyle.textTheme.bodyText1),
              // const SizedBox(height: 10),
              // TextYellow(title: KeyLanguage.most_use_app.tr),
              const SizedBox(height: 18),
              GestureDetector(
                  onTap: () => Get.toNamed(RoutePath.ACCESS_HISTORY,parameters: controller.getParamForHistory()),
                  child: Obx(() => ReportChartByDayComp(reportProfileModel: controller.mReport.value))),
              const SizedBox(height: 12),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Obx(
              //     () => ChartNoteComp(
              //         data: controller.mReport.value?.apps?.mapIndexed<ChartData>(_buildItem).toList()),
              //   ),
              // ),
              const SizedBox(height: 8),
            ],
          )
        ],
      ),
    );
  }

  ChartData _buildItem(int index, AppReportDayModel? element) {
    return ChartData(title: element?.appAlias, color: element?.color);
  }
}
