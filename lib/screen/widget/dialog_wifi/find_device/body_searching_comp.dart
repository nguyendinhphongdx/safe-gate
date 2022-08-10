import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class BodySearchingComp extends StatelessWidget {
  const BodySearchingComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [loadingComp, const SizedBox(height: 6), textFindDeviceComp],
    );
  }

  Widget get loadingComp => const SpinKitFadingCircle(color: ColorResource.primary, size: 46);

  Widget get textFindDeviceComp => Text(
    '${KeyLanguage.network_scanning.tr}...',
    style: appStyle.textTheme.bodyText2?.copyWith(color: ColorResource.titleAppBarWhiteScreen),
  );
}
