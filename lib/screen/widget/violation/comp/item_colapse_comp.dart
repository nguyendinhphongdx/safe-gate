import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/profile/user_detail_history/violations/violations_controller.dart';
import 'package:flutter/material.dart';

class ItemCollapseComp extends StatelessWidget {
  const ItemCollapseComp({Key? key, this.violation, this.isExpanded = false}) : super(key: key);
  final ViolationHeaderData? violation;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      // decoration: BoxDecoration(border: Border(bottom: BorderSide(color: ColorResource.divider, width: 1))),
      child: Row(
        children: [
          Expanded(
              child: Text(
            DateTimeUtils.getTitleByDate(violation?.date),
            style: appStyle.textTheme.bodyText1,
          )),
          Text(
            '${(violation?.accessParentModel?.countViolation != 0 && violation?.accessParentModel?.countViolation != null) ? violation?.accessParentModel?.countViolation ?? '' : 'Không'} vi phạm',
            style: appStyle.textTheme.bodyText2?.apply(
                color: violation?.accessParentModel?.countViolation == 0 ||
                        violation?.accessParentModel?.countViolation == null
                    ? Colors.green
                    : Colors.red),
          ),
          const SizedBox(width: 8),
          ImageViewer(!isExpanded ? ImageResource.ic_arrow_down : ImageResource.ic_arrow_up),
        ],
      ),
    );
  }
}
