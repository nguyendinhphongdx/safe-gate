import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomAppBarComp extends StatefulWidget {
  final Function(int value) onChangeTab;
  final int tabIndex;

  const BottomAppBarComp({Key? key, required this.onChangeTab, this.tabIndex = 2}) : super(key: key);

  @override
  State<BottomAppBarComp> createState() => _BottomAppBarCompState();
}

class _BottomAppBarCompState extends State<BottomAppBarComp> {
  List<int> tabValue = [0, 1, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: ColorResource.bottomBar,
      child: Row(
        children: <Widget>[
          Expanded(
            child: itemBottomBar(
              valueTab: tabValue[0],
              iconData: ImageResource.ic_bottom_1,
              title: 'Menu',
              onChangeTab: () => _onChangePage(0),
            ),
          ),
          Expanded(
            child: itemBottomBar(
              valueTab: tabValue[1],
              iconData: ImageResource.ic_bottom_2,
              title: 'Menu',
              onChangeTab: () => _onChangePage(1),
            ),
          ),
          Expanded(
            child: itemBottomBar(
              valueTab: tabValue[2],
              title: '',
              onChangeTab: () => _onChangePage(3),
            ),
          ),
          Expanded(
            child: itemBottomBar(
              valueTab: tabValue[2],
              iconData: ImageResource.ic_bottom_3,
              title: 'Menu',
              onChangeTab: () => _onChangePage(3),
            ),
          ),
          Expanded(
            child: itemBottomBar(
              valueTab: tabValue[3],
              iconData: ImageResource.ic_bottom_4,
              title: 'Menu',
              onChangeTab: () => _onChangePage(4),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBottomBar({
    required int valueTab,
    String? iconData,
    required String title,
    required Function onChangeTab,
  }) {
    return InkWellComp(
      isTransparent: true,
      onTap: () => onChangeTab.call(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ImageViewer(
        iconData ?? '',
        width: 20,
        height: 20,
        color: widget.tabIndex == valueTab ? ColorResource.bottomBarItem : Colors.white,
      ),
    );
  }

  void _onChangePage(int i) {
    widget.onChangeTab.call(i);
  }
}
