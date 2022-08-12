import 'package:base_pm2/common/core/app_core.dart';
import 'package:flutter/material.dart';

class PopupTime extends StatelessWidget {
  const PopupTime({Key? key, this.menuKey, this.offset}) : super(key: key);
  final GlobalKey<PopupMenuButtonState>? menuKey;
  final Offset? offset;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWellComp(
              onTap: () {
                menuKey?.currentState!.showButtonMenu();
              },
              child: Text(
                '13:30',
                textAlign: TextAlign.center,
                style: appStyle.textTheme.headline5?.copyWith(fontSize: 29, color: Colors.black),
              )),
        ),

        PopupMenuButton(
          iconSize: 0,
          padding: EdgeInsets.zero,
          enabled: false,
          child: const SizedBox(),
          key: menuKey,
          itemBuilder: _buildItem,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          offset: offset ?? Offset(-50, 0),
        )
      ],
    );
  }

  List<PopupMenuEntry> _buildItem(BuildContext context) {
    return <PopupMenuItem<String>>[
      PopupMenuItem<String>(
          child: Text(
            '09:00',
            style: appStyle.textTheme.bodyText2?.apply(color: Colors.black.withOpacity(.7)),
          ),
          value: 'Doge'),
      PopupMenuItem<String>(
          child: Text(
            '09:30',
            style: appStyle.textTheme.bodyText2?.apply(color: Colors.black.withOpacity(.7)),
          ),
          value: 'Lion'),
      PopupMenuItem<String>(
          child: Text(
            '10:30',
            style: appStyle.textTheme.bodyText2?.apply(color: Colors.black.withOpacity(.7)),
          ),
          value: 'Lion'),
      PopupMenuItem<String>(
          child: Text(
            '11:30',
            style: appStyle.textTheme.bodyText2?.apply(color: Colors.black.withOpacity(.7)),
          ),
          value: 'Lion'),
      PopupMenuItem<String>(
          child: Text(
            '12:30',
            style: appStyle.textTheme.bodyText2?.apply(color: Colors.black.withOpacity(.7)),
          ),
          value: 'Lion'),
      PopupMenuItem<String>(
          child: Text(
            '12:30',
            style: appStyle.textTheme.bodyText2?.apply(color: Colors.black.withOpacity(.7)),
          ),
          value: 'Lion'),
      PopupMenuItem<String>(
          child: Text(
            '12:30',
            style: appStyle.textTheme.bodyText2?.apply(color: Colors.black.withOpacity(.7)),
          ),
          value: 'Lion'),
      PopupMenuItem<String>(
          child: Text(
            '12:30',
            style: appStyle.textTheme.bodyText2?.apply(color: Colors.black.withOpacity(.7)),
          ),
          value: 'Lion'),
      PopupMenuItem<String>(
          child: Text(
            '12:30',
            style: appStyle.textTheme.bodyText2?.apply(color: Colors.black.withOpacity(.7)),
          ),
          value: 'Lion'),
    ];
  }
}
