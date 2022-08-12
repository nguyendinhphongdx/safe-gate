// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/screen/device/device_controller.dart';
import 'package:base_pm2/screen/widget/device/comp/icon_device_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemMDComp extends GetView<DeviceController> {
  final DeviceModel? deviceModel;
  final ProfileModel? profileModel;

  const ItemMDComp({Key? key, required this.deviceModel, this.profileModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 16), height: 0.5, color: Colors.white.withOpacity(0.5)),
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 16, 12, 12),
          child: IntrinsicHeight(
            child: Row(
              children: [
                SizedBox(width: 36),
                itemDeviceType,
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getNameDevice(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: appStyle.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${KeyLanguage.used.tr}: ${deviceModel?.spentTime ?? 0} giờ',
                        style: appStyle.textTheme.subtitle1,
                      ),
                      Text(
                        'MAC: ${deviceModel?.macAddress ?? 0}',
                        style: appStyle.textTheme.subtitle1,
                      )
                    ],
                  ),
                ),
                buttonStop
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget get itemDeviceType => Stack(
        children: [
          const Padding(padding: EdgeInsets.all(6.0), child: IconDeviceType(deviceType: -1)),
          // Positioned(
          //   right: 0,
          //   top: 0,
          //   child: Container(
          //     decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(500)),
          //     width: 14,
          //     height: 14,
          //     child: const Center(
          //         child: Text(
          //           '5',
          //           style: TextStyle(fontSize: 8, height: 1),
          //         )),
          //   ),
          // )
        ],
      );

  String _getNameDevice() {
    if (deviceModel?.deviceNameAlias == null) {
      return deviceModel?.deviceInfo?.vendor ?? deviceModel?.macAddress ?? '';
    }
    if (deviceModel?.deviceNameAlias == '*') {
      return deviceModel?.deviceInfo?.vendor ?? deviceModel?.macAddress ?? '';
    }
    return deviceModel?.deviceNameAlias ?? deviceModel?.deviceInfo?.vendor ?? deviceModel?.macAddress ?? '';
  }

  Widget get buttonStop => InkWellComp(
        paddingAll: 0,
        child: const ImageViewer(
          (UserDeviceStatus.CONNECT == UserDeviceStatus.CONNECT)
              ? ImageResource.ic_pause_png
              : ImageResource.ic_play,
          width: 33,
          height: 33,
        ),
        onTap: () => controller.onConnectDevice(deviceModel),
      );
}
