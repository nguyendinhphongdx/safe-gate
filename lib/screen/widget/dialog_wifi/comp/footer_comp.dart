import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/screen/widget/dialog_wifi/add_wifi_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FooterComp extends GetView<AddWifiController> {
  const FooterComp({Key? key}) : super(key: key);

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
                  paddingAll: 12,

                  child: Center(
                    child: Text(
                      'Quay lại',
                      style: appStyle.textTheme.bodyText1
                          ?.copyWith(color: ColorResource.tabIndicator, fontWeight: FontWeight.w600),
                    ),
                  ),
                  onTap: () => Get.back(),
                )),
            Container(color: Colors.white, width: 1, height: 42),
            Expanded(
              child: InkWellComp(
                onTap:controller.onFinish,
                paddingAll: 12,
                child: Center(
                  child: Text(
                    'Hoàn thành',
                    style: appStyle.textTheme.bodyText1
                        ?.copyWith(color: ColorResource.tabIndicator, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
