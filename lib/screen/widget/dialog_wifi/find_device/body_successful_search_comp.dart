import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/core/widget/image/svg_comp.dart';
import 'package:base_pm2/common/core/widget/text_field/text_field_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BodySuccessfulSearchComp extends StatelessWidget {
  const BodySuccessfulSearchComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        iconFindDeviceComp,
        const SizedBox(height: 8),
        textDeviceComp(
            title: KeyLanguage.device_code.tr,
            value: HassData.HASH_DEVICE_CODE),
        textDeviceComp(
            title: KeyLanguage.version.tr, value: HassData.HASH_DEVICE_VERSION),
        const SizedBox(height: 22),
        textSetNameDeviceComp,
        const SizedBox(height: 16),
        textFieldSetNameComp,
      ],
    );
  }

  Widget get iconFindDeviceComp => Container(
        padding: const EdgeInsets.all(10),
        width: 52,
        height: 52,
        decoration: BoxDecoration(
            color: ColorResource.primary,
            borderRadius: BorderRadius.circular(100)),
        child: const SvgComp(
          url: ImageResource.ic_devices,
          width: 30,
          height: 30,
        ),
      );

  Widget textDeviceComp({required String title, required String value}) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$title: ',
              style: appStyle.textTheme.bodyText2?.copyWith(
                  color: ColorResource.titleAppBarWhiteScreen,
                  fontWeight: FontWeight.w600)),
          Text(value,
              style: appStyle.textTheme.bodyText2
                  ?.copyWith(color: ColorResource.titleAppBarWhiteScreen))
        ],
      );

  Widget get textSetNameDeviceComp => Text(
        KeyLanguage.set_device_name.tr,
        style: appStyle.textTheme.bodyText1?.copyWith(
            color: ColorResource.primary, fontWeight: FontWeight.w600),
      );

  Widget get textFieldSetNameComp => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFieldComp(
          hint: 'Home - Phòng ngủ',
          padV: 6,
          padH: 0,
          fillColor: Colors.transparent,
          cursorColor: ColorResource.tabIndicator,
          borderColor: ColorResource.tabIndicator,
          style: appStyle.textTheme.bodyText2
              ?.copyWith(color: ColorResource.tabIndicator),
          hintStyle: appStyle.textTheme.bodyText2
              ?.copyWith(color: ColorResource.tabIndicator),
          isUnderLine: true,
          colorUnderLine: ColorResource.tabIndicator,
        ),
      );
}
