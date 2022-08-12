import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/screen/report/comp/item_chart_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemChartReport extends StatelessWidget {
  const ItemChartReport({Key? key, this.data, this.title, this.isLast, this.max, this.row}) : super(key: key);
  final List<ChartData>? data;
  final String? title;
  final bool? isLast;
  final int? max;
  final int? row;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
              width: 46,
              // color: Colors.red,
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                title ?? '',
                textAlign: TextAlign.end,
                maxLines: 1,
                style: appStyle.textTheme.bodyText2?.copyWith(fontSize: 10),
              )),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: /*isLast ?? false ? 0 : */ 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: data
                        ?.map((e) => Container(
                              height: 8,
                              width: (e.maxY! / ((max ?? 1) / row!)) * ((Get.width - 89) / row!),
                              // width: 120,
                              color: e.color,
                              margin: const EdgeInsets.only(bottom: 0),
                            ))
                        .toList() ??
                    [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
