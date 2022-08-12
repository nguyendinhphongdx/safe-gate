import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/widget/time_table/comp/list_time_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemTimeComp extends StatelessWidget {
  const ItemTimeComp(
      {Key? key,
      this.timeModel,
      this.onChangePress,
      this.size,
      this.activeColor,
      this.inActiveColor,
      this.activeTextColor,
      this.inActiveTextColor})
      : super(key: key);

  final TimeModel? timeModel;
  final Function()? onChangePress;
  final double? size;
  final Color? activeColor;
  final Color? inActiveColor;
  final Color? activeTextColor;
  final Color? inActiveTextColor;

  @override
  Widget build(BuildContext context) {
    return InkWellComp(
      borderRadiusAll: 100,
      onTap: onChangePress,
      paddingAll: 4,
      child: Container(
        decoration: BoxDecoration(color: _getColor(), borderRadius: BorderRadius.circular(100)),
        alignment: Alignment.center,
        width: Get.width/9,height: Get.width/9,
        child: FittedBox(
          child: Text(
            timeModel?.title ?? '',
            style: appStyle.textTheme.headline5?.apply(color: _getTextColor()),
          ),
        ),
      ),
    );
  }

  Color? _getColor() {
    if (inActiveColor != null || activeColor != null) {
      return timeModel?.isActive == true ? activeColor : inActiveColor;
    }

    return Colors.white.withOpacity(timeModel?.isActive == true ? 1 : 0.5);
  }

  Color? _getTextColor() {
    if (inActiveColor != null || activeColor != null) {
      return timeModel?.isActive == true ? activeTextColor : inActiveTextColor;
    }

    return timeModel?.isActive == true ? ColorResource.primary : null;
  }
}
