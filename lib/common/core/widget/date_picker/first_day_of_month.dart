import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/date_picker/body_picker.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';

class FirstDayOfMonth extends StatefulWidget {
  const FirstDayOfMonth({Key? key, this.entity, this.onPressed}) : super(key: key);
  final CalendarEntity? entity;
  final VoidCallback? onPressed;

  @override
  State<FirstDayOfMonth> createState() => _FirstDayOfMonthState();
}

class _FirstDayOfMonthState extends State<FirstDayOfMonth> {
  DateTime get now => DateTime.now();

  void onDayPressed() {
    widget.entity?.isSelected = true;
    widget.entity?.selectedAt = DateTime.now();
    widget.onPressed?.call();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.entity?.dateTime?.isAfter(DateTime.now()) ?? false ? null : onDayPressed,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(color: _getColor(), borderRadius: _getRadius()),
            child: Stack(children: [
              Align(
                  alignment: Alignment.center,
                  child: Text('${widget.entity?.dateTime?.day}',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _getTextColor()))),
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 16),
                      child: Text('/${widget.entity?.dateTime?.month}',
                          style: appStyle.textTheme.bodyText1?.copyWith(
                              color: widget.entity?.dateTime?.isAfter(now) ?? false
                                  ? Colors.red.withOpacity(.5)
                                  : Colors.red,
                              fontSize: 10))))
            ])));
  }

  Color _getColor() {
    if (widget.entity?.isSelected ?? false) return ColorResource.day_section;
    if (widget.entity?.isActive ?? false) return ColorResource.date_range_section.withOpacity(.6);
    return ColorResource.date_range_section.withOpacity(.0);
  }

  Color _getTextColor() {
    if (widget.entity?.dateTime?.isAfter(now) ?? false) return ColorResource.tabIndicator.withOpacity(.6);
    if (widget.entity?.isSelected ?? false) return Colors.white;

    return ColorResource.tabIndicator;
  }

  BorderRadius _getRadius() {
    if (widget.entity?.isEnd ?? false) {
      return const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8));
    }
    if (widget.entity?.isStart ?? false) {
      return const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8));
    }
    if ((widget.entity?.isActive ?? false) && widget.entity?.dateTime?.weekday == 7) {
      return const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8));
    }
    if ((widget.entity?.isActive ?? false) && widget.entity?.dateTime?.weekday == 1) {
      return const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8));
    }
    if (widget.entity?.isActive ?? false) return BorderRadius.zero;
    return BorderRadius.circular(8);
  }
}
