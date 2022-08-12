import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/screen/device/device_controller.dart';
import 'package:base_pm2/screen/widget/device/comp/managed_device/item_owner_device_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagedDeviceComp extends GetView<DeviceController> {
  const ManagedDeviceComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: Utils.isNotNullAndEmpty(controller.mConnectedDevice.value?.profiles),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              KeyLanguage.managed_device.tr,
              style: appStyle.textTheme.bodyText1,
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: _itemBuilder,
              itemCount: controller.mConnectedDevice.value?.profiles?.length ?? 0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    ProfileModel? profileModel = controller.mConnectedDevice.value?.profiles?[index];
    return ItemOwnerDeviceComp(profileModel: profileModel);
  }
}
