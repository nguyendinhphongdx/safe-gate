import 'package:flutter/material.dart';

class IconButtonComp extends StatelessWidget {
  final IconData? icon;
  final Function()? onPress;
  final Color? splashColor, highLightColor, color;
  final double? splashRadius, size;

  const IconButtonComp({
    required this.icon,
    required this.onPress,
    Key? key,
    this.splashColor,
    this.splashRadius = 24,
    this.color,
    this.size, this.highLightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress,

      icon: Icon(
        icon,
        size: size,
        color: color,
      ),
      splashColor: splashColor,
      highlightColor: highLightColor,
      splashRadius: splashRadius,
      padding: EdgeInsets.zero,
    );
  }
}
