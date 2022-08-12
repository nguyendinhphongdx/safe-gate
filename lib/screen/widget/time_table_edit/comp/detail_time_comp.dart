// ignore_for_file: prefer_const_constructors

import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/widget/time_table_edit/comp/item_current_time.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailTimeComp extends StatelessWidget {
  const DetailTimeComp({Key? key, this.startTime, this.endTime}) : super(key: key);
  final String? startTime; // HH:mm
  final String? endTime; // HH:mm

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 26,
            left: 0,
            child: Column(
              children: [
                Container(
                  color: ColorResource.primary,
                  width: Get.width - 100,
                  height: 1,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text('0', style: appStyle.textTheme.subtitle2?.apply(color: Colors.black))),
                      Expanded(
                          child: Text('6', style: appStyle.textTheme.subtitle2?.apply(color: Colors.black))),
                      Expanded(
                          child: Text('12', style: appStyle.textTheme.subtitle2?.apply(color: Colors.black))),
                      Expanded(
                          child: Text('18', style: appStyle.textTheme.subtitle2?.apply(color: Colors.black))),
                      Text('24', style: appStyle.textTheme.subtitle2?.apply(color: Colors.black)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              left: getPositionByTime('12:00'),
              child: ItemCurrentTime(
                color: ColorResource.startTime,
                title: '12:00',
              )),
          Positioned(
              left: getPositionByTime('18:00'),
              child: ItemCurrentTime(
                color: Colors.red,
                title: '18:00',
              )),
        ],
      ),
    );
  }

  double getPositionByTime(String? time) {
    if (time == null) return 0;
    return ((Get.width - 100) / 1500) * getMinutes(time) + 1;
  }

  int getMinutes(String? time) {
    if (time == null) return 0;
    List<String> splits = time.split(':');
    return int.parse(splits[0]) * 60 + int.parse(splits[1]);
  }
}
