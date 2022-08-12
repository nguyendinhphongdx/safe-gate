import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/button/button_dialog.dart';
import 'package:base_pm2/common/core/widget/dialog/bg_dialog_comp.dart';
import 'package:base_pm2/common/core/widget/dialog/body_dialog_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/mode_model.dart';
import 'package:base_pm2/screen/widget/time_table_edit/comp/item_mode_pick.dart';
import 'package:base_pm2/screen/widget/user_mode_detail/dialog/pick_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickModeDialog extends GetWidget<PickModeController> {
  PickModeDialog({Key? key}) : super(key: key) {
    Get.lazyPut(() => PickModeController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BgDialogComp(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              Text(
                'Chế độ người dùng',
                style: appStyle.textTheme.bodyText1
                    ?.copyWith(fontSize: 16, color: ColorResource.tabIndicator, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              BodyDialogComp<PickModeController>(
                child: Obx(
                  () => Container(
                    constraints: BoxConstraints(maxHeight: ViewUtils.height * 0.5),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: controller.mModeData.mapIndexed<Widget>(_buildItem).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => ButtonDialog(
                  cancelLabel: 'Bỏ qua',
                  confirmLabel: 'Lưu lại',
                  showShadow: false,
                  isEnable: controller.isEnableUpdate.value,
                  onConfirm: controller.onConfirm,
                  onCancel: controller.onCancel,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index, ModeModel element) {
    ModeModel model = controller.mModeData[index];
    return Obx(
      () => ItemModePickComp(
        mode: model,
        shouldShowArrow: false,
        onModePress: controller.onPressMode,
        isActive: model.isActive!.value,
      ),
    );
  }
}
