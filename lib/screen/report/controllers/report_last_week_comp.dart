import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/layout/empty_view.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/model/report/report_model.dart';
import 'package:base_pm2/screen/profile/user_detail_history/violations/violations_controller.dart';
import 'package:base_pm2/screen/report/comp/item_chart_horizontal.dart';
import 'package:base_pm2/screen/report/comp/item_report_comp.dart';
import 'package:base_pm2/screen/report/comp/time_line_report_comp.dart';
import 'package:base_pm2/screen/report/controllers/last_week_controller.dart';
import 'package:base_pm2/screen/widget/device/dialog/item_member_comp.dart';
import 'package:base_pm2/screen/widget/user_detail/comp/report_chart_by_day_comp.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportLastWeekComp extends GetView<LastWeekController> {
  ReportLastWeekComp({Key? key}) : super(key: key) {
    Get.lazyPut(() => LastWeekController());
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
          const SizedBox(height: 12),
          Row(
            children: [
              Text(KeyLanguage.overview.tr, style: appStyle.textTheme.bodyText1),
              const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 8),
          const ItemReportComp<LastWeekController>(),
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
                        )),
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
          Obx(
            () => ListView.separated(
              padding: const EdgeInsets.only(),
              itemBuilder: _buildItemExpaned,
              itemCount: controller.mHistories.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) =>
                  Container(height: 1, width: double.infinity, color: ColorResource.divider),
            ),
          ),
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

  Widget _buildItemExpaned(BuildContext context, int index) {
    ViolationHeaderData headerData = controller.mHistories[index];
    return ExpandablePanel(
      controller: headerData.expandableController,
      collapsed: InkWellComp(
        onTap: () => headerData.onExpandedClick(controller.mHistories),
        paddingAll: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Row(
            children: [
              Text(DateTimeUtils.getTitleByDate(headerData.date), style: appStyle.textTheme.bodyText1),
              const Expanded(child: SizedBox()),
              const ImageViewer(ImageResource.ic_arrow_down, width: 12, height: 12)
            ],
          ),
        ),
      ),
      expanded: Column(
        children: [
          ExpandableButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: Row(
                children: [
                  Expanded(
                      child: Text(DateTimeUtils.getTitleByDate(headerData.date),
                          style: appStyle.textTheme.bodyText1)),
                  const SizedBox(width: 16),
                  const ImageViewer(ImageResource.ic_arrow_up, width: 12, height: 12)
                ],
              ),
            ),
          ),
          Obx(() => headerData.isExpanded?.value ?? false
              ? TimeLineReportComp(
                  violationData: headerData,
                  profileId: controller.profileSelected.value?.profileId.toString(),
                )
              : const SizedBox()),
        ],
      ),
      theme: const ExpandableThemeData(
        hasIcon: false,
        headerAlignment: ExpandablePanelHeaderAlignment.center,
      ),
    );
  }
}
