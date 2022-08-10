import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../search_device_controller.dart';

class BodyScanQrComp extends GetView<SearchDeviceController> {
  const BodyScanQrComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [const SizedBox(height: 16), bigQrComp, const SizedBox(height: 12), buttonComp],
    );
  }

  Widget get bigQrComp => ImageViewer(
        ImageResource.ic_qr_big,
        width: Get.width * 0.5,
      );

  Widget get buttonComp => InkWellComp(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: Colors.white)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SvgComp(url: ImageResource.ic_wifi_connect),
            const SizedBox(width: 12),
            Text(
              KeyLanguage.scan_in_network.tr,
              style: appStyle.textTheme.bodyText2?.apply(color: ColorResource.tabIndicator),
            )
          ],
        ),
      ),
      onTap: () => controller.onScanQr(false));
}
