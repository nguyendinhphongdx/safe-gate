import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/date_picker/body_picker.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:flutter/material.dart';

class NomalDate extends StatefulWidget {
  const NomalDate({Key? key, this.entity, this.onPressed}) : super(key: key);
  final CalendarEntity? entity;
  final VoidCallback? onPressed;

  @override
  State<NomalDate> createState() => _NomalDateState();
}

class _NomalDateState extends State<NomalDate> {
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
            alignment: Alignment.center,
            decoration: BoxDecoration(color: _getColor(), borderRadius: _getRadius()),
            child: Text('${widget.entity?.dateTime?.day}',
                style: appStyle.textTheme.bodyText1?.copyWith(color: _getTextColor()))));
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
