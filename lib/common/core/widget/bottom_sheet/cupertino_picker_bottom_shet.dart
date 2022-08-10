import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CupertinoPickerBottomSheet extends StatefulWidget {
  final int? minimumYear, maximumYear;
  final DateTime? minimumDate, maximumDate, initialDateTime;
  final CupertinoDatePickerMode? mode;
  final double? height;
  final bool? isShowCancel, isShowConfirm;

  const CupertinoPickerBottomSheet({
    Key? key,
    this.minimumYear,
    this.maximumYear,
    this.minimumDate,
    this.maximumDate,
    this.height,
    this.initialDateTime,
    this.isShowCancel,
    this.isShowConfirm,
    this.mode,
  }) : super(key: key);

  @override
  State<CupertinoPickerBottomSheet> createState() => _CupertinoPickerDialog();
}

class _CupertinoPickerDialog extends State<CupertinoPickerBottomSheet> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? ViewUtils.height * 0.3,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: widget.isShowCancel ?? false,
                child: TextButtonComp(
                  isTransparent: true,
                  title: KeyLanguage.cancel.tr,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: appStyle.textTheme.headline4!
                      .apply(color: ColorResource.primary),
                ),
              ),
              Visibility(
                visible: widget.isShowConfirm ?? false,
                child: TextButtonComp(
                  isTransparent: true,
                  title: KeyLanguage.confirm.tr,
                  onPressed: () {
                    Navigator.pop(context, dateTime);
                  },
                  style: appStyle.textTheme.headline4!
                      .apply(color: ColorResource.primary),
                ),
              )
            ],
          ),
          Expanded(
            child: CupertinoDatePicker(
              mode: widget.mode ?? CupertinoDatePickerMode.date,
              use24hFormat: true,
              minimumYear: widget.minimumYear ?? 1,
              maximumYear: widget.maximumYear,
              maximumDate: widget.maximumDate,
              minimumDate: widget.minimumDate,
              initialDateTime: widget.initialDateTime ??
                  dateTime.subtract(const Duration(days: 1)),
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  dateTime = newDate;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
