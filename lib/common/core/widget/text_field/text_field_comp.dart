import 'dart:developer';

import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextFieldComp extends StatefulWidget {
  final Widget? prefixIcon, suffixIcon;
  final FocusNode? focusNode;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? editingController;
  final TextStyle? style, hintStyle, labelStyle;
  final String? label;
  final String? hint;
  final String? error;
  final Widget? obscure1;
  final Widget? obscure2;
  final Function()? onTap;
  final Function()? onEnter;
  final Function(String value)? onChange;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onSave;
  final String? Function(String? s)? onValidator;
  final RxBool? clear;
  final Color? colorClear;
  final int? minLine, maxLines, maxLength;
  final double? padH, padV, borderRadius, obscureSize;
  final TextCapitalization? capitalization;
  final TextAlign? textAlign;
  final Color? borderColor;
  final Color? fillColor;
  final Color? colorIconPassWord;
  final Color? cursorColor;
  final Color? colorUnderLine;

  final BoxConstraints? suffixConstraint, prefixConstraint;
  final OutlineInputBorder? enabledBorder, focusedBorder, disableBorder, errorBorder, focusedErrorBorder;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? obscurePadding;
  final List<TextInputFormatter>? inputFormatters;
  final bool? visibleClearSuffixIcon;
  final double? paddingSuffixIcon;
  final double? paddingPrefixIcon;
  final bool isBorder;
  final bool? isUnderLine;
  final bool? isDoubleNum;
  final bool? isReadOnly;
  final bool? autofocus;
  final bool? enable;
  final bool enableDefauSuffix;
  final bool? isInvisiblePassword;
  final Color? colorIcon;

  const TextFieldComp({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.visibleClearSuffixIcon,
    this.obscurePadding,
    this.focusNode,
    this.onEnter,
    this.inputType,
    this.isInvisiblePassword = false,
    this.editingController,
    this.hint,
    this.onChange,
    this.onTap,
    this.isReadOnly,
    this.minLine,
    this.maxLines,
    this.padH,
    this.colorClear,
    this.padV,
    this.autofocus,
    this.clear,
    this.textAlign,
    this.capitalization,
    this.enableDefauSuffix = false,
    this.borderColor,
    this.suffixConstraint,
    this.focusedErrorBorder,
    this.errorBorder,
    this.disableBorder,
    this.fillColor,
    this.inputAction,
    this.error,
    this.label,
    this.enable,
    this.borderRadius,
    this.obscureSize,
    this.contentPadding,
    this.inputFormatters,
    this.hintStyle,
    this.onValidator,
    this.prefixConstraint,
    this.style,
    this.colorIcon,
    this.isDoubleNum = false,
    this.onFieldSubmitted,
    this.paddingSuffixIcon,
    this.paddingPrefixIcon,
    this.isBorder = false,
    this.enabledBorder,
    this.focusedBorder,
    this.isUnderLine = true,
    this.labelStyle,
    this.colorIconPassWord,
    this.maxLength,
    this.cursorColor,
    this.onSave,
    this.colorUnderLine, this.obscure1, this.obscure2,
  }) : super(key: key);

  @override
  State<TextFieldComp> createState() => _TextFieldCompState();
}

