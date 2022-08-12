import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/common/resource/keylanguage_resource/key_language.dart';
import 'package:base_pm2/data/model/widget/body_model.dart';
import 'package:base_pm2/screen/widget/dialog_wifi/add_wifi_controller.dart';
import 'package:base_pm2/screen/widget/dialog_wifi/comp/drop_down_device.dart';
import 'package:base_pm2/screen/widget/dialog_wifi/comp/edit_text_device.dart';
import 'package:base_pm2/screen/widget/dialog_wifi/comp/switch_device.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemBody extends GetView<AddWifiController> {
  const ItemBody({Key? key, this.bodyModel}) : super(key: key);
  final BodyModel? bodyModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWellComp(
            onTap: () => controller.onDeleteItem(bodyModel),
            padding: const EdgeInsets.only(bottom: 16),
            isTransparent: true,
            child: Row(
              children: [
                Expanded(
                  child: Container(height: 0.5, color: ColorResource.tabIndicator.withOpacity(.2)),
                ),
                const SizedBox(width: 4),
                const ImageViewer(ImageResource.ic_delete, width: 13, height: 13),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                EditTextDevice(
                    controller: bodyModel?.wifiName, hint: KeyLanguage.wifi_name.tr, isInvisiblePassword: false),
                const SizedBox(height: 22),
                Obx(() => EditTextDevice(
                    controller: bodyModel?.wifiPass,
                    hint: KeyLanguage.password.tr,
                    iconColor: bodyModel?.isNotEmptyPass?.value ?? false
                        ? ColorResource.primary
                        : ColorResource.primary.withOpacity(.5),
                    enableDefaultSuffix: true,
                    isInvisiblePassword: true,
                    textInputAction: TextInputAction.done)),
                ExpandablePanel(
                    collapsed: ExpandableButton(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            KeyLanguage.advanced_option.tr,
                            textAlign: TextAlign.center,
                            style: appStyle.textTheme.bodyText2?.copyWith(color: ColorResource.primary),
                          ),
                        ),
                      ),
                    ),
                    expanded: Column(
                      children: [
                        const SizedBox(height: 16),
                        Obx(
                          () => DropDownDevice(
                            currentValue: bodyModel?.wifiHash?.value,
                            hint: KeyLanguage.encode.tr,
                            options: controller.hashOptions,
                            onSelected: (v) {
                              bodyModel?.wifiHash?.value = (v as BaseOptionDropdown).name ?? '';
                              showLog(bodyModel?.wifiHash);
                            },
                          ),
                        ),
                        const SizedBox(height: 22),
                        Obx(
                          () => DropDownDevice(
                            currentValue: bodyModel?.frequency?.value,
                            hint: KeyLanguage.frequency.tr,
                            options: controller.frequenlyOptions,
                            onSelected: (v) {
                              bodyModel?.frequency?.value = (v as BaseOptionDropdown).name ?? '';
                            },
                          ),
                        ),
                        const SizedBox(height: 22),
                        Obx(
                          () => DropDownDevice(
                            currentValue: bodyModel?.bandwidth?.value,
                            hint: KeyLanguage.network_bandwidth.tr,
                            options: controller.brandOptions,
                            onSelected: (v) {
                              bodyModel?.bandwidth?.value = (v as BaseOptionDropdown).name ?? '';
                            },
                          ),
                        ),
                        const SizedBox(height: 22),
                        Obx(() => SwitchDevice(
                              title: KeyLanguage.hind_wifi.tr,
                              onChangeStatus: () => controller.onChangeNameStatus(bodyModel),
                              isActive: bodyModel?.noShowNameWifi?.value ?? false,
                            )),
                        const SizedBox(height: 32),
                        Obx(() => SwitchDevice(
                              title: KeyLanguage.access_permission.tr,
                              onChangeStatus: () => controller.onChangeUseStatus(bodyModel),
                              isActive: bodyModel?.useEnable?.value ?? false,
                            )),
                        const SizedBox(height: 2),
                        ExpandableButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              KeyLanguage.collapse.tr,
                              style: appStyle.textTheme.bodyText2?.copyWith(color: ColorResource.primary),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4)
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
