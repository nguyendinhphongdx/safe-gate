import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportHeaderComp extends StatelessWidget {
  const ReportHeaderComp({Key? key}) : super(key: key);

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
                width: 32,
                fit: BoxFit.cover,
                height: 32,
                borderRadius: BorderRadius.circular(100),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        // const SizedBox(width: 2),
        Expanded(
            child: Text(
          KeyLanguage.report.tr,
          style: appStyle.textTheme.bodyText1?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        )),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWellComp(
                paddingAll: 4,
                borderRadius: BorderRadius.circular(100),
                child: const SvgComp(
                  url: ImageResource.ic_instruction,
                  width: 22,
                  height: 22,
                ),
                onTap: () => Get.toNamed(RoutePath.SEARCH_DEVICE)),
            InkWellComp(
                paddingAll: 4,
                borderRadius: BorderRadius.circular(100),
                child: const SvgComp(
                  url: ImageResource.ic_support,
                  width: 22,
                  height: 22,
                ),
                onTap: () => ViewUtils.openUrl('https://zalo.me/pc')),
          ],
        )),
        const SizedBox(width: 12)
      ],
    );
  }
}
