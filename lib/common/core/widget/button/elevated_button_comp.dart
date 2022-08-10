import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class ElevatedButtonComp extends StatelessWidget {
  final dynamic title;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? radius;
  final TextStyle? style;

  /*
  * cho phép trạng thái press
  * */
  final bool enable;

  /*
  * Nếu trạng thái khác waiting thì nút sẽ được nhấn
  * */
  final double? borderRadius;
  final double? widthValue;
  final double? heightValue;
  final double? elevation;
  final ButtonStyle? buttonStyle;
  final Color? primaryColor;
  final Color? overlayColor;

  const ElevatedButtonComp({
    Key? key,
    this.title,
    required this.onPressed,
    this.radius,
    this.enable = true,
    this.padding,
    this.style,
    this.borderRadius,
    this.overlayColor,
    this.buttonStyle,
    this.primaryColor,
    this.widthValue,
    this.heightValue,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthValue,
      height: heightValue,
      child: ElevatedButton(
        onPressed: enable ? onPressed : null,
        child: (title is Widget)
            ? title
            : Text(title ?? '',
                style: style ??
                    appStyle.textTheme.headline4?.apply(color: Colors.white)),
        style: buttonStyle ??
            ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                overlayColor ?? Colors.white.withOpacity(0.1),
              ),
              splashFactory: enable ? null : NoSplash.splashFactory,
              padding: MaterialStateProperty.all(
                padding ??
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              ),
              alignment: Alignment.center,
              backgroundColor: MaterialStateProperty.all(
                  (primaryColor ?? ColorResource.primarySwatchMaterial)
                      .withOpacity(!enable ? 0.5 : 1)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    radius ?? BorderRadius.circular(borderRadius ?? 500),
              )),
              elevation: MaterialStateProperty.all(elevation),
            ),
      ),
    );
  }
}
