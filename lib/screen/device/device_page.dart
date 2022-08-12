import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/layout/empty_view.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/screen/device/device_controller.dart';
import 'package:base_pm2/screen/widget/device/comp/managed_device/managed_device_comp.dart';
import 'package:base_pm2/screen/widget/device/comp/unmanaged_device/unmanaged_device_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DevicePage extends GetWidget<DeviceController> {
  DevicePage({Key? key}) : super(key: key) {
    Get.lazyPut(() => DeviceController());
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout<DeviceController>(
        appBar: AppBarComp(
          isLeading: false,
          title: KeyLanguage.device.tr,
          centerTitle: true,
        ),
        child: RefreshIndicator(
          onRefresh: controller.fetchData,
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: _buildItem,
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ));
  }

  Widget _buildItem(BuildContext context, int index) {
    return Obx(
      () => !Utils.isNotNullAndEmpty(controller.mConnectedDevice.value?.devices) &&
              !Utils.isNotNullAndEmpty(controller.mConnectedDevice.value?.profiles)
          ? Padding(padding: EdgeInsets.only(top: ViewUtils.height * 0.4), child: const EmptyView())
          : Column(
              children: const [
                UnmanagedDeviceComp(),
                SizedBox(height: 22),
                ManagedDeviceComp(),
              ],
            ),
    );
  }
}
