import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/local_storage/app_storage.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/mode_model.dart';
import 'package:flutter/material.dart';

class ItemModePickComp extends StatelessWidget {
  const ItemModePickComp(
      {Key? key,
      this.mode,
      this.onModePress,
      this.maxLineDesc = 2,
      this.isActive = false,
      this.shouldShowArrow})
      : super(key: key);
  final ModeModel? mode;
  final bool isActive;
  final bool? shouldShowArrow;
  final Function(ModeModel? mode)? onModePress;
  final int maxLineDesc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: isActive ? ColorResource.primary : ColorResource.grayLine.withOpacity(.6)),
                borderRadius: BorderRadius.circular(14)),
            child: InkWellComp(
              onTap: () => onModePress?.call(mode),
              borderRadiusAll: 12,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              backgroundColor: isActive ? ColorResource.primary : Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageViewer(
                      Utils.concatImageLink(mode?.type) ??
                          (mode?.type == DNSMode.ADULT ? ImageResource.ic_parent : ImageResource.ic_baby),
                      width: 56,
                      height: 65,
                      padding: const EdgeInsets.fromLTRB(4, 0, 16, 0)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                (LocalStorage().get<String>(StorageKey.LANGUAGE) == LanguageCodeConstant.VI
                                        ? mode?.languages?.vi?.name
                                        : mode?.languages?.en?.name) ??
                                    '',
                                style: appStyle.textTheme.bodyText1?.copyWith(
                                    color: isActive ? Colors.white : ColorResource.tabIndicator,
                                    fontWeight: FontWeight.w600),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Visibility(
                              visible: shouldShowArrow ?? true,
                              child: SvgComp(
                                url: ImageResource.ic_arrow_right,
                                color: Colors.black.withOpacity(.7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            (LocalStorage().get<String>(StorageKey.LANGUAGE) == LanguageCodeConstant.VI
                                    ? mode?.languages?.vi?.description
                                    : mode?.languages?.en?.description) ??
                                '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: appStyle.textTheme.subtitle1?.apply(
                                color: isActive
                                    ? Colors.white.withOpacity(.6)
                                    : ColorResource.tabIndicator.withOpacity(.6)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
         if(isActive) Container(
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(.1), Colors.black.withOpacity(.0)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          )
        ],
      ),
    );
  }
}
