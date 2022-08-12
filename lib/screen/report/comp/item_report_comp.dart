import 'package:base_pm2/common/core/interface/i_report_listener.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/screen/overview/overview_controller.dart';
import 'package:base_pm2/screen/widget/items/item_status_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemReportComp<T extends IReportListener> extends GetView<T> {
  const ItemReportComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Row(
        children: controller.mStatuses.mapIndexed(_buildItem).toList(),
      ),
    );
  }

  Widget _buildItem(int index, ItemStatus status) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: index == 0 ? 8 : 0,left: index == 1 ? 8 : 0),
        child: ItemStatusView(
          status,
          onItemPressed: () => controller.onItemPress(status),
        ),
      ),
    );
  }
}
