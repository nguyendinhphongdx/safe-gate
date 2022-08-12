import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/dialog/custom_pop_up_menu_button.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/screen/widget/filter_access/app_web/app_web_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemConfigTime extends GetView<AppWebController> {
  const ItemConfigTime(
      {this.application, Key? key, this.currentTime, this.onDelete, this.onGenerateItemTime, this.onAddTime})
      : super(key: key);
  final RxList<RuleAppModel>? currentTime;
  final Function(RuleAppModel timeModel)? onDelete;
  final Function()? onGenerateItemTime;
  final Function()? onAddTime;
  final ApplicationModel? application;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        Obx(() => Column(children: currentTime?.mapIndexed<Widget>(_buildItem).toList() ?? [])),
        InkWellComp(
            child: const ImageViewer(ImageResource.ic_add_circle, width: 22, height: 22), onTap: onAddTime)
      ],
    );
  }

  Widget _buildItem(int index, RuleAppModel element) {
    return ItemTimeInfo(
        timeModel: element, onDelete: () => onDelete?.call(element), application: application);
  }
}

class ItemTimeInfo extends GetView<AppWebController> {
  const ItemTimeInfo({this.application, Key? key, this.timeModel, this.onDelete}) : super(key: key);
  final RuleAppModel? timeModel;
  final Function()? onDelete;
  final ApplicationModel? application;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(.5))),
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWellComp(
                onTap: () => controller.onChangeStartTime(timeModel),
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Obx(
                  () => Text(
                    timeModel?.startTime?.value ?? '',
                    style: appStyle.textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w600,
                        color:
                            timeModel?.isActiveStart?.value ?? false ? ColorResource.primary : Colors.white),
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
                    height: ViewUtils.height * 0.3,
                    child: const SizedBox(),
                  )),
              const SizedBox(width: 12),
              const ImageViewer(ImageResource.ic_arrow_right_2),
              const SizedBox(width: 12),
              InkWellComp(
                onTap: () => controller.onChangeEndTime(timeModel),
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Obx(
                  () => Text(
                    timeModel?.endTime?.value ?? '',
                    style: appStyle.textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: timeModel?.isActiveEnd?.value ?? false ? ColorResource.primary : Colors.white),
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
                    height: ViewUtils.height * 0.3,
                    offset: const Offset(0, -50),
                    child: const SizedBox(),
                  )),
              const Expanded(child: SizedBox(width: 12)),
              InkWellComp(onTap: onDelete, paddingAll: 8, child: const ImageViewer(ImageResource.ic_delete)),
            ],
          ),
          if (timeModel?.dayModel != null)
            Obx(() => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: timeModel?.dayModel?.mapIndexed<Widget>(_buildItem).toList() ?? []))),
        ],
      ),
    );
  }

  Widget _buildItem(int index, AppDayModel element) {
    return Obx(() => ItemDayInfo(
          title: element.title,
          isActive: element.isActive?.value,
          isLast: index == timeModel!.dayModel!.length - 1,
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
          style: appStyle.textTheme.bodyText2?.apply(color: Colors.black.withOpacity(.5)),
        ),
      );
    });
  }

  String textMapper(int i) {
    if (i < 10) return '0$i';
    return '$i';
  }
}

class ItemDayInfo extends StatelessWidget {
  const ItemDayInfo({Key? key, this.title, this.isActive, this.onActive, this.isLast}) : super(key: key);
  final String? title;
  final bool? isActive;
  final bool? isLast;
  final Function()? onActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: isLast ?? false ? 0 : 16),
      child: InkWellComp(
        onTap: onActive,
        paddingAll: 0,
        child: AnimatedSwitcher(
          transitionBuilder: _buildTransition,
          duration: const Duration(milliseconds: 200),
          child: isActive ?? false
              ? Container(
                  key: const ValueKey('1'),
                  width: 32,
                  height: 32,
                  padding: const EdgeInsets.all(4),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100), color: ColorResource.primary),
                  alignment: Alignment.center,
                  child: Text(
                    title ?? '',
                    style: appStyle.textTheme.bodyText1
                        ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                )
              : Container(
                  key: const ValueKey('2'),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
                  padding: const EdgeInsets.all(4),
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  child: Text(
                    title ?? '',
                    style: appStyle.textTheme.bodyText1
                        ?.copyWith(color: ColorResource.primary, fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildTransition(Widget child, Animation<double> animation) {
    return ScaleTransition(scale: animation, child: FadeTransition(opacity: animation, child: child));
  }
}
