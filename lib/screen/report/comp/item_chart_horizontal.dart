import 'package:base_pm2/common/core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemChartHorizontal extends StatelessWidget {
  const ItemChartHorizontal({Key? key, this.data, this.title}) : super(key: key);
  final List<ChartData>? data;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 24),
      child: Column(
        children: [
          const Expanded(child: SizedBox()),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: data
                    ?.map((e) => Container(
                          height: (Get.height / 2 - 32) /6 * e.maxY!,
                          width: 24,
                          color: e.color,
                          margin: const EdgeInsets.only(left: 4),
                        ))
                    .toList() ??
                [],
          ),
          const SizedBox(height: 8),
          Text(title ?? '',style: appStyle.textTheme.subtitle2?.apply(color: Colors.white),),
        ],
      ),
    );
  }
}

class ChartData {
  String? title;
  double? maxY;
  Color? color;

  ChartData({this.color, this.title, this.maxY});
}
