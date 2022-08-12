import 'package:base_pm2/common/core/widget/image/image_viewer.dart';
import 'package:base_pm2/common/core/widget/layout/ink_well_comp.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/screen/widget/filter_access/comp/item_time_infomation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:collection/collection.dart';

class AppConfigComp extends StatelessWidget {
  const AppConfigComp(
      {Key? key, this.currentTime, this.onDelete, this.onGenerateItemTime, this.onAddTime, this.application, this.onEditTime})
      : super(key: key);
  final RxList<RuleAppModel>? currentTime;
  final Function(RuleAppModel timeModel)? onDelete;
  final Function(RuleAppModel timeModel)? onEditTime;
  final Function()? onGenerateItemTime;
  final Function()? onAddTime;
  final ApplicationModel? application;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Obx(() => Column(children: currentTime?.mapIndexed<Widget>(_buildItem).toList() ?? [])),
        InkWellComp(
            child: const ImageViewer(ImageResource.ic_add_circle, width: 22, height: 22), onTap: onAddTime)
      ],
    );
  }

  Widget _buildItem(int index, RuleAppModel element) {
    return InkWell(
      onLongPress:()=> onEditTime?.call(element),
      child: ItemTimeInfomation(
          timeModel: element, onDelete: () => onDelete?.call(element), application: application),
    );
  }
}
