import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/common/resource/enum_resource.dart';

import 'package:flutter/material.dart';

class OutlinedButtonComp extends StatelessWidget {
  final String? title;
  final Widget? child;
  final Function() onPressed;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final Status? status;
  final double? borderRadius;
  final double? widthValue;
  final double? heightValue;
  final double? side;
  final ButtonStyle? buttonStyle;
  final Color? primaryColor;
  final Color? colorBorder;

  const OutlinedButtonComp({
    Key? key,
    this.title,
    this.child,
    this.style,
    this.widthValue,
    this.heightValue,
    required this.onPressed,
    this.padding,
    this.status,
    this.borderRadius,
    this.buttonStyle,
    this.primaryColor,
    this.colorBorder,
    this.side,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthValue,
      height: heightValue,
      child: OutlinedButton(
        onPressed: onPressed,
        child: child ??
            Text(
              title ?? '',
              style: style ?? appStyle.textTheme.headline4,
            ),
        style: buttonStyle ??
            OutlinedButton.styleFrom(
              padding: padding ??
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              side: BorderSide(
                  color: colorBorder ?? ColorResource.primarySwatchMaterial,
                  width: side ?? 1),
              primary: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
              ),
            ),
      ),
    );
  }
}
