import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/constant.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/common/resource/keylanguage_resource/key_language.dart';
import 'package:base_pm2/data/model/widget/category_model.dart';
import 'package:base_pm2/screen/widget/filter_access/add_category/item_config_time_group.dart';
import 'package:base_pm2/screen/widget/filter_access/group/group_controller.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemGroupComp extends GetView<GroupController> {
  const ItemGroupComp({Key? key, this.model}) : super(key: key);
  final CategoryModel? model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpandablePanel(
          collapsed: ExpandableButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model?.categoryName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: appStyle.textTheme.bodyText1?.apply(color: Colors.white),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          model?.categoryInfo ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: appStyle.textTheme.subtitle1?.apply(color: Colors.white.withOpacity(.6)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  const ImageViewer(ImageResource.ic_arrow_down)
                ],
              ),
            ),
          ),
          expanded: Column(
            children: [
              ExpandableButton(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model?.categoryName ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: appStyle.textTheme.bodyText1?.apply(color: Colors.white),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              model?.categoryInfo ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: appStyle.textTheme.subtitle1?.apply(color: Colors.white.withOpacity(.5)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      const ImageViewer(ImageResource.ic_arrow_up)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  border: Border(
                    bottom: BorderSide(color: appStyle.dividerColor, width: 1.5),
                    top: BorderSide(color: appStyle.dividerColor, width: 1.5),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                              KeyLanguage.use_manager_mode.tr,
                              style: appStyle.textTheme.subtitle1,
                              maxLines: 1,
                            )),
                        InkWellComp(
                          paddingAll: 0,
                          onTap: () => controller.onOptionSelected(model),
                          child: Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(100)),
                            child: Row(
                              children: [
                                Obx(
                                      () => Text(_getText() ?? '',
                                      style: appStyle.textTheme.bodyText2?.apply(color: _getColor())),
                                ),
                                const SizedBox(width: 8),
                                const ImageViewer(ImageResource.ic_arrow_down)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 0,
                          height: 0,
                          child: PopupMenuButton<String>(
                            key: model?.popupKey,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            itemBuilder: _buildMenu,
                            offset: const Offset(0, 20),
                            onSelected: (v) => controller.onMenuSelected(v, model),
                          ),
                        ),
                      ],
                    ),
                    Obx(() => SizedBox(height: model?.rxType?.value == ModeType.LIMIT ? 0 : 8)),
                    Obx(
                          () => Visibility(
                        visible: !(model?.isTimeActive?.value ?? false) &&
                            (model?.rxType?.value == ModeType.LIMIT ||
                                model?.rxType?.value == ModeType.MONITOR),
                        child: ItemConfigTimeGroup(
                          application: model,
                          currentTime: model?.rxRuleModels,
                          onDelete: (value) => controller.onDeleteTime(value, model?.rxRuleModels,model),
                          onAddTime: () => controller.onAddTime(model?.rxRuleModels,model),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          )),
    );
  }

  List<PopupMenuEntry<String>> _buildMenu(BuildContext context) {
    return [
      PopupMenuItem(
          value: ModeType.UN_LIMIT,
          child: Text(
            KeyLanguage.unlimit.tr,
            style: appStyle.textTheme.bodyText2?.apply(color: ColorResource.primary),
          )),
      PopupMenuItem(
          value: ModeType.LIMIT,
          child: Text(
            KeyLanguage.limit.tr,
            style: appStyle.textTheme.bodyText2?.apply(color: Colors.red),
          )),
      PopupMenuItem(
          value: ModeType.MONITOR,
          child: Text(
            KeyLanguage.monitor.tr,
            style: appStyle.textTheme.bodyText2?.apply(color: Colors.black),
          )),
    ];
  }

  Color? _getColor() {
    switch (model?.rxType?.value) {
      case ModeType.LIMIT:
        return Colors.red;
      case ModeType.UN_LIMIT:
        return Colors.blue;
      case ModeType.MONITOR:
        return Colors.white;
    }
    return null;
  }

  String? _getText() {
    switch (model?.rxType?.value) {
      case ModeType.LIMIT:
        return KeyLanguage.limit.tr;
      case ModeType.UN_LIMIT:
        return KeyLanguage.unlimit.tr;
      case ModeType.MONITOR:
        return KeyLanguage.monitor.tr;
    }
    return null;
  }
}
