import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/core/widget/button/cupertino_swtich_comp.dart';
import 'package:base_pm2/common/core/widget/layout/ink_well_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/screen/widget/device/comp/icon_device_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDeviceComp extends StatelessWidget {
  const ItemDeviceComp({Key? key, this.deviceModel, this.onChangeStatus, this.textColor}) : super(key: key);
  final DeviceModel? deviceModel;
  final Function()? onChangeStatus;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWellComp(
        onTap: onChangeStatus,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const IconDeviceType(deviceType: -1),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          _getNameDevice(),
                          style: appStyle.textTheme.bodyText1
                              ?.copyWith(color: textColor, fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Obx(
                        () => CupertinoSwitchComp(
                            value: deviceModel?.rxStatus?.value,
                            onChanged: (value) => onChangeStatus?.call()),
                      )
                    ],
                  ),
                  Text(
                    '${KeyLanguage.connect_time_full.tr}: ${DateTimeUtils.intToFormat(deviceModel?.createdTime, DateTimeUtils.HM_DDMMYYYY) ?? ''}',
                    style: appStyle.textTheme.bodyText2
                        ?.apply(color: (textColor ?? Colors.white).withOpacity(0.6)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'MAC: ${deviceModel?.macAddress}',
                    style: appStyle.textTheme.bodyText2
                        ?.apply(color: (textColor ?? Colors.white).withOpacity(0.6)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//TODO hoi them xewm nhu nao
  String _getNameDevice() {
    if (deviceModel?.deviceInfo?.vendor != null) {
      return deviceModel!.deviceInfo!.vendor!.toString();
    }
    if (deviceModel?.deviceNameAlias == '*') return deviceModel?.macAddress ?? '';
    return deviceModel?.deviceInfo?.vendor ?? deviceModel?.macAddress ?? '';
  }
}
