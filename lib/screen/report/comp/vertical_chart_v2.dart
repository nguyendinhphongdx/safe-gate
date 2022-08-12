import 'package:base_pm2/common/extension/app_extension.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/model/report/report_model.dart';
import 'package:base_pm2/screen/report/comp/item_chart_horizontal.dart';
import 'package:base_pm2/screen/report/comp/item_chart_vertical.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class VerticalChartV2 extends StatefulWidget {
  final double? paddingLeftTitle;

  final double? paddingLeftChart;
  final double? height;

  final List<String>? titles;
  final ReportModel? report;

  const VerticalChartV2(
      {Key? key,
      this.paddingLeftTitle,
      this.paddingLeftChart,
      this.height,
      this.titles = const [],
      this.report})
      : super(key: key);

  @override
  State<VerticalChartV2> createState() => _VerticalChartV2State();
}

class _VerticalChartV2State extends State<VerticalChartV2> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    int row = 6;
    double maxHeight = 0;
    widget.report?.profiles?.forEach((element) {
      maxHeight += 12;
      element?.reportModels?.firstOrNull?.dayReports?.forEach((element) {
        maxHeight += 16;
      });
    });
    // maxHeight += 8;
    return Container(
      height: maxHeight,
      // color: Colors.red,
      // constraints: const BoxConstraints(minHeight: 200),
      child: Stack(
        children: [
          // Positioned.fill(
          //     bottom: 0,
          //     left: widget.paddingLeftChart ?? 64,
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
            left: widget.paddingLeftTitle ?? 0,
            bottom: 16,
            child: ListView.builder(
              // controller: scrollController,
              itemBuilder: _buildItem,
              itemCount: widget.report?.profiles?.length,
              // shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // reverse: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    ProfileModel? profile = widget.report?.profiles?[index];
    return ItemChartVertical(
        row: 6,
        title: profile?.profileName,
        isLast: index == ((widget.titles?.length ?? 0) - 1),
        max: widget.report?.capacityMax ?? 1,
        data: profile?.reportModels?.firstOrNull?.dayReports
                ?.map((e) => ChartData(
                    title: (e.appAlias ?? '').toUpperCaseFirst,
                    maxY: (e.capacity ?? 1.0) * 1.0,
                    color: widget.report?.apps?.singleWhere((element) => element?.appId == e.appId)?.color))
                .toList() ??
            []);
  }
}
