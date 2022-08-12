// ignore_for_file: prefer_const_constructors

import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/layout/empty_view.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/model/report/report_model.dart';
import 'package:base_pm2/screen/report/comp/item_chart_horizontal.dart';
import 'package:base_pm2/screen/report/comp/item_history_data_comp.dart';
import 'package:base_pm2/screen/report/comp/item_report_comp.dart';
import 'package:base_pm2/screen/report/today_controller.dart';
import 'package:base_pm2/screen/widget/device/dialog/item_member_comp.dart';
import 'package:base_pm2/screen/widget/user_detail/comp/report_chart_by_day_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportView extends GetWidget<TodayController> {
  ReportView({Key? key}) : super(key: key) {
    Get.lazyPut(() => TodayController());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 12),
          Obx(
            () => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: controller.mProfiles.mapIndexed<Widget>(_itemBuilder).toList(),
              ),
            ),
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              Text(KeyLanguage.overview.tr, style: appStyle.textTheme.bodyText1),
              const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 8),
          ItemReportComp<TodayController>(),
          const SizedBox(height: 26),
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(KeyLanguage.condition_use.tr, style: appStyle.textTheme.bodyText1),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                const SizedBox(height: 14),
                // TextYellow(title: KeyLanguage.most_use_app.tr),
                // const SizedBox(height: 12),
                !Utils.isNotNullAndEmpty(controller.mReport.value?.reportModels)
                    ? EmptyView()
                    : GestureDetector(
                        onTap: () => Get.toNamed(RoutePath.ACCESS_HISTORY,
                            parameters: controller.getParamForHistory()),
                        child: ReportChartByDayComp(
                          reportProfileModel: controller.mReport.value,
                        ),
                      ),
                // const SizedBox(height: 8),
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: ChartNoteComp(
                //       data: controller.mReport.value?.apps?.mapIndexed<ChartData>(_buildNoteReport).toList()),
                // ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Row(
            children: [
              Text(KeyLanguage.history.tr, style: appStyle.textTheme.bodyText1),
              const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 8),
          Obx(() => ItemHistoryDataComp(
                reportProfileModel: controller.mReportProfileModel.value,
              )),
        ],
      ),
    );
  }

  Widget _itemBuilder(int index, ProfileModel? profile) {
    return ItemMemberComp(
      textColor: Colors.white,
      profileModel: profile,
      onUserPressed: () => controller.onProfilePressed(profile),
    );
  }

  ChartData _buildNoteReport(int index, AppReportDayModel? element) {
    return ChartData(title: element?.appAlias, color: element?.color);
  }
}

class TextYellow extends StatelessWidget {
  const TextYellow({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title ?? '',
          style: appStyle.textTheme.bodyText2?.apply(color: ColorResource.textYellow),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
