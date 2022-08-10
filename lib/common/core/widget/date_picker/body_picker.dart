import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/button/button_dialog.dart';
import 'package:base_pm2/common/core/widget/date_picker/body_picker_controller.dart';
import 'package:base_pm2/common/core/widget/date_picker/header_picker.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BodyPickerPage extends GetWidget<BodyPickerController> {
  BodyPickerPage({Key? key}) : super(key: key) {
    Get.lazyPut(() => BodyPickerController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.fromLTRB(16, ViewUtils.height * 0.1, 16, 0),
        child: Container(
          decoration:
              BoxDecoration(color: ColorResource.buttonDialog, borderRadius: BorderRadius.circular(12)),
          constraints: BoxConstraints(maxHeight: ViewUtils.height * 0.75),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: InkWellComp(
                  isTransparent: true,
                  onTap: () => Get.back(),
                  paddingAll: 0,
                  child: Icon(
                    Icons.close_rounded,
                    size: 32,
                    color: ColorResource.tabIndicator.withOpacity(0.37),
                  ),
                ),
              ),
              const SizedBox(height: 0),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0), child: HeaderPicker()),
              const SizedBox(height: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SfDateRangePicker(
                    controller: controller.dateRangePickerController,
                    onSelectionChanged: controller.selectionChanged,
                    selectionMode: DateRangePickerSelectionMode.range,
                    selectionColor: ColorResource.day_section,
                    rangeSelectionColor: ColorResource.date_range_section.withOpacity(.6),
                    enableMultiView: true,
                    navigationDirection: DateRangePickerNavigationDirection.vertical,
                    backgroundColor: ColorResource.buttonDialog,
                    // view: DateRangePickerView.month,
                    showNavigationArrow: true,
                    selectionTextStyle: appStyle.textTheme.bodyText1?.apply(color: Colors.white),
                    rangeTextStyle: appStyle.textTheme.bodyText1?.apply(color: ColorResource.tabIndicator),
                    selectionRadius: 12,
                    selectionShape: DateRangePickerSelectionShape.rectangle,

                    initialSelectedRange: PickerDateRange(controller.pickTimeModel?.startTime, controller.pickTimeModel?.endTime),
                    maxDate: DateTime.now(),
                    headerStyle: DateRangePickerHeaderStyle(
                        textStyle: appStyle.textTheme.bodyText1
                            ?.copyWith(fontWeight: FontWeight.w700, color: ColorResource.tabIndicator),
                        backgroundColor: ColorResource.buttonDialog,
                        textAlign: TextAlign.center),

                    monthViewSettings: const DateRangePickerMonthViewSettings(
                        viewHeaderHeight: 0, enableSwipeSelection: true, firstDayOfWeek: 1),
                    navigationMode: DateRangePickerNavigationMode.scroll,
                  ),
                ),
              ),
              // const SizedBox(height: 8),
              Obx(
                () => ButtonDialog(
                  cancelLabel: 'Thoát',
                  confirmLabel: 'Áp dụng',
                  showShadow: false,
                  confirmColor: ColorResource.primary,
                  confirmTextColor: Colors.white,
                  onConfirm: _onConfirm,
                  onCancel: Get.back,
                  isEnable: controller.isValidate.value,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {}

  void _onConfirm() {
    Get.back(result: controller.pickTimeModel);
  }
}

class PickTimeModel {
  DateTime? startTime;
  DateTime? endTime;
  Rx<DateTime>? rxStartTime;
  Rx<DateTime>? rxEndTime;

  PickTimeModel(this.startTime, this.endTime) {
    rxStartTime = (startTime ?? DateTime.now()).obs;
    rxEndTime = (endTime ?? DateTime.now()).obs;
  }

  void setStartTime(DateTime? dateTime) {
    if (dateTime == null) return;
    startTime = dateTime;
  }

  void setEndTime(DateTime? dateTime) {
    if (dateTime == null) return;
    endTime = dateTime;
  }
}

class CalendarEntity {
  String? id;
  DateTime? dateTime;
  DateTime? selectedAt;
  bool? isActive;
  bool? isSelected;
  bool? isStart;
  bool? isEnd;

  CalendarEntity({this.id, this.dateTime, this.isActive, this.isSelected, this.selectedAt}) {
    id ??= dateTime.toString();
    isActive ??= false;
    isSelected ??= false;
    isStart ??= false;
    isEnd ??= false;
  }

  @override
  String toString() {
    return 'id: $id | selectedAt: $selectedAt';
  }
}
