import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/button/button_dialog.dart';
import 'package:base_pm2/common/core/widget/dialog/bg_dialog_comp.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/widget/edit_time/comp/item_day_pick.dart';
import 'package:base_pm2/screen/widget/edit_time/comp/item_time_pick.dart';
import 'package:base_pm2/screen/widget/edit_time/edit_time_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditTimePage extends GetWidget<EditTimeController> {
  EditTimePage({Key? key}) : super(key: key) {
    Get.lazyPut(() => EditTimeController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BgDialogComp(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 24),
                  Text('Cấu hình thời gian',
                      style: appStyle.textTheme.bodyText1?.copyWith(
                          fontSize: 16, color: ColorResource.tabIndicator, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  ItemTimePick(timeModel: controller.timeModel, application: controller.application),
                  const SizedBox(height: 16),
                  ItemDayPick(timeModel: controller.timeModel, application: controller.application),
                  const SizedBox(height: 32),
                  ButtonDialog(
                      cancelLabel: 'Bỏ qua',
                      confirmLabel: 'Lưu lại',
                      showShadow: false,
                      onCancel: Get.back,
                      onConfirm: controller.onConfirmUpdate),
                ],
              ),
            ),
          ),
          Obx(() =>
              Visibility(visible: controller.getStatus() == Status.waiting, child: const IndicatorComp()))
        ],
      ),
    );
  }
}
