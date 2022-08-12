import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/date_time_utils.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/resource/enum_resource.dart';
import 'package:base_pm2/data/model/widget/app/app_access_model.dart';
import 'package:base_pm2/data/repositories_impl/device/device_repository_impl.dart';
import 'package:base_pm2/domain/use_case/profile/get_violation_by_profile_id_use_case.dart';
import 'package:base_pm2/screen/profile/user_detail_history/violations/violations_controller.dart';
import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';

class TimeLineHistoryArgs {
  String? startTime; //dd/mm/yyyy
  String? endTime;
  String? profileId;

  TimeLineHistoryArgs({this.startTime, this.endTime, this.profileId});

  TimeLineHistoryArgs.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
    profileId = json['profile_id'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['start_time'] = startTime ?? '';
    data['end_time'] = endTime ?? '';
    data['profile_id'] = profileId ?? '';
    return data;
  }
}

class ViolationController extends BaseController {
  RxList<ViolationHeaderData> violationHeadersAll = <ViolationHeaderData>[].obs;
  TimeLineHistoryArgs? args;

  @override
  Future initialData() async {
    args = TimeLineHistoryArgs.fromJson(Get.parameters);
    initHeader();
    await fetchData();
  }

  void initHeader() {
    DateTime? startTime = DateTimeUtils.parse(args?.startTime, DateTimeUtils.DDMMYYYY);
    DateTime? endTime = DateTimeUtils.parse(args?.endTime, DateTimeUtils.DDMMYYYY);
    int diff = endTime?.difference(startTime!).inDays ?? 0;
    violationHeadersAll.value = List.generate(
      diff + 1,
      (index) => ViolationHeaderData(
        id: index,
        date: endTime?.subtract(Duration(days: index)),
        dateTime: DateTimeUtils.format(endTime?.subtract(Duration(days: index)), DateTimeUtils.YYYYMMDD),
        expandableController: index == 0 ? (ExpandableController()..toggle()) : null,
      ),
    );
  }

  @override
  Future<void> fetchData() async {
    if (!Utils.isNotNullAndEmpty(args?.profileId)) return;
    List<String> dates = violationHeadersAll.map((e) => e.dateTime ?? '').toList();
    ApiResponse<List<AppAccessParentModel?>?> response = await GetViolationByProfileIdUseCase(
            repository: DeviceRepositoryImpl(),
            dateTime: dates,
            deviceId: AppConfig().getDeviceId(),
            profileId: args?.profileId)
        .invoke();
    if (checkCode(response)) return;
    response.data?.forEach((element) {
      element?.appAccessParentRetail?.forEach((element) {
        showLog(element.appAccess);
      });
    });

    violationHeadersAll.forEach((element) {
      element.accessParentModel =
          response.data?.singleWhereOrNull((element1) => element.dateTime == element1?.date);
    });
    setStatus(Status.success);
  }
}

class ViolationFake {
  int? id;
  String? title;
  int? status;
  String? state;
  List<ViolationTypeFake>? types;

  ViolationFake(this.id, this.title, this.status, this.state, this.types);
}

class ViolationTypeFake {
  int? id;
  String? title;
  List<ViolationDetailFake>? details;

  ViolationTypeFake(this.id, this.title, this.details);
}

class ViolationDetailFake {
  int? id;
  String? title;
  String? time;

  ViolationDetailFake(this.id, this.title, this.time);
}
