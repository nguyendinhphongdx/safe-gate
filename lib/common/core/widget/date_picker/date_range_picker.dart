import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangePicker extends StatelessWidget {
  const DateRangePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.6,
      child: SfDateRangePicker(
        view: DateRangePickerView.month,
        selectionMode: DateRangePickerSelectionMode.range,
        backgroundColor: Colors.white,
        // allowViewNavigation: false,

        rangeSelectionColor: ColorResource.date_range_section.withOpacity(.6),

        selectionColor: ColorResource.day_section,
        selectionShape: DateRangePickerSelectionShape.rectangle,
        selectionRadius: 16,
        selectionTextStyle: appStyle.textTheme.bodyText1?.apply(color: Colors.white),

        viewSpacing: 0,
        headerHeight: 20,
        monthFormat: 'EEE',

        // cellBuilder: _cellBuilder,

        navigationMode: DateRangePickerNavigationMode.scroll,

        rangeTextStyle: appStyle.textTheme.bodyText1?.apply(color: ColorResource.tabIndicator),

        maxDate: DateTime.now(),
        monthViewSettings: const DateRangePickerMonthViewSettings(
          firstDayOfWeek: 1,
          viewHeaderStyle: DateRangePickerViewHeaderStyle(),
        ),

        // toggleDaySelection: false,

        yearCellStyle: DateRangePickerYearCellStyle(
          todayTextStyle: appStyle.textTheme.bodyText1
              ?.copyWith(color: ColorResource.tabIndicator, fontWeight: FontWeight.w700),
          textStyle: appStyle.textTheme.bodyText1?.apply(color: Colors.red),
        ),

        enableMultiView: false,

        navigationDirection: DateRangePickerNavigationDirection.horizontal,

        monthCellStyle: DateRangePickerMonthCellStyle(
            textStyle: appStyle.textTheme.bodyText1?.apply(color: ColorResource.tabIndicator),
            cellDecoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            blackoutDateTextStyle:
                appStyle.textTheme.bodyText1?.apply(color: ColorResource.tabIndicator.withOpacity(.5))),

        initialSelectedRange:
            PickerDateRange(DateTime.now().subtract(const Duration(days: 30)), DateTime.now()),
      ),
    );
  }

  Widget _cellBuilder(BuildContext context, DateRangePickerCellDetails cellDetails) {
    showLog(cellDetails.visibleDates);
    if (cellDetails.date.day == 1) {
      return Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(cellDetails.date.day.toString(),
                style: appStyle.textTheme.bodyText1
                    ?.copyWith(color: ColorResource.tabIndicator, fontWeight: FontWeight.w700)),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 18),
              child: Text('/${cellDetails.date.month}',
                  style: appStyle.textTheme.subtitle2?.copyWith(color: Colors.red)),
            ),
          )
        ],
      );
    }
    if (cellDetails.date.isAfter(DateTime.now())) {
      return Container(
          alignment: Alignment.center,
          child: Text(cellDetails.date.day.toString(),
              style: appStyle.textTheme.bodyText1?.apply(color: ColorResource.tabIndicator.withOpacity(.6))));
    }
    return Container(
        alignment: Alignment.center,
        child: Text(cellDetails.date.day.toString(),
            style: appStyle.textTheme.bodyText1?.apply(color: ColorResource.tabIndicator)));
  }


}
