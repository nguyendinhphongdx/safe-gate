import 'package:base_pm2/common/core/app_core.dart';
import 'package:flutter/material.dart';

class ItemAccountComp extends StatelessWidget {
  const ItemAccountComp({Key? key, this.imageUrl, this.onPressed, this.title}) : super(key: key);

  final String? imageUrl;
  final Function()? onPressed;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return InkWellComp(
      padding: const EdgeInsets.symmetric(vertical: 17.5, horizontal: 16),
      borderRadiusAll: 0,
      onTap: onPressed,
      child: Row(
        children: [
          SizedBox(
            width: 26,
            child: SvgComp(
              url: imageUrl ?? '',
              width: 22,
              height: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Text(
            title ?? '',
            style: appStyle.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
          )),
        ],
      ),
    );
  }
}
