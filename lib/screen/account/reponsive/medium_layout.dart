import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/avatar/avatar_pick_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/constant.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/account/account_controller.dart';
import 'package:base_pm2/screen/account/comp/item_account_comp.dart';
import 'package:base_pm2/screen/otp/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediumLayout extends GetView<AccountController> {
  const MediumLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const PickAvatarComp(
            isPick: true,
            imageSize: Size(136, 136),
            iconSize: Size(28, 28),
            editPosition: Offset(4, 4),
            inkwellPadding: EdgeInsets.zero,
            name: 'Con gái',
          ),
          const SizedBox(height: 20),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 1,
              width: double.infinity,
              color: ColorResource.divider),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: _buildItem,
              separatorBuilder: _buildSeperate,
              itemCount: 6)
        ],
      ),
    );
  }

  Widget _buildSeperate(BuildContext context, int index) {
    return Container(color: appStyle.dividerColor, width: double.infinity, height: 1);
  }

  Widget _buildItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        return ItemAccountComp(
          imageUrl: ImageResource.ic_person,
          title: KeyLanguage.my_info.tr,
          onPressed: () => Get.toNamed(RoutePath.PROFILE),
        );
      case 1:
        return ItemAccountComp(
          imageUrl: ImageResource.ic_setting,
          title: KeyLanguage.app_config.tr,
          onPressed: () => Get.toNamed(RoutePath.NOTIFICATION_CONFIG),
        );

      case 2:  return ItemAccountComp(
        imageUrl: ImageResource.ic_locker,
        title: KeyLanguage.change_password.tr,
        onPressed: () async {
          Get.toNamed(RoutePath.OTP,
              parameters: OtpArgs(otpType: OtpType.OTP_RESET_PASSWORD, phoneNumber: '0943574556').toJson());
        },
      );


      case 3:
        return ItemAccountComp(
          imageUrl: ImageResource.ic_version_info,
          title: KeyLanguage.version_info.tr,
          onPressed: () => Get.toNamed(RoutePath.VERSION),
        );
      case 4:
        return ItemAccountComp(
          imageUrl: ImageResource.ic_logout,
          onPressed: controller.logout,
          title: KeyLanguage.logout.tr,
        );
    }
    return const SizedBox();
  }
}
