import 'package:flutter/material.dart';

class RadioComp<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Function(T? value) onChanged;
  final double? splashRadius;
  final Color? activeColor;
  final bool? toggleable;

  const RadioComp({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.splashRadius,
    this.activeColor,
    this.toggleable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.3,
      child: Radio(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        splashRadius: splashRadius,
        activeColor: activeColor ?? Colors.red,
        toggleable: toggleable ?? false,
      ),
    );
  }
}
