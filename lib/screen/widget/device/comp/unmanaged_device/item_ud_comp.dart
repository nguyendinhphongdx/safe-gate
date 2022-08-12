import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/screen/device/device_controller.dart';
import 'package:base_pm2/screen/widget/device/comp/icon_device_type.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemUDComp extends GetWidget<DeviceController> {
  final DeviceModel? deviceModel;

  const ItemUDComp({Key? key, this.deviceModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadiusDirectional.circular(12),
        ),
        child: ExpandablePanel(
          collapsed: ExpandableButton(child: headerComp()),
          expanded: expandedComp,
          theme:
              const ExpandableThemeData(iconColor: Colors.red, hasIcon: false),
        ),
      ),
    );
  }

  Widget headerComp({bool? isHeader}) => Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 10),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: IconDeviceType(deviceType: -1)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getNameDevice(),
                      style: appStyle.textTheme.bodyText1
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text(
                        '${KeyLanguage.connect_time.tr} ${DateTimeUtils.intToFormat(deviceModel?.createdTime, DateTimeUtils.HM_DDMMYYYY) ?? '16:40 15/03/2022'} ',
                        style: appStyle.textTheme.subtitle1),
                  ],
                ),
              ),
              ImageViewer(isHeader ?? false
                  ? ImageResource.ic_arrow_up
                  : ImageResource.ic_arrow_down),
            ],
          ),
        ),
      );

  String _getNameDevice() {
    if (deviceModel?.deviceNameAlias == null) {
      return deviceModel?.deviceInfo?.vendor ?? deviceModel?.macAddress ?? '';
    }
    if (deviceModel?.deviceNameAlias == '*') {
      return deviceModel?.deviceInfo?.vendor ?? deviceModel?.macAddress ?? '';
    }
    return deviceModel?.deviceNameAlias ??
        deviceModel?.deviceInfo?.vendor ??
        deviceModel?.macAddress ??
        '';
  }

  Widget get expandedComp => ExpandableButton(
        child: Column(
          children: [
            headerComp(isHeader: true),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButtonComp(
                      title: KeyLanguage.add.tr,
                      style: appStyle.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w500),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                      onPressed: () => controller.showDialogAddDevice(deviceModel),
                      primaryColor: ColorResource.blueButton,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButtonComp(
                      title: KeyLanguage.deny.tr,
                      style: appStyle.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w500),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                      onPressed: () => controller.onDenyDevice(deviceModel),
                      primaryColor: ColorResource.orangeButton,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
