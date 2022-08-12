import 'package:base_pm2/common/core/widget/button/button_dialog.dart';
import 'package:base_pm2/common/core/widget/dialog/bg_dialog_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/screen/widget/time_table_edit/comp/list_device_layout.dart';
import 'package:base_pm2/screen/widget/time_table_edit/comp/pick_user_mode_layout.dart';
import 'package:base_pm2/screen/widget/time_table_edit/comp/step_layout.dart';
import 'package:base_pm2/screen/widget/time_table_edit/edit_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediumLayout extends GetView<EditUserController> {
  const MediumLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          height: Get.height * 0.8,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: BgDialogComp(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Expanded(
                            child: TabBarView(
                                controller: controller.tabController,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [PickUserModeLayout(), ListDeviceLayout()])),
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible: controller.args?.type == UserEditType.PICK_MODE_AND_DEVICE,
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: StepLayout(),
                    )),
                Obx(
                  () => ButtonDialog(
                    cancelLabel: controller.mTextButtons[0],
                    confirmLabel: controller.mTextButtons[1],
                    onConfirm: controller.onNextStep,
                    onCancel: controller.onPreviousStep,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
