import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/core/widget/avatar/avatar_pick_comp.dart';
import 'package:base_pm2/common/core/widget/tab_bar/tab_bar_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/profile/user_detail_history/history/history_page.dart';
import 'package:base_pm2/screen/widget/user_detail/comp/report_comp.dart';
import 'package:base_pm2/screen/widget/user_detail/user_detail_controller.dart';
import 'package:base_pm2/screen/widget/user_detail_setting/user_detail_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDetailLayout extends GetView<UserDetailController> {
  const UserDetailLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  headerComp,
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ];
      },
      body:  //Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //   child: Column(
      //     children: [
      //       tabBarComp,
      //       const SizedBox(height: 8),
      //       Expanded(
      //         child: TabBarView(
      //           controller: controller.tabController,
      //           // physics: const NeverScrollableScrollPhysics(),
      //           children: [
      //             HistoryPage(),
      //             ReportComp(),
      //             UserDetailSettingPage(),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
       UserDetailSettingPage(),
    );
  }

  Widget get headerComp => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Expanded(
          //   child: InkWellComp(
          //       onTap: controller.showPauseDialog,
          //       isTransparent: true,
          //       child: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           const SvgComp(url: ImageResource.ic_pause),
          //           const SizedBox(height: 8),
          //           Text(
          //             'Ngắt kết nối',
          //             maxLines: 1,
          //             overflow: TextOverflow.ellipsis,
          //             style: appStyle.textTheme.bodyText1?.copyWith(fontSize: 10),
          //           )
          //         ],
          //       )),
          // ),
          Obx(
            () => PickAvatarComp(
              imageSize: const Size(100, 100),
              iconSize: const Size(24, 24),
              editPosition: const Offset(0, 0),
              inkwellPadding: EdgeInsets.zero,
              url: Utils.concatImageLink(controller.avatar.value) ??
                  ImageResource.ic_account,
              callBackFile: controller.onImagePicked,
              name: controller.name.value,
            ),
          ),

          // Expanded(
          //   child: InkWellComp(
          //       onTap: controller.showTemporarilyOpenDL,
          //       isTransparent: true,
          //       child: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           const SvgComp(url: ImageResource.ic_clock),
          //           const SizedBox(height: 8),
          //           Text(
          //             'Mở nhanh tạm thời',
          //             maxLines: 1,
          //             overflow: TextOverflow.ellipsis,
          //             style: appStyle.textTheme.bodyText1?.copyWith(fontSize: 10),
          //           )
          //         ],
          //       )),
          // ),
        ],
      );

  Widget get tabBarComp => Obx(
        () => TabBarComp(
          controller: controller.tabController,
          radius: 12,
          heightBackground: 16,
          heightTab: 36,
          listTab: [
            Tab(
              child: _ItemTab(
                title: KeyLanguage.history.tr,
                isActive: controller.selectedTab.value == 0,
              ),
            ),
            Tab(
              child: _ItemTab(
                title: KeyLanguage.statistical.tr,
                isActive: controller.selectedTab.value == 1,
              ),
            ),
            Tab(
              child: _ItemTab(
                title: KeyLanguage.setting.tr,
                isActive: controller.selectedTab.value == 2,
              ),
            ),
          ],
          onChangeTab: (int index) {},
        ),
      );
}

class _ItemTab extends StatelessWidget {
  const _ItemTab({Key? key, this.title, this.isActive}) : super(key: key);
  final String? title;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          title ?? KeyLanguage.history.tr,
          style: appStyle.textTheme.subtitle1?.apply(
              color: isActive ?? false
                  ? Colors.white
                  : Colors.white.withOpacity(.6)),
          maxLines: 1,
        ));
  }
}
