import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class CustomSwitchComp extends StatelessWidget {
  const CustomSwitchComp(
      {Key? key,
      this.value = false,
      this.onChanged,
      this.backgroundColor = ColorResource.primary,
      this.icon,
      this.activeColor,
      this.inActiveColor})
      : super(key: key);
  final bool value;
  final Color backgroundColor;
  final Function()? onChanged;
  final Widget? icon;

  final Color? activeColor;
  final Color? inActiveColor;

  @override
  Widget build(BuildContext context) {
    return InkWellComp(
      onTap: onChanged,
      borderRadiusAll: 100,
      paddingAll: 0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: !value ? activeColor ?? Colors.white : (inActiveColor ?? Colors.white)),
        width: 44,
        height: 23,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: !value ? inActiveColor ?? backgroundColor : activeColor ?? backgroundColor,
                    borderRadius: BorderRadius.circular(100)),
                child: FittedBox(child: icon),
              ),
              left: value ? 0 : 20,
              right: value ? 20 : 0,
            )
          ],
        ),
      ),
    );
  }
}
