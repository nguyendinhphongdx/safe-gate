import 'package:base_pm2/common/core/app_core.dart';
import 'package:flutter/material.dart';

class EditText extends StatelessWidget {
  const EditText(
      {Key? key,
      this.hint,
      this.rightIcon,
      this.maxLines = 1,
      this.minLines = 1,
      this.onValidator,
      this.borderRadius,
      this.textStyle,
      this.controller})
      : super(key: key);
  final String? hint;
  final Widget? rightIcon;
  final int maxLines;
  final int minLines;
  final double? borderRadius;
  final String? Function(String? s)? onValidator;
  final TextEditingController? controller;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextFieldComp(
      editingController: controller,
      hint: hint ?? '',
      suffixIcon: rightIcon ?? const SizedBox(),
      maxLines: maxLines,
      minLine: minLines,
      onValidator: onValidator,
      borderRadius: borderRadius ?? 12,
      isBorder: true,
      enableDefauSuffix: true,
      borderColor: Colors.transparent,
      style: textStyle,
      fillColor: Colors.black.withOpacity(0.2),
    );
  }
}
