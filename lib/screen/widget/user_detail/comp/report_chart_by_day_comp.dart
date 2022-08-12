import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/data/model/report/report_by_day_model.dart';
import 'package:base_pm2/data/model/report/report_model.dart';
import 'package:base_pm2/screen/report/comp/item_chart_horizontal.dart';
import 'package:base_pm2/common/extension/app_extension.dart';
import 'package:base_pm2/screen/report/comp/item_chart_vertical.dart';
import 'package:flutter/material.dart';

class ReportChartByDayComp extends StatelessWidget {
  const ReportChartByDayComp({Key? key, this.reportProfileModel}) : super(key: key);
  final ReportByDayModel? reportProfileModel;

  @override
  Widget build(BuildContext context) {
    int row = 6;
    double maxHeight = 0;
    reportProfileModel?.reportModels?.forEach((element) {
      maxHeight += 12;
      element?.dayReports?.forEach((element) {
        maxHeight += 16;
      });
    });
    // maxHeight+=9;
    return Container(
      height: maxHeight,
      // color: Colors.red,
      // constraints: const BoxConstraints(minHeight: 200),
      child: Stack(
        children: [
          // Positioned.fill(
          //     bottom: 0,
          //     left: 64,
          //     child: ListView.builder(
          //         scrollDirection: Axis.horizontal,
          //         itemBuilder: (_, index) => Container(
          //               alignment: Alignment.centerLeft,
          //               // color: Colors.green,
          //               width: (Get.width - 102) / row,
          //               child: Column(
          //                 children: [
          //                   Expanded(child: Container(color: appStyle.dividerColor, width: 1)),
          //                   const SizedBox(height: 2),
          //                   Text(
          //                     index.toString(),
          //                     style: appStyle.textTheme.subtitle2,
          //                   ),
          //                 ],
          //               ),
          //             ),
          //         itemCount: row + 1)),
          Positioned.fill(
            left: 0,
            bottom: 16,
            child: ListView.builder(
              itemBuilder: _buildItem,
              itemCount: reportProfileModel?.reportModels?.length ?? 0,
              physics: const NeverScrollableScrollPhysics(),
              // reverse: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    AppReportDataModel? profile = reportProfileModel?.reportModels?[index];

    // showLog(reportProfileModel?.capacityMax);
    return ItemChartVertical(
        row: 6,
        title: DateTimeUtils.getTitleReport(profile?.day),
        isLast: index == ((reportProfileModel?.reportModels?.length ?? 0) - 1),
        max: reportProfileModel?.capacityMax ?? 1,
        data: profile?.dayReports
                ?.map<ChartData>((e) => ChartData(
                    title: (e.appAlias ?? '').toUpperCaseFirst,
                    maxY: (e.capacity ?? 1.0) * 1.0,
                    color:
                        reportProfileModel?.apps?.singleWhere((element) => element?.appId == e.appId)?.color))
                .toList() ??
            []);
  }
}
