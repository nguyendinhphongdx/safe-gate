import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/local_storage/local_storage.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/mode_model.dart';
import 'package:flutter/material.dart';

class ItemModeComp extends StatelessWidget {
  const ItemModeComp({Key? key, this.mode, this.onModePress, this.maxLineDesc = 2, this.icon})
      : super(key: key);
  final ModeModel? mode;
  final Function(ModeModel? mode)? onModePress;
  final int maxLineDesc;
  final dynamic icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onModePress == null ? null : () => onModePress?.call(mode),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageViewer(
              Utils.concatImageLink(mode?.type) ?? (mode?.type == DNSMode.ADULT ? ImageResource.ic_parent : ImageResource.ic_baby),
              width: 32,
              height: 32,
              fit: BoxFit.contain,
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
                          (LocalStorage().get<String>(StorageKey.LANGUAGE) == LanguageCodeConstant.VI
                              ? mode?.languages?.vi?.name
                              : mode?.languages?.en?.name) ??
                              '',
                          style: appStyle.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      icon is Widget ? icon : SvgComp(url: icon ?? ImageResource.ic_arrow_right),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      (LocalStorage().get<String>(StorageKey.LANGUAGE) == LanguageCodeConstant.VI
                          ? mode?.languages?.vi?.description
                          : mode?.languages?.en?.description) ??
                          '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: appStyle.textTheme.bodyText2
                          ?.apply(color: appStyle.textTheme.bodyText2?.color?.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
