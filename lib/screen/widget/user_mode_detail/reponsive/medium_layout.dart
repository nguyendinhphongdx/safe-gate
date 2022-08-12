import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/avatar/avatar_pick_comp.dart';
import 'package:base_pm2/common/core/widget/button/custom_switch_comp.dart';
import 'package:base_pm2/common/core/widget/tab_bar/no_color_tab_bar_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/widget/filter_access/app_web/app_web_tab.dart';
import 'package:base_pm2/screen/widget/filter_access/group/group_tab.dart';
import 'package:base_pm2/screen/widget/user_mode_detail/comp/item_mode_expand_comp.dart';
import 'package:base_pm2/screen/widget/user_mode_detail/user_mode_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediumLayout extends GetView<UserModeDetailController> {
  const MediumLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Obx(
                    () => PickAvatarComp(
                        isPick: true,
                        imageSize: const Size(76, 76),
                        iconSize: const Size(24, 24),
                        namePadding: 10,
                        url: Utils.concatImageLink(controller.avatar.value) ?? ImageResource.ic_account,
                        callBackFile: controller.onImagePicked,
                        name: controller.name.value,
                        inkwellPadding: EdgeInsets.zero),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(child: Text(KeyLanguage.mode_use.tr, style: appStyle.textTheme.bodyText1)),
                      Obx(
                        () => CustomSwitchComp(
                          value: !controller.isActiveMode.value,
                          onChanged: controller.onChangeStatus,
                          backgroundColor: !controller.isActiveMode.value
                              ? ColorResource.colorBaby
                              : ColorResource.colorAdult,
                          icon: ImageViewer(
                            !controller.isActiveMode.value
                                ? Utils.concatImageLink(controller.mode.value.type) ?? ImageResource.ic_baby
                                : Utils.concatImageLink(controller.mode.value.type) ?? ImageResource.ic_parent,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),

                            padding: const EdgeInsets.all(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                      onLongPress: controller.onChangeStatus,
                      child: Obx(() => ItemModeExpandComp(mode: controller.mode.value))),
                  const SizedBox(height: 26),
                  Row(
                    children: [
                      Text(KeyLanguage.use_manager_advand.tr, style: appStyle.textTheme.bodyText1),
                      const Expanded(child: SizedBox())
                    ],
                  ),
                  const SizedBox(height: 6),

                  // AccessFilterPage()
                ],
              ),
            ),
          )
        ];
      },
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 44,
              child: NoColorTabBarComp(
                  tabController: controller.tabController,
                  tabs: const [Tab(text: 'Ứng dụng & web'), Tab(text: 'Nhóm')]),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(controller: controller.tabController, children: [
                AppWebTab(),
                GroupTab(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
