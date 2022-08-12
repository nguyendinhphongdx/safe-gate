import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemAddWeb extends StatelessWidget {
  const ItemAddWeb({Key? key, this.onAddPress}) : super(key: key);
  final Function()? onAddPress;

  @override
  Widget build(BuildContext context) {
    return InkWellComp(
      onTap: onAddPress ?? () => Get.toNamed(RoutePath.ADD_APPLICATION),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: const [
          Expanded(child: SizedBox()),
          ImageViewer(ImageResource.ic_add_circle),
        ],
      ),
    );
  }
}
