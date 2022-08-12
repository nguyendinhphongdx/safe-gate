import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class DateRangeComp extends StatelessWidget {
  const DateRangeComp({Key? key, this.onChangeDate, this.startTime, this.endTime}) : super(key: key);
  final Function()? onChangeDate;
  final DateTime? startTime;
  final DateTime? endTime;

  @override
  Widget build(BuildContext context) {
    return InkWellComp(
      paddingAll: 0,
      onTap: onChangeDate,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration:
            BoxDecoration(color: Colors.black.withOpacity(.2), borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ImageViewer(
              ImageResource.ic_calendar,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 12),
            Text(
              '${DateTimeUtils.format(startTime, DateTimeUtils.DDMMMMYYYY)} - ${DateTimeUtils.format(endTime, DateTimeUtils.DDMMMMYYYY)}',
              style: appStyle.textTheme.bodyText2,
            ),
            const SizedBox(width: 12),
            const ImageViewer(
              ImageResource.ic_arrow_down,
              width: 11,
              height: 6,
            ),
          ],
        ),
      ),
    );
  }
}
