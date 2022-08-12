import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/screen/widget/edit_time/edit_time_controller.dart';
import 'package:base_pm2/screen/widget/filter_access/comp/item_config_time.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDayPick extends GetView<EditTimeController> {
  const ItemDayPick({this.timeModel, this.application, Key? key}) : super(key: key);
  final RuleAppModel? timeModel;

  final ApplicationModel? application;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 32),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: ColorResource.tabIndicator.withOpacity(.3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => IntrinsicWidth(
              child: AnimatedSwitcher(
                
                duration: Duration(milliseconds: 100),
                transitionBuilder: _buildTransition,
                child: Utils.isNotNullAndEmpty(timeModel?.dayModel?.where((p0) => p0.isActive?.value ?? false))
                    ? Text(
                        'Thứ ${timeModel?.dayModel?.where((p0) => p0.isActive?.value ?? false).map((element) {
                              if (element.id == 8) return 'CN';
                              return element.id.toString();
                            }).join(', ').toString()}',
                        style: appStyle.textTheme.bodyText2,
                      )
                    : SizedBox(),
              ),
            ),
          ),
          Obx(() => Visibility(
              visible:
                  Utils.isNotNullAndEmpty(timeModel?.dayModel?.where((p0) => p0.isActive?.value ?? false)),
              child: SizedBox(height: 12))),
          if (timeModel?.dayModel != null)
            Obx(() => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    mainAxisSize: MainAxisSize.min,
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

  Widget _buildTransition(Widget child, Animation<double> animation) {
    return SizeTransition(sizeFactor: animation, child: child);
  }
}
