import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/core/widget/dialog/bg_dialog_comp.dart';
import 'package:base_pm2/common/core/widget/button/button_dialog.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/common/resource/keylanguage_resource/key_language.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialogComp extends StatelessWidget {
  const AppDialogComp(
      {Key? key,
      this.title,
      this.content,
      this.showConfirm = true,
      this.showCancel = true,
      this.onConfirm,
      this.onCancel, this.canBack})
      : super(key: key);
  final String? title;
  final dynamic content;
  final bool showConfirm;
  final bool showCancel;
  final bool? canBack;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: BgDialogComp(
        canBack: canBack,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 24),
            Text(
              title ??KeyLanguage.notification.tr,
              style: appStyle.textTheme.bodyText1?.copyWith(fontSize: 16,color: ColorResource.tabIndicator,fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            content is Widget
                ? content
                : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                      content ?? '',
                      style: appStyle.textTheme.bodyText1?.apply(color:ColorResource.tabIndicator),
                    ),
                ),
            const SizedBox(height: 24),
            ButtonDialog(
              cancelLabel: KeyLanguage.cancel.tr,
              confirmLabel: KeyLanguage.confirm.tr,
              showCancel: showCancel,
              showConfirm: showConfirm,
              onConfirm: onConfirm,
              onCancel: onCancel ?? () => Get.back(),
            )
          ],
        ),
      ),
    );
  }
}
