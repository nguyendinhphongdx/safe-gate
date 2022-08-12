import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/core/widget/layout/ink_well_comp.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/common/resource/keylanguage_resource/key_language.dart';
import 'package:base_pm2/screen/widget/device/dialog/device_assigned_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonDialogComp extends GetView<DeviceAssignedController> {
  const ButtonDialogComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(color: Colors.white, height: 1, width: double.infinity),
        Row(
          children: [
            Expanded(
                child: InkWellComp(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Text(
                        KeyLanguage.disconnect.tr,
                        style: appStyle.textTheme.bodyText1?.copyWith(color: ColorResource.tabIndicator,fontWeight: FontWeight.w600),
                      ),
                    ),
                    onTap: controller.onDisconnect)),
            Container(color: Colors.white, width: 1, height: 46),
            Expanded(
              child: InkWellComp(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      KeyLanguage.save.tr,
                      style: appStyle.textTheme.bodyText1?.copyWith(color: ColorResource.tabIndicator,fontWeight: FontWeight.w600),
                    ),
                  ),
                  onTap: controller.onSaveData),
            ),
          ],
        )
      ],
    );
  }
}
