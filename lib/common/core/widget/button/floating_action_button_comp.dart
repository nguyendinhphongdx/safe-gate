import 'package:flutter/material.dart';

class FloatingActionButtonComp extends StatelessWidget {
  final ShapeBorder? shape;
  final double? elevation;
  final double? height;
  final double? width;
  final Function onPressed;
  final Widget child;
  final Color? backgroundColor;

  const FloatingActionButtonComp({
    Key? key,
    this.shape,
    this.elevation,
    this.height = 60,
    this.width = 60,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FloatingActionButton(
        backgroundColor: backgroundColor,
        onPressed: (){},
        child: child,
        elevation: elevation,
        shape: shape,
      ),
    );
  }
}
