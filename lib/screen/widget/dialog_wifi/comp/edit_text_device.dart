import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';


class EditTextDevice extends StatelessWidget {
  const EditTextDevice({Key? key, this.hint, this.isInvisiblePassword, this.enableDefaultSuffix, this.iconColor, this.textInputAction, this.controller}) : super(key: key);
  final String? hint;
  final bool? isInvisiblePassword;
  final bool? enableDefaultSuffix;
  final Color? iconColor;
  final  TextInputAction? textInputAction;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFieldComp(
      editingController:controller,
      hint: hint,
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      fillColor: Colors.transparent,
      cursorColor: ColorResource.tabIndicator,
      borderColor: ColorResource.tabIndicator,
      style: appStyle.textTheme.bodyText2?.copyWith(color: ColorResource.primary,fontWeight: FontWeight.w600),
      hintStyle: appStyle.textTheme.bodyText2?.apply(color: ColorResource.hint),
      isUnderLine: true,
      paddingSuffixIcon: 18,
      colorUnderLine: ColorResource.hint,
      obscurePadding: EdgeInsets.zero,
      obscure1: SvgComp(url: ImageResource.ic_invisible,color: iconColor ?? ColorResource.primary.withOpacity(.5),width: 18,height: 18,),
      obscure2: SvgComp(url: ImageResource.ic_visible,color:iconColor ?? ColorResource.primary.withOpacity(.5),width: 18,height: 18,),
      colorIconPassWord: iconColor ?? ColorResource.primary.withOpacity(.5),
      isInvisiblePassword: isInvisiblePassword,
      enableDefauSuffix: enableDefaultSuffix ?? false,
      inputAction: textInputAction,
    );
  }
}
