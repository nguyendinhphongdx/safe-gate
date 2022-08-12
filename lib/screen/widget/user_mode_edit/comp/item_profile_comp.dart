import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:flutter/material.dart';

class ItemProfileComp extends StatelessWidget {
  const ItemProfileComp({Key? key, this.mode, this.onModePress, this.maxLineDesc = 2}) : super(key: key);
  final ProfileModel? mode;
  final Function(ProfileModel? mode)? onModePress;
  final int maxLineDesc;

  @override
  Widget build(BuildContext context) {
    return InkWellComp(
      onTap: () => onModePress?.call(mode),
      borderRadiusAll: 12,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageViewer(
            /* mode?.icon ??*/
            '',
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(100),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        /*  mode?.name ??*/
                        '',
                        style: appStyle.textTheme.bodyText1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SvgComp(url: ImageResource.ic_arrow_right),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  /* mode?.description ??*/
                  '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: appStyle.textTheme.bodyText2
                      ?.apply(color: appStyle.textTheme.bodyText2?.color?.withOpacity(0.5)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
