import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/core/widget/button/elevated_button_comp.dart';
import 'package:base_pm2/common/core/widget/image/image_viewer.dart';
import 'package:base_pm2/common/helper/constant.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:base_pm2/common/resource/keylanguage_resource/key_language.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/screen/device/device_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemOwnerDevice extends GetView<DeviceController> {
  const ItemOwnerDevice({this.profileModel, Key? key}) : super(key: key);
  final ProfileModel? profileModel;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageViewer(
            Utils.concatImageLink(profileModel?.profileAvatar) ?? ImageResource.ic_account,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(500),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        profileModel?.profileName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: appStyle.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),border: Border.all(color: Colors.white)),

                      child: ElevatedButtonComp(
                        onPressed: () => controller.onConnectAllDevice(profileModel: profileModel),
                        style: appStyle.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w500),
                        heightValue: 28,
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                        title: UserDeviceStatus.CONNECT == UserDeviceStatus.CONNECT
                            ? KeyLanguage.pause.tr
                            : KeyLanguage.connect.tr,
                        primaryColor: UserDeviceStatus.CONNECT == UserDeviceStatus.CONNECT
                            ? ColorResource.orangeButton
                            : ColorResource.blueButton,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${KeyLanguage.violation_of_the_day.tr}: ${profileModel?.violateCount ?? 0}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: appStyle.textTheme.subtitle1?.apply(color: Colors.white.withOpacity(0.6)),
                ),
                Text(
                  '${KeyLanguage.connecting.tr}: ${profileModel?.deviceConnecting ?? 0} thiết bị',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: appStyle.textTheme.subtitle1?.apply(color: Colors.white.withOpacity(0.6)),
                ),
                const SizedBox(height: 12),
                Text(
                  '${KeyLanguage.total_number_of_devices.tr}: ${profileModel?.mEndUserDevices?.length ?? 0}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: appStyle.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
