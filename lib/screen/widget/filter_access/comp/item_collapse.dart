import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/core/widget/image/cached_network_image_comp.dart';
import 'package:base_pm2/common/core/widget/image/image_viewer.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:flutter/material.dart';

class ItemCollapse extends StatelessWidget {
  const ItemCollapse({Key? key, this.title, this.desc, this.labelColor, this.label, this.icon, this.img})
      : super(key: key);
  final String? title;
  final String? img;
  final String? desc;
  final String? label;
  final String? icon;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        CachedNetworkImageComp(
          url: Utils.concatImageLink(img) ?? '',
          width: 46,
          height: 46,
          fit: BoxFit.cover,
          borderRadius: 100,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title ?? '',
                maxLines: 1,
                style: appStyle.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                desc ?? '',
                maxLines: 1,
                style: appStyle.textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Text(label ?? '', style: appStyle.textTheme.bodyText2?.apply(color: labelColor)),
        const SizedBox(width: 8),
        ImageViewer(icon ?? ImageResource.ic_arrow_down)
      ]),
    );
  }
}
