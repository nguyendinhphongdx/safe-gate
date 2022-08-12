import 'package:base_pm2/common/core/app_core.dart';
import 'package:flutter/material.dart';

class ItemCurrentTime extends StatelessWidget {
  const ItemCurrentTime({Key? key, this.title, this.color}) : super(key: key);
  final String? title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(title ?? '',style: appStyle.textTheme.bodyText2?.apply(color: Colors.black),),
        ),
        const SizedBox(height: 2,),
        CustomPaint(
          painter: IndicatorPain(color:color),
        )
      ],
    );
  }
}

class IndicatorPain extends CustomPainter {
  Paint? painter;
  Color? color;

  IndicatorPain({this.color}) {
    painter = Paint()..color = color ?? Colors.transparent;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(10, 0)
      ..lineTo(10, 15)
      ..lineTo(5, 18)
      ..lineTo(0, 15)
      ..lineTo(0, 0);
    canvas.drawPath(path, painter!);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
