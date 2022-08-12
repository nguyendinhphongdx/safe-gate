import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/screen/widget/device/comp/icon_device_type.dart';
import 'package:base_pm2/screen/widget/device/dialog/device_assigned_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceComp extends GetView<DeviceAssignedController> {
  const DeviceComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 4),
      child: IntrinsicHeight(
        child: Row(
          children: [
            IconDeviceType(deviceType: -1),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getNameDevice(),
                      style: appStyle.textTheme.bodyText1?.copyWith(
                          color: ColorResource.tabIndicator,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${KeyLanguage.connect_time.tr}: ${DateTimeUtils.intToFormat(controller.args?.model?.createdTime, DateTimeUtils.HM_DDMMYYYY) ?? ''}',
                      style: appStyle.textTheme.bodyText2
                          ?.apply(color: ColorResource.tabIndicator.withOpacity(0.6)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getNameDevice() {
    if (controller.args?.model?.deviceInfo?.vendor != null) {
      return controller.args?.model?.deviceInfo?.vendor ?? controller.args?.model?.macAddress ?? '';
    }
    if (controller.args?.model?.deviceNameAlias == '*') return controller.args?.model?.macAddress ?? '';
    return controller.args?.model?.deviceNameAlias ?? controller.args?.model?.macAddress ?? '';
  }
}
