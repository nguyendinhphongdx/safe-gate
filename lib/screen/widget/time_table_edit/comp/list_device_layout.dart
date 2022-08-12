import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/layout/empty_view.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/common/resource/enum_resource.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/screen/widget/time_table_edit/comp/item_device_comp.dart';
import 'package:base_pm2/screen/widget/time_table_edit/comp/list_device_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDeviceLayout extends GetWidget<ListDeviceController> {
  ListDeviceLayout({Key? key}) : super(key: key) {
    Get.lazyPut(() => ListDeviceController());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.getStatus() == Status.loading
        ? const Center(
            child: IndicatorComp(
            backgroundColor: Colors.transparent,
            indicatorColor: ColorResource.primary,
          ))
        : Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      KeyLanguage.add_device_used.tr,
                      style: appStyle.textTheme.bodyText2?.copyWith(
                          color: ColorResource.tabIndicator, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Obx(
                        () => Column(
                          children: controller.listDeviceModel.mapIndexed<Widget>(_buildItem).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (!Utils.isNotNullAndEmpty(controller.listDeviceModel))
                EmptyView(textColor: ColorResource.tabIndicator),
              if (controller.getStatus() == Status.waiting)
                const Center(
                    child: IndicatorComp(
                  backgroundColor: Colors.transparent,
                  indicatorColor: ColorResource.primary,
                ))
            ],
          ));
  }

  Widget _buildItem(int index, DeviceModel? element) {
    return ItemDeviceComp(
      deviceModel: element,
      textColor: ColorResource.tabIndicator,
      onChangeStatus: () => controller.onChangeDeviceStatus(element),
    );
  }
}
