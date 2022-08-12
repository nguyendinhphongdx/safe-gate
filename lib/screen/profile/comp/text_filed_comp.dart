import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:base_pm2/screen/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFiledBackGroundComp extends GetView<ProfileController> {
  final TextEditingController editingController;
  final String hint;
  final TextInputAction? inputAction;
  final Function? onValidator;
  final TextInputType? inputType;
  final Function(String value)? onFieldSubmitted;
  final bool? isReadOnly;
  final Function()? onTap;
  final TextCapitalization? capitalization;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final double? padH, padV;
  final bool? isInvisiblePassword;
  final Widget? suffixIcon;
  final bool isDefaultSuffixIcon;

  const TextFiledBackGroundComp(
      {Key? key,
      required this.editingController,
      required this.hint,
      this.inputAction,
      this.onValidator,
      this.style,
      this.inputType,
      this.onFieldSubmitted,
      this.isReadOnly,
      this.onTap,
      this.capitalization,
      this.hintStyle,
      this.padH,
      this.padV,
      this.isInvisiblePassword,
      this.suffixIcon,
      this.isDefaultSuffixIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldComp(
      editingController: editingController,
      fillColor: Colors.black.withOpacity(0.2),
      borderRadius: 12,
      isBorder: true,
      paddingSuffixIcon: 28,
      borderColor: Colors.transparent,
      hint: hint,
      obscureSize: 16,
      inputAction: inputAction,
      onValidator: (value) => onValidator?.call(value),
      isReadOnly: isReadOnly,
      onTap: () => onTap?.call(),
      capitalization: capitalization,
      style: style ?? appStyle.textTheme.bodyText1?.apply(color: Colors.white),
      suffixIcon: suffixIcon ?? (isDefaultSuffixIcon ? const Icon(Icons.edit, color: Colors.white) : null),
      hintStyle: appStyle.textTheme.bodySmall?.copyWith(color: Colors.white54),
      obscure1: SvgComp(url: ImageResource.ic_invisible, color: Colors.white, width: 12, height: 12),
      obscure2: SvgComp(url: ImageResource.ic_visible, color: Colors.white, width: 12, height: 12),
      padH: padH,
      padV: padV,
      enableDefauSuffix: true,
      colorIconPassWord: Colors.white,
      isInvisiblePassword: isInvisiblePassword,
    );
  }
}
