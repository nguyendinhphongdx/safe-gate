import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/screen/widget/filter_access/app_web/app_web_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemTimeInfomation extends GetView<AppWebController> {
  const ItemTimeInfomation({this.timeModel, this.onDelete, this.application, Key? key}) : super(key: key);
  final RuleAppModel? timeModel;
  final Function()? onDelete;
  final ApplicationModel? application;

  @override
  Widget build(BuildContext context) {
    showLog(timeModel?.isActiveTime?.value);
    return Column(
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
                      color: timeModel?.isActiveStart?.value ?? false ? ColorResource.primary : Colors.white),
                ),
              ),
            ),
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
            const Expanded(child: SizedBox(width: 12)),
            Obx(() => CupertinoSwitchComp(
                  value: timeModel?.isActiveTime?.value ?? false,
                  onChanged: (b) => onDelete?.call(),
                ))
          ],
        ),
        Text(
          'Thứ ${timeModel?.dayModel?.where((p0) => p0.isActive?.value ?? false).map((element) {
                if (element.id == 8) return 'CN';
                return element.id.toString();
              }).join(', ').toString()}',
          style: appStyle.textTheme.subtitle1,
        ),
        Container(
          color: ColorResource.divider,
          width: double.infinity,
          height: 0.5,
        ),
      ],
    );
  }
}
