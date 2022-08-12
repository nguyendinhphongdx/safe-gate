import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:base_pm2/common/resource/keylanguage_resource/key_language.dart';
import 'package:base_pm2/screen/overview/overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverHeader extends GetView<OverViewController> {
  const OverHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: Row(
            children: [
              ImageViewer(
                'https://vienthammydiva.vn/wp-content/uploads/2022/05/avatar-dep-ngau-nu.jpg',
                borderColor: Colors.white,
                fit: BoxFit.cover,
                width: 32,
                height: 32,
                borderRadius: BorderRadius.circular(100),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        Expanded(
          child: Text(
            KeyLanguage.overview.tr,
            style: appStyle.textTheme.bodyText1
                ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWellComp(
              onTap: () => Get.toNamed(RoutePath.NOTIFICATIONS),
              borderRadiusAll: 100,
              padding: const EdgeInsets.all(6),
              child: const SvgComp(
                url: ImageResource.ic_bell,
                color: Colors.white,
                width: 20,
                height: 20,
              ),
            ),
            InkWellComp(
              onTap: controller.onDeviceConfig,
              padding: const EdgeInsets.all(6),
              borderRadiusAll: 100,
              child: const SvgComp(
                url: ImageResource.ic_construction,
                color: Colors.white,
                width: 20,
                height: 20,
              ),
            ),
            InkWellComp(
              onTap: controller.onSupport,
              padding: const EdgeInsets.all(6),
              borderRadiusAll: 100,
              child: const SvgComp(
                url: ImageResource.ic_support,
                color: Colors.white,
                width: 20,
                height: 20,
              ),
            ),

          ],
        )) , const SizedBox(width: 12)
      ],
    );
  }
}
