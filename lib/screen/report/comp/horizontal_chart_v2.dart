import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/screen/report/comp/item_chart_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HorizontalChartV2 extends StatelessWidget {
  const HorizontalChartV2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 2,
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [6, 5, 4, 3, 2, 1, 0]
                  .map((e) => Row(
                        children: [
                          Text(e.toString()),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Container(
                              color: appStyle.dividerColor,
                              height: 1,
                            ),
                          )
                        ],
                      ))
                  .toList(),
            ),
          ),
          Positioned.fill(
            left: 20,
            child: ListView.builder(
              itemBuilder: _buildItem,
              itemCount: 17,
              reverse: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return ItemChartHorizontal(
      title: '${17 - index}/01/2021',
      data: [
        ChartData(maxY: 5, color: Colors.blue),
        ChartData(maxY: 1, color: Colors.orange),
        ChartData(maxY: 3, color: Colors.grey),
        ChartData(maxY: 2, color: Colors.yellow),
        ChartData(maxY: 4, color: Colors.lightBlueAccent),
      ],
    );
  }
}
