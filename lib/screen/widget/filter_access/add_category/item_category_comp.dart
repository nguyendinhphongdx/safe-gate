import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/core/widget/button/cupertino_swtich_comp.dart';
import 'package:base_pm2/common/core/widget/layout/ink_well_comp.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/data/model/widget/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemCategoryComp extends StatelessWidget {
  const ItemCategoryComp({Key? key, this.categoryModel, this.onChangeStatus}) : super(key: key);
  final CategoryModel? categoryModel;
  final Function()? onChangeStatus;

  @override
  Widget build(BuildContext context) {
    return InkWellComp(
      onTap: onChangeStatus,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                categoryModel?.categoryName ?? '',
                maxLines: 1,
                style: appStyle.textTheme.bodyText1
                    ?.copyWith(fontWeight: FontWeight.w600, color: ColorResource.tabIndicator),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                categoryModel?.categoryInfo ?? '',
                maxLines: 1,
                style: appStyle.textTheme.subtitle1?.copyWith(color: ColorResource.tabIndicator),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Obx(() => CupertinoSwitchComp(
            value: categoryModel?.isActive?.value, onChanged: (v) => onChangeStatus?.call()))
      ]),
    );
  }
}
