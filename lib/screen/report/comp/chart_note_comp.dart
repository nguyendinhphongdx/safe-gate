import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/extension/string_extension.dart';
import 'package:base_pm2/screen/report/comp/item_chart_horizontal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartNoteComp extends StatelessWidget {
  const ChartNoteComp({Key? key, this.data}) : super(key: key);
  final List<ChartData>? data;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: data?.map((e) => _ItemChartNote(chartData: e)).toList() ?? []);
  }
}

class _ItemChartNote extends StatelessWidget {
  const _ItemChartNote({Key? key, this.chartData}) : super(key: key);
  final ChartData? chartData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(color: chartData?.color, borderRadius: BorderRadius.circular(100)),
          ),
          const SizedBox(width: 8),
          Text(
            (chartData?.title ?? '').toUpperCaseFirst,
            style: appStyle.textTheme.subtitle2?.apply(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
