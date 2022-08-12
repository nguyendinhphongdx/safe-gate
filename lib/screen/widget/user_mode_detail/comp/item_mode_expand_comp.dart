import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/mode_model.dart';
import 'package:base_pm2/screen/widget/user_mode_detail/comp/item_mode_desc.dart';
import 'package:base_pm2/screen/widget/user_mode_list/comp/item_mode_comp.dart';
import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ItemModeExpandComp extends StatelessWidget {
  const ItemModeExpandComp({Key? key, this.mode}) : super(key: key);
  final ModeModel? mode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.black.withOpacity(0.2)),
      child: ExpandablePanel(
        collapsed: ExpandableButton(
            child: ItemModeComp(mode: mode, icon: ImageResource.ic_arrow_down),
            theme: ExpandableThemeData(inkWellBorderRadius: BorderRadius.circular(12))),
        expanded: ExpandableButton(
          theme: ExpandableThemeData(inkWellBorderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              ItemModeComp(mode: mode, icon: ImageResource.ic_arrow_down),
              const SizedBox(height: 4),
              Column(
                children: mode?.policies?.mapIndexed<Widget>(_buildItem).toList() ?? [],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index, String element) {
    return ItemModeDescription(title: element);
  }
}
