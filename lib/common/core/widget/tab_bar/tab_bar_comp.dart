import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:flutter/material.dart';

class TabBarComp extends StatelessWidget {
  final Function(int index)? onChangeTab;
  final double radius;
  final double heightBackground;
  final double? heightTab;
  final List<Widget> listTab;
  final TabController controller;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;

  const TabBarComp(
      {Key? key,
      required this.onChangeTab,
      this.radius = 100,
      this.heightBackground = 24,
      this.heightTab,
      required this.listTab,
      required this.controller,
      this.labelStyle,
      this.unselectedLabelStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.0)])),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Colors.black.withOpacity(.32),
            ),
            child: TabBar(
              controller: controller,
              labelStyle: labelStyle ?? appStyle.textTheme.bodyText2,
              unselectedLabelStyle: unselectedLabelStyle ?? appStyle.textTheme.bodyText2,
              unselectedLabelColor: Colors.white.withOpacity(0.6),
              // isScrollable: true,

              padding: EdgeInsets.zero,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFF5288d5), Color(0xFF81a7e0)]),
              ),
              onTap: onChangeTab,
              tabs: listTab.map((e) => e).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
