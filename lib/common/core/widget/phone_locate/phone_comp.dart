import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneLocateComp extends StatefulWidget {
  const PhoneLocateComp({Key? key, String? value}) : super(key: key);

  @override
  State<PhoneLocateComp> createState() => _PhoneLocateCompState();
}

class _PhoneLocateCompState extends State<PhoneLocateComp> {
  @override
  Widget build(BuildContext context) {
    return DropdownComp(
      onChange: (value) {},
      suffixIcon: Container(),
      listItems: [
        BaseOptionDropdown(
          data: KeyLanguage.valueNotEmail.tr,
          name: KeyLanguage.valueNotEmail.tr,
        ),
        BaseOptionDropdown(data: KeyLanguage.valueNotEmail.tr),
        BaseOptionDropdown(data: KeyLanguage.valueNotEmail.tr),
      ],
      filled: true,
      bgSelection: ColorResource.bgphoneLocate,
    );
  }
}
