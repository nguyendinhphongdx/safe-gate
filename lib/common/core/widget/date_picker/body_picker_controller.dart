import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/core/widget/date_picker/body_picker.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BodyPickerArgs {
  String? startTime;
  String? endTime;

  BodyPickerArgs({this.startTime, this.endTime});

  BodyPickerArgs.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['start_time'] = startTime ?? '';
    data['end_time'] = endTime ?? '';
    return data;
  }
}

class BodyPickerController extends BaseController {
  DateRangePickerController? dateRangePickerController;
  RxBool isValidate = false.obs;
  PickTimeModel? pickTimeModel;
  BodyPickerArgs? args;

  @override
  Future initialData() async {
    args = BodyPickerArgs.fromJson(Get.parameters);
    dateRangePickerController = DateRangePickerController();
    pickTimeModel = PickTimeModel(DateTimeUtils.parse(args?.startTime, DateTimeUtils.DDMMYYYY),
        DateTimeUtils.parse(args?.endTime, DateTimeUtils.DDMMYYYY));
  }

  void setHasPassValidate(bool b) {
    isValidate.value = b;
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs dateRangeArgs) {
    pickTimeModel?.setStartTime(dateRangeArgs.value.startDate);
    pickTimeModel?.setEndTime(dateRangeArgs.value.endDate);
    setHasPassValidate(false);
    if (dateRangeArgs.value is! PickerDateRange) return;
    DateTime? start = dateRangeArgs.value.startDate;
    if (start == null) return;
    DateTime? end = dateRangeArgs.value.endDate;
    if (end == null) return;
    int difference = end.difference(start).inDays;
    if (difference > 31) {
      ViewUtils.toast('Giới hạn 30 ngày', mode: ToastMode.error);
      return;
    }
    setHasPassValidate(true);
  }
}
