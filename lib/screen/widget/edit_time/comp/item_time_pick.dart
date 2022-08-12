import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/dialog/custom_pop_up_menu_button.dart';
import 'package:base_pm2/common/helper/date_time_utils.dart';
import 'package:base_pm2/common/helper/view_utils.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/screen/widget/edit_time/edit_time_controller.dart';
import 'package:base_pm2/screen/widget/filter_access/comp/item_config_time.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemTimePick extends GetView<EditTimeController> {
  const ItemTimePick({this.timeModel, this.onDelete, this.application, Key? key}) : super(key: key);
  final RuleAppModel? timeModel;
  final Function()? onDelete;
  final ApplicationModel? application;

  @override
  Widget build(BuildContext context) {
    showLog(timeModel?.startTime?.value);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWellComp(
          onTap: () => controller.onChangeStartTime(timeModel),
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Obx(
            () => Text(
              timeModel?.startTime?.value ?? '',
              style: appStyle.textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: timeModel?.isActiveStart?.value ?? false
                      ? ColorResource.primary
                      : ColorResource.tabIndicator),
            ),
          ),
        ),
        SizedBox(
            width: 0,
            child: CustomPopupMenuButton<String>(
              key: timeModel?.startKey,
              onSelected: (v) => controller.onSelectedStartTime(v, timeModel, application),
              onCanceled: () => controller.onCancelStartTime(timeModel),
              itemBuilder: _buildTimeMenu,
              offset: const Offset(0, -50),
              height: ViewUtils.height * 0.5,
              child: const SizedBox(),
            )),
        const SizedBox(width: 12),
         ImageViewer(
          ImageResource.ic_arrow_right_2,
          width: 39,
          color: ColorResource.tabIndicator.withOpacity(.4),
        ),
        const SizedBox(width: 12),
        InkWellComp(
          onTap: () => controller.onChangeEndTime(timeModel),
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Obx(
            () => Text(
              timeModel?.endTime?.value ?? '',
              style: appStyle.textTheme.bodyText1?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: timeModel?.isActiveEnd?.value ?? false
                      ? ColorResource.primary
                      : ColorResource.tabIndicator),
            ),
          ),
        ),
        SizedBox(
            width: 0,
            child: CustomPopupMenuButton<String>(
              key: timeModel?.endKey,
              onSelected: (v) => controller.onSelectedEndTime(v, timeModel, application),
              onCanceled: () => controller.onCancelEndTime(timeModel),
              itemBuilder: _buildTimeMenu,
              height: ViewUtils.height * 0.5,
              offset: const Offset(0, -50),
              child: const SizedBox(),
            )),
      ],
    );
  }

  Widget _buildItem(int index, AppDayModel element) {
    return Obx(() => ItemDayInfo(
          title: element.title,
          isActive: element.isActive?.value,
          onActive: () => controller.onDayChangeStatus(element, application),
        ));
  }

  List<PopupMenuEntry<String>> _buildTimeMenu(BuildContext context) {
    DateTime dateTime = DateTimeUtils.custom(mHour: 0, mMinute: 0);
    return List.generate(48, (index) {
      return PopupMenuItem(
        height: 28,
        value: '${DateTimeUtils.format(dateTime.add(Duration(minutes: index * 30)), DateTimeUtils.HHMM)}',
        child: Text(
          '${DateTimeUtils.format(dateTime.add(Duration(minutes: index * 30)), DateTimeUtils.HHMM)}',
          style: appStyle.textTheme.bodyText2?.copyWith(color: Colors.black.withOpacity(.5),fontWeight: FontWeight.w500),
        ),
      );
    });
  }

  String textMapper(int i) {
    if (i < 10) return '0$i';
    return '$i';
  }
}
