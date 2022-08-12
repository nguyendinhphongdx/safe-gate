import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/layout/empty_view.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/screen/report/comp/item_report_comp.dart';
import 'package:base_pm2/screen/report/comp/vertical_chart_v2.dart';
import 'package:base_pm2/screen/widget/items/item_controll_view.dart';
import 'package:base_pm2/screen/widget/items/over_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'overview_controller.dart';

class OverViewScreen extends GetWidget<OverViewController> {
  // ignore: unused_field
  final _overViewController = Get.lazyPut(() => OverViewController());

  OverViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout<OverViewController>(
      child: bodyOverView(),
      imageBackground: ImageResource.img_bg_login,
      resizeToAvoidBottomInset: false,
      appBar: AppBarComp(
        isLeading: false,
        title: const OverHeader(),
        backgroundColor: Colors.transparent,
        // height: 40,
      ),
    );
  }

  Widget bodyOverView() {
    return RefreshIndicator(
      onRefresh: controller.fetchData,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        itemCount: 1,
        itemBuilder: (_, __) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const ItemReportComp<OverViewController>(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    KeyLanguage.condition_use.tr,
                    style: appStyle.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
                // const SizedBox(height: 12),
                Obx(() => VerticalChartV2(report: controller.mReportData.value)),
                // const SizedBox(height: 12),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 0),
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Obx(
            //       () => ChartNoteComp(
            //           data: controller.mReportData.value.apps
            //               ?.map((e) => ChartData(title: e?.appAlias, color: e?.color))
            //               .toList()),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  KeyLanguage.access_manage.tr,
                  style: appStyle.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w400),
                ),
                InkWellComp(
                  onTap: controller.onAddUser,
                  padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                  isTransparent: true,
                  child: const SvgComp(
                    url: ImageResource.ic_add_round,
                    width: 18,
                    height: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Obx(
              () => !Utils.isNotNullAndEmpty(controller.listUser)
                  ? const EmptyView()
                  : ListView.builder(
                      itemCount: controller.listUser.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: _buildItem),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    ProfileModel? user = controller.listUser[index];
    return ItemControlView(
      user: user,
      onChangeStatus: () => controller.onChangeStatus(user),
      onUserPressed: () => controller.onUserPressed(user),
    );
  }
}
