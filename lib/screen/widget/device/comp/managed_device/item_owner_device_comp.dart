import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/screen/device/device_controller.dart';
import 'package:base_pm2/screen/widget/device/comp/managed_device/item_md_comp.dart';
import 'package:base_pm2/screen/widget/device/comp/managed_device/item_owner_device.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemOwnerDeviceComp extends GetView<DeviceController> {
  final ProfileModel? profileModel;

  const ItemOwnerDeviceComp({Key? key, this.profileModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadiusDirectional.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ItemOwnerDevice(profileModel: profileModel),
          ),
          SizedBox(height: Utils.isNotNullAndEmpty(profileModel?.mEndUserDevices) ? 12 : 0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: _itemBuilder,
            itemCount: profileModel?.mEndUserDevices?.length ?? 0,
          ),
        ],
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    DeviceModel? deviceModel = profileModel?.mEndUserDevices?[index];
    return ItemMDComp(deviceModel: deviceModel, profileModel: profileModel);
  }
}
