import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class DropdownComp extends StatelessWidget {
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? icon;
  final String? hint, error, label;
  final String? currentValue;
  final int? index;
  final List<BaseOptionDropdown> listItems;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? errorBorder;
  final OutlineInputBorder? focusedErrorBorder;
  final double? borderRadius;
  final Function? onValidator;
  final Function? onTapCallBack;
  final Function(dynamic value) onChange;
  final TextStyle? hintStyle;
  final TextStyle? selectionStyle;
  final TextStyle? selectedStyle;
  final TextStyle? style;
  final bool? isCollapsed;
  final bool? isBorder;
  final double? paddingSuffixIcon;
  final double? paddingPrefixIcon;
  final EdgeInsetsGeometry? contentPadding;

// cach mot khoang le ben trai mac dinh
  final bool? filled;
  final Color? bgSelection;
  final Color? bgSelected;
  final Color? fillColor;

  final GlobalKey dropdownKey = GlobalKey();
  final _dropdownFormFieldKey = GlobalKey<FormState>();

  DropdownComp({
    Key? key,
    required this.onChange,
    required this.listItems,
    this.prefixIcon,
    this.currentValue,
    this.hint,
    this.index,
    this.style,
    this.icon,
    this.borderRadius,
    this.onTapCallBack,
    this.errorBorder,
    this.focusedErrorBorder,
    this.error,
    this.onValidator,
    this.label,
    this.suffixIcon,
    this.enabledBorder,
    this.focusedBorder,
    this.isCollapsed = false,
    this.isBorder = false,
    this.paddingSuffixIcon,
    this.paddingPrefixIcon,
    this.contentPadding,
    this.filled,
    this.hintStyle,
    this.selectionStyle,
    this.selectedStyle,
    this.bgSelection,
    this.bgSelected,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _dropdownFormFieldKey,
      child: Container(
        decoration: BoxDecoration(
            // color: bgSelected ?? Colors.white,
            borderRadius: isBorder!
                ? BorderRadius.all(
                    Radius.circular(borderRadius ?? 8),
                  )
                : null),
        child: DropdownButtonFormField(
          dropdownColor: bgSelection ?? Colors.white,
          decoration: border(),
          validator: (value) => onValidator?.call(value),
          key: dropdownKey,
          menuMaxHeight: ViewUtils.height / 2,
          value: currentValue == '' ? null : currentValue,
          isExpanded: true,
          isDense: false,
          onTap: () => FocusScope.of(context).unfocus(),
          style: style,
          icon: icon,
          onChanged: (value) {
            // if (_dropdownFormFieldKey.currentState != null) {
            //   if (_dropdownFormFieldKey.currentState!.validate()) {
            //     _dropdownFormFieldKey.currentState!.save();
            //   }
            // }
            onChange(value);
          },
          items: listItems.map((value) {
            return DropdownMenuItem(
              onTap: () {
                FocusScope.of(context).unfocus();
                onTapCallBack?.call(value, index ?? 0);
              },
              value: value.name,
              child: Text(
                value.name ?? '',
                style: selectionStyle,
              ),
            );
          }).toList(),
          selectedItemBuilder: (context) => listItems
              .map(
                (value) => Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value.name ?? '',
                    style: selectedStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  InputDecoration border() {
    return !isCollapsed!
        ? InputDecoration(
            hintStyle: hintStyle,
            hintText: hint,
            errorText: error,
            label: label != null ? Text(label ?? '') : null,
            labelStyle: const TextStyle(color: ColorResource.primary),
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints(
              minWidth: paddingSuffixIcon ?? 36,
              minHeight: paddingSuffixIcon ?? 36,
            ),
            prefixIcon: prefixIcon,
            prefixIconConstraints: BoxConstraints(
              minWidth: paddingPrefixIcon ?? 36,
              minHeight: paddingPrefixIcon ?? 36,
            ),
            contentPadding: contentPadding,
            isDense: true,
            filled: filled,
            fillColor: fillColor ?? Colors.transparent,
            enabledBorder: isBorder!
                ? enabledBorder ??
                    OutlineInputBorder(
                      borderSide: const BorderSide(width: 0.5, color: Colors.red),
                      borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius ?? 8),
                      ),
                    )
                : UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorResource.tabIndicator.withOpacity(.6), width: 0.5)),
            focusedBorder: isBorder!
                ? focusedBorder ??
                    OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius ?? 8),
                      ),
                    )
                : UnderlineInputBorder(borderSide: BorderSide(color: ColorResource.primary, width: 0.5)),
            errorBorder: isBorder!
                ? errorBorder ??
                    OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius ?? 8),
                      ),
                    )
                : UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 0.5)),
            focusedErrorBorder: isBorder!
                ? focusedErrorBorder ??
                    OutlineInputBorder(
                      borderSide: const BorderSide(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.all(
                        Radius.circular(borderRadius ?? 8),
                      ),
                    )
                : null,
          )
        : InputDecoration.collapsed(
            hintStyle: hintStyle,
            hintText: hint,
            filled: true,
            fillColor: Colors.transparent,
            border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)));
  }

  openDropdownAnyWhere() {
    GestureDetector? detector;
    void searchForGestureDetector(BuildContext element) {
      element.visitChildElements((element) {
        if (element.widget is GestureDetector) {
          detector = element.widget as GestureDetector;
          return;
        } else {
          searchForGestureDetector(element);
        }
        return;
      });
    }

    searchForGestureDetector(dropdownKey.currentContext!);
    detector!.onTap!();
  }
}
