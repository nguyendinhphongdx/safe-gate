import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class ButtonDialog extends StatelessWidget {
  const ButtonDialog(
      {Key? key,
      this.confirmLabel,
      this.cancelLabel,
      this.onCancel,
      this.onConfirm,
      this.confirmColor,
      this.showConfirm = true,
      this.showCancel = true,
      this.confirmTextColor,
      this.showShadow,
      this.isEnable = true,
      this.cancelTextColor})
      : super(key: key);
  final String? confirmLabel;
  final String? cancelLabel;
  final Function()? onCancel;
  final Function()? onConfirm;
  final bool showConfirm;
  final bool showCancel;
  final bool isEnable;
  final Color? confirmColor;
  final Color? confirmTextColor;
  final Color? cancelTextColor;
  final bool? showShadow;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 2,
              color: Colors.white,
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 50),
              decoration: const BoxDecoration(
                color: ColorResource.buttonDialog,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  Visibility(
                    visible: showCancel,
                    child: Expanded(
                      child: InkWellComp(
                          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            cancelLabel ?? '',
                            textAlign: TextAlign.center,
                            style: appStyle.textTheme.bodyText1?.copyWith(
                                color: cancelTextColor ?? ColorResource.tabIndicator,
                                fontWeight: FontWeight.w600),
                          ),
                          onTap: onCancel),
                    ),
                  ),
                  Visibility(
                    visible: showConfirm && showCancel,
                    child: Container(
                      height: 44,
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  Visibility(
                    visible: showConfirm,
                    child: Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: confirmColor?.withOpacity(isEnable ? 1 : .5),
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(12))),
                        child: InkWellComp(
                            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              confirmLabel ?? '',
                              textAlign: TextAlign.center,
                              style: appStyle.textTheme.bodyText1?.copyWith(
                                  color: (confirmTextColor ?? ColorResource.tabIndicator)
                                      .withOpacity(isEnable ? 1 : .3),
                                  fontWeight: FontWeight.w600),
                            ),
                            onTap: isEnable ? onConfirm : null),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Visibility(
          visible: showShadow ?? true,
          child: Container(
            height: 12,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.0),
            ])),
          ),
        )
      ],
    );
  }
}
