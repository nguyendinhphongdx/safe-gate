import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/profile/user_detail_history/violations/time_line_violation_comp.dart';
import 'package:base_pm2/screen/profile/user_detail_history/violations/violations_controller.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViolationsPage extends GetWidget<ViolationsController> {
  ViolationsPage({String? historyType, Key? key}) : super(key: key) {
    Get.lazyPut(() => ViolationsController());
  }

  Widget? detail;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _itemBuilder,
      itemCount: controller.violationHeaders.length,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    ViolationHeaderData headerData = controller.violationHeaders[index];
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Visibility(
          //     visible: index != 0,
          //     child: Container(width: ViewUtils.width, height: 0.5, color: Colors.white)),
          // const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.5, color: Colors.white.withOpacity(.5)))),
            child: ExpandablePanel(
              controller: headerData.expandableController,
              collapsed: InkWellComp(
                onTap: ()=> headerData.onExpandedClick(controller.violationHeaders),
                paddingAll: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  child: Row(
                    children: [
                      Text(headerData.title ?? '', style: appStyle.textTheme.bodyText1),
                      const Expanded(child: SizedBox()),
                      const ImageViewer(ImageResource.ic_arrow_down, width: 12, height: 12)
                    ],
                  ),
                ),
              ),
              expanded: Column(
                children: [
                  ExpandableButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Row(
                        children: [
                          Expanded(child: Text(headerData.title ?? '', style: appStyle.textTheme.bodyText1)),
                          const SizedBox(width: 16),
                          const ImageViewer(ImageResource.ic_arrow_up, width: 12, height: 12)
                        ],
                      ),
                    ),
                  ),
                  Obx(() => headerData.isExpanded?.value ?? false
                      ? TimeLineViolationComp(violationData: headerData)
                      : const SizedBox()),
                ],
              ),
              theme: const ExpandableThemeData(
                hasIcon: false,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
