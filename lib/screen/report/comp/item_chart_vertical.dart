import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/screen/report/comp/item_chart_horizontal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemChartVertical extends StatelessWidget {
  const ItemChartVertical({Key? key, this.data, this.title, this.isLast, this.max, this.row})
      : super(key: key);
  final List<ChartData>? data;
  final String? title;
  final bool? isLast;
  final int? max;
  final int? row;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
              width: 60,
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                title ?? '',
                textAlign: TextAlign.end,
                maxLines: 1,
                style: appStyle.textTheme.bodyText2?.copyWith(fontSize: 10),
              )),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: data
                      ?.map((e) => Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 13,
                                      width: (e.maxY! / ((max ?? 1) / row!)) * ((Get.width - 126) / row!),
                                      color: e.color,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(e.title ?? '',
                                          style: appStyle.textTheme.bodyText1
                                              ?.copyWith(fontWeight: FontWeight.w700, fontSize: 8)),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 4),
                                Text(
                                  (e.maxY! / ((max ?? 1) / row!)).toStringAsFixed(1),
                                  style: appStyle.textTheme.bodyText1
                                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 8),
                                ),
                              ],
                            ),
                          ))
                      .toList() ??
                  [],
            ),
          ),
        ],
      ),
    );
  }
}
