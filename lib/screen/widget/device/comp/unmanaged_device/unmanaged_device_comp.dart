import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/screen/device/device_controller.dart';
import 'package:base_pm2/screen/widget/device/comp/unmanaged_device/item_ud_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnmanagedDeviceComp extends GetWidget<DeviceController> {
  const UnmanagedDeviceComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: Utils.isNotNullAndEmpty(controller.mConnectedDevice.value?.devices),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleUnmanagedComp,
            const SizedBox(height: 12),
            ListView.builder(
              itemBuilder: _itemBuilder,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.mConnectedDevice.value?.devices?.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget get titleUnmanagedComp => Text(KeyLanguage.unmanaged_device.tr, style: appStyle.textTheme.bodyText1);

  Widget _itemBuilder(BuildContext context, int index) {
    DeviceModel? connectedDevice = controller.mConnectedDevice.value?.devices?[index];
    return ItemUDComp(deviceModel: connectedDevice);
  }
}
