
import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/extension/app_extension.dart';
import 'package:base_pm2/common/core/widget/image/image_viewer.dart';
import 'package:base_pm2/common/core/widget/layout/empty_view.dart';
import 'package:base_pm2/common/core/widget/time/timeline_comp.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/data/model/profile/report_profile_model.dart';
import 'package:base_pm2/data/model/report/report_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ItemHistoryDataComp extends StatelessWidget {
  const ItemHistoryDataComp({Key? key, this.reportProfileModel}) : super(key: key);

  final ReportProfileModel? reportProfileModel;

  @override
  Widget build(BuildContext context) {
    if (!Utils.isNotNullAndEmpty(reportProfileModel?.reportModels)) {
      return const Padding(
        padding: EdgeInsets.only(top: 12.0),
        child: EmptyView(),
      );
    }
    return TimelineComp(
      endFlex: 4,
      startFlex: 1,
      indicatorMarginTop: 12,
      endIndicatorStart: SizedBox(
        height: 0,
        child: Padding(
            padding: const EdgeInsets.only(top: 6.0, right: 24),
            child: Text('11:00', style: appStyle.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600))),
      ),
      children: reportProfileModel?.reportModels?.mapIndexed<TimeChild>(_buildItem).toList() ?? [],
    );
  }

  TimeChild _buildItem(int index, AppReportDataModel? element) {
    return TimeChild(
      startChild: Padding(
        padding: const EdgeInsets.only(top: 6.0, right: 24),
        child: Text(element?.day ?? '',
            style: appStyle.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600)),
      ),
      endChild: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(children: element?.dayReports?.mapIndexed<Widget>(_buildItemApp).toList() ?? []),
      ),
    );
  }

  Widget _buildItemApp(int index, AppReportDayModel element) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 24),
          ImageViewer(
            Utils.concatImageLink(element.appFavicon) ?? '',
            fit: BoxFit.cover,
            width: 20,
            height: 20,
            borderRadius: BorderRadius.circular(100),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              (element.appAlias ?? '').toUpperCaseFirst,
              maxLines: 1,
              style: appStyle.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w200),
            ),
          )
        ],
      ),
    );
  }
}
