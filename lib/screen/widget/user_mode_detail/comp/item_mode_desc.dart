import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class ItemModeDescription extends StatelessWidget {
  const ItemModeDescription({Key? key, this.icon, this.title}) : super(key: key);
  final String? icon;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 58.0, bottom: 19),
      child: Row(
        children: [
          ImageViewer(
            icon ?? ImageResource.ic_check_circular,
            width: 18,
            height: 18,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: appStyle.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
