import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/common/resource/keylanguage_resource/key_language.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseErrorDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? textButtonConfirm;
  final String? textButtonCancel;
  final bool? showConfirm;
  final bool? showCancel;
  final Function? mConfirm;
  final Function? mCancel;
  final bool? willPopScope;

  const BaseErrorDialog(
      {Key? key,
      this.title,
      this.mConfirm,
      this.mCancel,
      this.showCancel,
      this.showConfirm,
      this.content,
      this.textButtonCancel,
      this.textButtonConfirm, this.willPopScope})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => willPopScope ?? false,
      child: AlertDialog(
        title: Text(title ?? KeyLanguage.notification.tr,
            style: appStyle.textTheme.headline3
                ?.apply(color: ColorResource.primary)),
        content: Text(content ?? '', style: appStyle.textTheme.bodyText1),
        insetPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: [
          showCancel ?? true
              ? TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    mCancel?.call();
                  },
                  child: Text(
                    textButtonCancel ?? KeyLanguage.cancel.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 16,color: ColorResource.grey),
                  ),
                )
              : const SizedBox(),
          showConfirm ?? true
              ? TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    mConfirm?.call();
                  },
                  child: Text(
                    textButtonConfirm ?? KeyLanguage.confirm.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: ColorResource.primary),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
