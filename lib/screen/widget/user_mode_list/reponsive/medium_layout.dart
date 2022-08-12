import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:base_pm2/data/model/mode_model.dart';
import 'package:base_pm2/screen/widget/user_mode_list/comp/item_mode_comp.dart';
import 'package:base_pm2/screen/widget/user_mode_list/user_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediumLayout extends GetView<UserModeController> {
  const MediumLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: SizedBox()),
            InkWellComp(onTap: controller.addMode, child: const SvgComp(url: ImageResource.ic_add_circle)),
            InkWellComp(onTap: () {}, child: const SvgComp(url: ImageResource.ic_search)),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.black.withOpacity(0.2)),
          child: Obx(
            () => ListView.builder(
              itemBuilder: _buildItem,
              // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              itemCount: controller.mModes.length,
              shrinkWrap: true,
              itemExtent: 80,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    ModeModel model = controller.mModes[index];
    return ItemModeComp(
      mode: model,
      onModePress: (mode) => controller.onEditMode(mode),
    );
  }
}
