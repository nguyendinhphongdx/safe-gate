import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/widget/user_detail_setting/user_detail_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemUDSettingComp extends GetView<UserDetailSettingController> {
  final UserDetailSettingModel userDetailSettingModel;
  final int index;
  final int? length;

  const ItemUDSettingComp({Key? key, required this.userDetailSettingModel, required this.index, this.length})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(index == 0 ? 12 : 0),
              topRight: Radius.circular(index == 0 ? 12 : 0),
              bottomLeft: Radius.circular(index == length ? 12 : 0),
              bottomRight: Radius.circular(index == length ? 12 : 0))),
      child: Column(
        children: [
          SizedBox(height: index == 0 ? 0 : 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: TextButtonComp(
              isTransparent: true,
              onPressed: () => controller.openPage(index),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    iconComp,
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleComp,
                          const SizedBox(height: 8),
                          subTitleComp,
                        ],
                      ),
                    ),
                    statusComp,
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget get iconComp => SvgComp(
        url: userDetailSettingModel.icon,
        width: 20,
        height: 20,
      );

  Widget get titleComp => Row(
        children: [
          Expanded(
            child: Text(
              userDetailSettingModel.title,
              style: appStyle.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const ImageViewer(
            ImageResource.ic_arrow_right,
            width: 12,
            height: 12,
          )
        ],
      );

  Widget get subTitleComp => Obx(
        () => Visibility(
          visible: userDetailSettingModel.subTitle?.value != null &&
              userDetailSettingModel.subTitle?.value.length != 0,
          child: Text(
            userDetailSettingModel.subTitle?.value ?? '',
            style: appStyle.textTheme.subtitle1?.copyWith(color: Colors.white.withOpacity(0.6)),
          ),
        ),
      );

  Widget get statusComp => Visibility(
        visible: userDetailSettingModel.status != null,
        child: Text(
          userDetailSettingModel.status ?? '',
          style: appStyle.textTheme.bodyText2?.copyWith(
            color: userDetailSettingModel.status == 'Đang bật' ? ColorResource.on : ColorResource.off,
          ),
        ),
      );
}
