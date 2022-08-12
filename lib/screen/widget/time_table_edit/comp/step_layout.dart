import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/screen/widget/time_table_edit/comp/item_step_comp.dart';
import 'package:base_pm2/screen/widget/time_table_edit/edit_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepLayout extends GetView<EditUserController> {
  const StepLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: Obx(
        () => Row(
          children: [
            Expanded(
                child: InkWellComp(
                    onTap: () => controller.onPreviousStep(),
                    paddingAll: 0,
                    child: ItemStepComp(
                      title: '1',
                      isActive: controller.currentStep.value == 0,
                    ))),
            InkWellComp(
                onTap: () => controller.onNextStep(),
                paddingAll: 0,
                child: ItemStepComp(
                  title: '2',
                  isActive: controller.currentStep.value == 1,
                  isLast: true,
                )),
          ],
        ),
      ),
    );
  }
}