class _TextFieldCompState extends State<TextFieldComp> {
  bool obscureText = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    obscureText = widget.isInvisiblePassword ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          // colorScheme: ThemeData().colorScheme.copyWith(
          //       primary: widget.colorIconPassWord,
          //     ),
          ),
      child: TextFormField(
        focusNode: widget.focusNode,
        cursorColor: widget.cursorColor ?? ColorResource.primary,
        maxLength: widget.maxLength,
        controller: widget.editingController,
        enabled: widget.enable ?? true,
        obscureText: obscureText,
        obscuringCharacter: '*',
        onChanged: widget.onChange,
        validator: (value) => widget.onValidator?.call(value),
        onTap: widget.onTap,
        onSaved: (value) {
          log('Save');
        },
        textAlign: widget.textAlign ?? TextAlign.start,
        autofocus: widget.autofocus ?? false,
        onFieldSubmitted: (value) => widget.onFieldSubmitted?.call(value),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: widget.inputFormatters ??
            ((widget.inputType == TextInputType.number)
                ? (!widget.isDoubleNum!
                    ? [FilteringTextInputFormatter.digitsOnly]
                    : [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))])
                : []),
        textCapitalization: widget.capitalization ?? TextCapitalization.sentences,
        textInputAction: widget.inputAction ?? TextInputAction.next,
        minLines: widget.minLine ?? 1,
        maxLines: widget.maxLines ?? widget.minLine ?? 1,
        keyboardType: widget.inputType,
        textAlignVertical: TextAlignVertical.center,
        readOnly: widget.isReadOnly ?? false,
        style: widget.style ?? appStyle.textTheme.bodyText1,
        decoration: inputDecoration(),
      ),
    );
  }

  InputDecoration inputDecoration() => InputDecoration(
        counter: const SizedBox(),
        errorStyle: appStyle.textTheme.bodyText2?.apply(color: Colors.red),
        filled: true,
        fillColor: widget.fillColor ?? ColorResource.transparent,
        labelText: widget.label,
        labelStyle: widget.labelStyle,
        alignLabelWithHint: true,
        hintText: widget.hint,
        hintStyle: (widget.hintStyle ??
            appStyle.textTheme.bodyText1
                ?.apply(color: appStyle.textTheme.bodyText1?.color?.withOpacity(0.5))),
        contentPadding: widget.contentPadding ??
            EdgeInsets.symmetric(
              vertical: widget.padV ?? 12,
              horizontal: widget.padH ?? 12,
            ),
        isDense: true,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon ??
            (widget.enableDefauSuffix
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: widget.isInvisiblePassword!,
                        child: InkWellComp(
                            isTransparent: true,
                            padding:
                                widget.obscurePadding ?? EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                            onTap: () {
                              obscureText = !obscureText;
                              setState(() {});
                            },
                            child: widget.obscure1 != null
                                ? obscureText
                                    ? widget.obscure1!
                                    : widget.obscure2!
                                : Icon(
                                    obscureText
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.visibility_off_outlined,
                                    size: widget.obscureSize ?? 22,
                                    color: widget.colorIconPassWord,
                                  )),
                      ),
                      Visibility(
                        visible: false,
                        child: InkWellComp(
                          // isTransparent: true,
                          paddingAll: 0,
                          onTap: () => {
                            widget.editingController?.clear(),
                          },
                          child: Icon(
                            CupertinoIcons.clear_circled_solid,
                            size: 20,
                            color: widget.colorClear ?? ColorResource.hint,
                          ),
                        ),
                      ),
                    ],
                  )
                : null),
        prefixIconConstraints: BoxConstraints(
          minWidth: widget.paddingPrefixIcon ?? 36,
          minHeight: widget.paddingPrefixIcon ?? 36,
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: widget.paddingSuffixIcon ?? 36,
          minHeight: widget.paddingSuffixIcon ?? 36,
        ),
        border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 1)),
        enabledBorder: widget.isBorder
            ? widget.enabledBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: widget.borderColor ?? ColorResource.divider),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 8),
                  ),
                )
            : widget.isUnderLine!
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: widget.colorUnderLine ?? ColorResource.field, width: 0.5))
                : InputBorder.none,
        focusedBorder: widget.isBorder
            ? widget.focusedBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: widget.borderColor ?? ColorResource.primarySwatchMaterial,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 8),
                  ),
                )
            : widget.isUnderLine!
                ? UnderlineInputBorder(borderSide: BorderSide(color: ColorResource.primary, width: 0.5))
                : InputBorder.none,
        errorBorder: widget.isBorder
            ? widget.errorBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: widget.borderColor ?? Colors.red),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 8),
                  ),
                )
            : widget.isUnderLine!
                ? UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 0.5))
                : InputBorder.none,
        focusedErrorBorder: widget.isBorder
            ? widget.focusedErrorBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: widget.borderColor ?? Colors.red),
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.borderRadius ?? 8),
                  ),
                )
            : widget.isUnderLine!
                ? UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 0.5))
                : InputBorder.none,
      );
}
