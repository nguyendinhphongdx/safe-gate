import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:flutter/cupertino.dart';
class ItemMoreComp extends StatelessWidget {
  const ItemMoreComp({Key? key, this.overLength, this.textColor}) : super(key: key);
  final int? overLength;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(  width: (ViewUtils.width - 100) / 4,
      // height: (ViewUtils.width - 100) / 4,
      child: Column(
        children: [
          Container(
            width: (ViewUtils.width - 100) / 5,
            height: (ViewUtils.width - 100) / 5,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(100), color: ColorResource.greyC7C7),
            alignment: Alignment.center,
            child: FittedBox(
              child: Text(
                '+$overLength',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: appStyle.textTheme.bodyText2
                    ?.copyWith(color: ColorResource.titleAppBarWhiteScreen, fontSize: 23),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '...',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: appStyle.textTheme.bodyText2
                ?.copyWith(color: textColor ?? ColorResource.tabIndicator.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
