import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/profile/user_detail_history/violations/violations_controller.dart';
import 'package:base_pm2/screen/widget/violation/comp/item_volation_comp.dart';
import 'package:base_pm2/screen/widget/violation/violation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediumLayout extends GetView<ViolationController> {
  const MediumLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: _buildItem,
        itemCount: controller.violationHeadersAll.length,
        separatorBuilder: _buildSeparate,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    ViolationHeaderData violation = controller.violationHeadersAll[index];
    return ItemViolationComp(violation: violation);
  }

  Widget _buildSeparate(BuildContext context, int index) {
    return Container(width: double.infinity,height: 1,color: ColorResource.divider);
  }
}
