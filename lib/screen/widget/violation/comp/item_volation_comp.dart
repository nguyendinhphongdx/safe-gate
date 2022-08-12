import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/layout/empty_view.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:base_pm2/data/model/widget/app/app_access_model.dart';
import 'package:base_pm2/screen/profile/user_detail_history/violations/violations_controller.dart';
import 'package:base_pm2/screen/widget/violation/comp/item_colapse_comp.dart';
import 'package:base_pm2/screen/widget/violation/comp/item_violation_detail.dart';
import 'package:base_pm2/screen/widget/violation/violation_controller.dart';
import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemViolationComp extends GetView<ViolationController> {
  const ItemViolationComp({Key? key, this.violation}) : super(key: key);
  final ViolationHeaderData? violation;

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      controller: violation?.expandableController,
      expanded: ExpandableButton(
        child: Column(
          children: [
            ItemCollapseComp(violation: violation, isExpanded: true),
            !Utils.isNotNullAndEmpty(violation?.accessParentModel?.appAccessParentRetail)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: EmptyView(),
                  )
                : Container(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 12),
                        const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: ImageViewer(
                              ImageResource.ic_alert_red,
                              width: 22,
                              height: 22,
                            )),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Vi phạm quy định sử dụng Internet',
                                style: appStyle.textTheme.bodyText1,
                              ),
                              // const SizedBox(height: 8),
                              Column(
                                  children: violation?.accessParentModel?.appAccessParentRetail
                                          ?.mapIndexed<Widget>(_buildItem2)
                                          .toList() ??
                                      [])
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
      collapsed: InkWellComp(
          onTap: () => violation?.onExpandedClick(controller.violationHeadersAll),
          paddingAll: 0,
          child: ItemCollapseComp(violation: violation)),
    );
  }

  Widget _buildItem2(int index, AppAccessParentModel element) {
    return ItemViolationDesc(
      detail: element,
      time: element.date,
    );
  }
}
