import 'package:base_pm2/screen/widget/user_detail_setting/comp/item_ud_setting_comp.dart';
import 'package:base_pm2/screen/widget/user_detail_setting/user_detail_setting_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UDSettingMediumLayout extends GetView<UserDetailSettingController> {
  const UDSettingMediumLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8),

        padding: const EdgeInsets.symmetric(vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            children: controller.listData.mapIndexed<Widget>(_itemBuilder).toList(),
          ),
        ));
  }

  Widget _itemBuilder(int index, UserDetailSettingModel element) {
    return ItemUDSettingComp(userDetailSettingModel: element, index: index,length: controller.listData.length -1,);
  }
}
