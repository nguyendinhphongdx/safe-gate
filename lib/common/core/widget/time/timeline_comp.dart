import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class TimeChild {
  Widget? startChild;
  Widget? endChild;
  Widget? indicator;
  double? indicatorSize;

  TimeChild({this.startChild, this.endChild, this.indicator, this.indicatorSize});
}

class TimelineComp extends StatelessWidget {
  const TimelineComp(
      {Key? key,
      this.children = const [],
      this.hasEndIndicator = true,
      this.indicatorMarginTop = 22,
      this.lineSize = 1,
      this.lineColor = Colors.white,
      this.endFlex,
      this.indicatorBackgroundColor,this.endIndicatorStart,
      this.startFlex})
      : super(key: key);
  final List<TimeChild> children;
  final bool hasEndIndicator;
  final double indicatorMarginTop;
  final double lineSize;
  final Color lineColor;
  final Color? indicatorBackgroundColor;
  final int? endFlex;
  final int? startFlex;
  final Widget? endIndicatorStart;

  @override
  Widget build(BuildContext context) {
    return Column(children: children.mapIndexed(_buildItem).toList());
  }

  Widget _buildItem(int index, TimeChild element) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             element.startChild ?? const SizedBox(),
              Column(
                children: [
                  if (index == 0) SizedBox(height: indicatorMarginTop),
                  if (index != 0) Container(width: lineSize, height: indicatorMarginTop, color: lineColor),
                  children[index].indicator ?? const TimeLineIndicator(),
                  Expanded(child: Container(width: lineSize, color: lineColor))
                ],
              ),
              Expanded(flex: endFlex ?? 1, child: element.endChild ?? const SizedBox()),
            ],
          ),
        ),
        if (index == children.length - 1 && hasEndIndicator)
          children[index].indicator ??
              Row(
                children: [
                  endIndicatorStart ?? const SizedBox(),
                  TimeLineIndicator(color: indicatorBackgroundColor),
                  Expanded(flex: endFlex ?? 1, child: const SizedBox()),
                ],
              ),
        if (index == children.length - 1) const SizedBox(height: 12),
      ],
    );
  }
}

class TimeLineIndicator extends StatelessWidget {
  const TimeLineIndicator({Key? key, this.color}) : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
          color:/* color ??*/ ColorResource.timeLineIndicator,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: Colors.white, width: 1.5)),
    );
  }
}
