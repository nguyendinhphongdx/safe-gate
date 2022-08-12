import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/overview/overview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:get/get.dart';

class ItemStatusView extends StatelessWidget {
  final ItemStatus? itemStatus;
  final VoidCallback? onItemPressed;

  const ItemStatusView(this.itemStatus, {Key? key, this.onItemPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWellComp(
      onTap: onItemPressed,
      paddingAll: 0,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: ColorResource.greyEA),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                height: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  // color: itemStatus?.color,
                  gradient: LinearGradient(
                      colors: itemStatus?.color ?? [],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
                ),
                child: SvgComp(
                  boxFit: BoxFit.contain,
                  url: itemStatus?.url ?? '',
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(12), topRight: Radius.circular(12)),
                      gradient: LinearGradient(colors: [
                        Color(0xFFF0F0F0),
                        Color(0xFFD9D9D9),
                      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemStatus?.status ?? '',
                        maxLines: 1,
                        style: appStyle.textTheme.subtitle2?.copyWith(
                            color: ColorResource.titleAppBarWhiteScreen, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        ()=> Text.rich(TextSpan(children: [
                          TextSpan(
                            text: '${itemStatus?.data?.value ?? 00}',
                            style: appStyle.textTheme.bodyText2?.copyWith(
                              color: itemStatus?.textColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              height: 1,
                            ),
                          ),
                          TextSpan(
                            text: Utils.isNotNullAndEmpty(itemStatus?.total?.value) ? '/${itemStatus?.total?.value}' : '',
                            style: appStyle.textTheme.bodyText2?.copyWith(
                              color: itemStatus?.textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1,
                            ),
                          ),
                          TextSpan(
                            text: ' ${itemStatus?.expend ?? ''}',
                            style: appStyle.textTheme.bodyText1?.copyWith(
                              color: ColorResource.titleAppBarWhiteScreen,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ])),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
