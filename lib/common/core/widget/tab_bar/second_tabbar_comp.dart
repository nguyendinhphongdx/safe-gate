import 'package:base_pm2/common/core/app_core.dart';
import 'package:flutter/material.dart';

class SecondTabBarComp extends StatelessWidget {
  const SecondTabBarComp({Key? key, this.controller}) : super(key: key);
  final TabController? controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 2,
              width: double.infinity,
              color: appStyle.dividerColor,
            )),
        TabBar(controller: controller, indicatorColor: Colors.white, tabs: [
          Tab(text: 'Ứng dụng và web'),
          Tab(text: 'Nhóm'),
        ]),
      ],
    );
  }
}
