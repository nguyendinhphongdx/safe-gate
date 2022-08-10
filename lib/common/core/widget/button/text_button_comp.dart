import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:flutter/material.dart';

class TextButtonComp extends StatelessWidget {
  final String? title;
  final Widget? child;
  final Function() onPressed;
  final Function()? onLongPressed;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final bool enable;
  final double? borderRadius;
  final BorderRadiusGeometry? radius;
  final double? widthValue;
  final double? heightValue;
  final ButtonStyle? buttonStyle;
  final Color? primaryColor;
  final Color? overlayColor;
  final bool isTransparent;

  const TextButtonComp({
    Key? key,
    this.title,
    this.radius,
    this.child,
    this.style,
    this.widthValue,
    this.onLongPressed,
    this.heightValue,
    required this.onPressed,
    this.padding,
    this.enable = true,
    this.borderRadius,
    this.buttonStyle,
    this.primaryColor,
    this.overlayColor,
    this.isTransparent = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthValue,
      height: heightValue,
      child: TextButton(
        onLongPress: enable ? onLongPressed : null,
        onPressed: enable ? onPressed : null,
        child: child ??
            Text(
              title ?? '',
              style: style ?? appStyle.textTheme.headline4,
            ),
        style: buttonStyle ??
            (!isTransparent
                ? ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      overlayColor ?? ColorResource.primary.withOpacity(0.1),
                    ),
                    splashFactory: enable ? null : NoSplash.splashFactory,
                    padding: MaterialStateProperty.all(
                      padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        (primaryColor ?? Colors.white).withOpacity(!enable ? 0.5 : 1)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: radius ?? BorderRadius.circular(borderRadius ?? 8),
                    )),
                  )
                : TextButton.styleFrom(
                    padding: padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    primary: Colors.transparent,
                    textStyle: style ?? appStyle.textTheme.headline4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 0),
                    ),
                  )),
      ),
    );
  }
}
