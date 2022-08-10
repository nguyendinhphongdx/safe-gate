import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/helper/view_utils.dart';
import 'package:flutter/material.dart';

class NoColorTabBarComp extends StatelessWidget {
  const NoColorTabBarComp({Key? key, this.tabController, this.tabs}) : super(key: key);
  final TabController? tabController;
  final List<Widget>? tabs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TabBar(
          indicatorColor: Colors.white,
          labelStyle: appStyle.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
          unselectedLabelStyle: appStyle.textTheme.bodyText1,
          unselectedLabelColor: Colors.white.withOpacity(0.6),
          padding: EdgeInsets.zero,
          controller: tabController,
          tabs: tabs ?? [],
        ),
        Positioned(
            bottom: 0.5,
            child: Container(
              height: 0.5,
              width: ViewUtils.width,
              color: Colors.white,
            ))
      ],
    );
  }
}
