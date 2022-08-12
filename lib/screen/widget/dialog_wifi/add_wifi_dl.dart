import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/dialog/bg_dialog_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/data/model/widget/body_model.dart';
import 'package:base_pm2/screen/widget/dialog_wifi/add_wifi_controller.dart';
import 'package:base_pm2/screen/widget/dialog_wifi/comp/footer_comp.dart';
import 'package:base_pm2/screen/widget/dialog_wifi/comp/item_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddWifiDL extends GetWidget<AddWifiController> {
  final _controller = Get.lazyPut(() => AddWifiController());

  AddWifiDL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BgDialogComp(
          child: Container(
            constraints: BoxConstraints(maxHeight: Get.height * 0.8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                Text(KeyLanguage.application_initialization.tr,
                    style: appStyle.textTheme.bodyText1?.copyWith(
                        fontSize: 16,
                        color: ColorResource.tabIndicator,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                InkWellComp(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          KeyLanguage.wi_fi_configuration.tr,
                          style: appStyle.textTheme.bodyText1?.copyWith(
                              color: ColorResource.primary,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.add_circle_rounded,
                            size: 26, color: ColorResource.primary)
                      ],
                    ),
                    onTap: controller.onAddConfig),
                const SizedBox(height: 12),
                Container(
                  constraints: BoxConstraints(maxHeight: Get.height * 0.6),
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Column(
                        children: [
                          ...controller.bodyModels
                              .mapIndexed<Widget>(_buildItem)
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                ),
                const FooterComp(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index, BodyModel element) {
    return ItemBody(bodyModel: element);
  }
}
