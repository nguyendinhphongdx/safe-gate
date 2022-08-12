import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/dialog/bg_dialog_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/screen/widget/device/dialog/comp/button_dialog_comp.dart';
import 'package:base_pm2/screen/widget/device/dialog/comp/device_comp.dart';
import 'package:base_pm2/screen/widget/device/dialog/comp/item_add_user.dart';
import 'package:base_pm2/screen/widget/device/dialog/comp/item_more_comp.dart';
import 'package:base_pm2/screen/widget/device/dialog/device_assigned_controller.dart';
import 'package:base_pm2/screen/widget/device/dialog/item_member_comp.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceAssignedDL extends GetWidget<DeviceAssignedController> {
  final _controller = Get.lazyPut(() => DeviceAssignedController());

  DeviceAssignedDL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(12, 0, 12, ViewUtils.height * 0.18),
        child: BgDialogComp(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    const DeviceComp(),
                    const SizedBox(height: 12),
                    Container(color: ColorResource.hint, height: 0.5, width: double.infinity),
                    const SizedBox(height: 22),
                    Text('${KeyLanguage.newMemberEquipment.tr}:',
                        style: appStyle.textTheme.subtitle1?.copyWith(color: ColorResource.tabIndicator,fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Obx(
                      ()=> Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (controller.mProfiles.length <= 3)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Obx(
                                () => Row(
                                  children: controller.mProfiles.mapIndexed<Widget>(_itemBuilder).toList(),
                                ),
                              ),
                            ),
                          if (controller.mProfiles.length > 3)
                            Expanded(
                              child: ExpandablePanel(
                                  collapsed: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        children: [
                                          ...controller.mProfiles.mapIndexed<Widget>(_itemBuilder).toList(),
                                         ExpandableButton(child: ItemMoreComp(overLength: controller.mProfiles.length - 3,)),
                                        ]
                                      ),
                                  ),
                                  expanded: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child:Row(
                                        children: controller.mProfiles.mapIndexed<Widget>(_itemBuilderAll).toList(),
                                      ),
                                  )),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: ItemAddUser(
                              onAddUser: controller.onAddUser,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // const SizedBox(height: 4),
              const ButtonDialogComp(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index, ProfileModel? profileModel) {

    if (index >= 3) return const SizedBox();

    return ItemMemberComp(
      profileModel: profileModel,
      onUserPressed: () => controller.onUserPressed(profileModel),
    );
  }

  Widget _itemBuilderAll(int index, ProfileModel? profileModel) {
    return ItemMemberComp(
      profileModel: profileModel,
      onUserPressed: () => controller.onUserPressed(profileModel),
    );
  }

}
