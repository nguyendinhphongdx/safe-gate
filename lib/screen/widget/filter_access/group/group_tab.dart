import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/data/model/widget/category_model.dart';
import 'package:base_pm2/screen/widget/filter_access/app_web/item_add_web.dart';
import 'package:base_pm2/screen/widget/filter_access/group/comp/item_group_comp.dart';
import 'package:base_pm2/screen/widget/filter_access/group/group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupTab extends GetWidget<GroupController> {
  GroupTab({Key? key}) : super(key: key) {
    Get.lazyPut(() => GroupController());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: _buildItem,
        itemCount: controller.mGroupApps.length + 1,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index == 0) {
      return ItemAddWeb(onAddPress: () => Get.toNamed(RoutePath.ADD_CATEGORY));
    }
    CategoryModel? categoryModel = controller.mGroupApps[index-1];
    return ItemGroupComp(model: categoryModel);
  }
}
