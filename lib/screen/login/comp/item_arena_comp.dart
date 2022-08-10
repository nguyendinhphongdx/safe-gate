import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/core/widget/image/image_viewer.dart';
import 'package:flutter/material.dart';

class ItemArenaComp extends StatelessWidget {
  const ItemArenaComp({Key? key, this.title, this.icon}) : super(key: key);
  final String? title;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ImageViewer(icon ?? '', width: 36,
            height: 22,),
          const SizedBox(width: 8),
          Text(
            title ?? 'Việt Nam (+84)',
            style: appStyle.textTheme.bodyText1?.apply(color: Colors.black.withOpacity(.5)),
          )
        ],
      ),
    );
  }
}
