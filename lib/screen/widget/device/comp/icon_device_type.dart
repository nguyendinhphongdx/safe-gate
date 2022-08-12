import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/device/device_controller.dart';
import 'package:flutter/material.dart';

class IconDeviceType extends StatelessWidget {
  final int? deviceType;
  final Color? color;

  const IconDeviceType({Key? key, this.deviceType, this.color })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 32,
      height: 32,
      child: SvgComp(
        url: ImageResource.ic_phone,
        color: color,
      ),
    );
   /* switch (deviceType) {
      case DeviceType.phone:
        return const SizedBox(
          width: 24,
          height: 24,
          child: SvgComp(
            url: ImageResource.ic_phone,
          ),
        );
      case DeviceType.laptop:
        return const SizedBox(
          width: 24,
          height: 24,
          child: SvgComp(
            url: ImageResource.ic_laptop,
          ),
        );
      case DeviceType.desktop:
        return Container(
          width: 24,
          height: 24,
          child: const SvgComp(
            url: ImageResource.ic_desktop,
          ),
        );
      default:
        return Container();
    }*/
  }
}
