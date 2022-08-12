import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/screen/widget/filter_access/app_web/app_web_controller.dart';
import 'package:base_pm2/screen/widget/filter_access/app_web/item_add_web.dart';
import 'package:base_pm2/screen/widget/filter_access/comp/item_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppWebTab extends GetWidget<AppWebController> {
  AppWebTab({Key? key}) : super(key: key) {
    Get.lazyPut(() => AppWebController());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: _buildItem,
        itemCount: controller.mApps.length + 1,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index == 0) return const ItemAddWeb();
    ApplicationModel? model = controller.mApps[index - 1];
    return ItemFilter(model: model, onActiveChange: () => controller.onActiveChange(model));
  }

}
