import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/core/sys/cron_time_parser.dart';
import 'package:base_pm2/common/helper/constant.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/common/core/interface/i_config_time_listener.dart';
import 'package:base_pm2/data/repositories_impl/device/device_repository_impl.dart';
import 'package:base_pm2/domain/use_case/widget/update_rule_use_case.dart';
import 'package:base_pm2/screen/widget/filter_access/app_web/app_web_controller.dart';
import 'package:base_pm2/screen/widget/user_detail_setting/user_detail_setting_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditTimeArgs {
  RuleAppModel? timeModel;
  ApplicationModel? application;

  EditTimeArgs({this.timeModel, this.application});
}

class EditTimeController extends BaseController with IConfigTimeListener {
  EditTimeArgs? args;
  RuleAppModel? timeModel;
  ApplicationModel? application;

  @override
  Future initialData() async {
    args = Get.arguments;
    if (args?.timeModel != null) {
      timeModel = RuleAppModel.copy(args?.timeModel);
    } else {
      timeModel = RuleAppModel(
          startTime: '00:00'.obs,
          endTime: '00:30'.obs,
          startKey: GlobalKey(),
          endKey: GlobalKey(),
          isActiveStart: false.obs,
          isActiveEnd: false.obs,
          type: ModeType.LIMIT,
          dayModel: <AppDayModel>[
            AppDayModel(id: 2, title: 'T2', isActive: false.obs),
            AppDayModel(id: 3, title: 'T3', isActive: false.obs),
            AppDayModel(id: 4, title: 'T4', isActive: false.obs),
            AppDayModel(id: 5, title: 'T5', isActive: false.obs),
            AppDayModel(id: 6, title: 'T6', isActive: false.obs),
            AppDayModel(id: 7, title: 'T7', isActive: false.obs),
            AppDayModel(id: 8, title: 'CN', isActive: false.obs),
          ].obs);
    }

    application = args?.application;
    await super.initialData();
  }

  @override
  Future<bool> onConfirmUpdate() async {
    setStatus(Status.waiting);
    // if (validateTime(application)) return;
    List<RuleAppModel>? rules = application?.rxRuleModels?.map((element) {
      String cronStart = CronTimeParser(
              hour: CronTimeParser.getHour(element.startTime?.value),
              minute: CronTimeParser.getMinute(element.startTime?.value),
              weekday: element.dayModel
                      ?.where((p0) => p0.isActive?.value ?? false)
                      .map((element) => element.id ?? -1)
                      .toList() ??
                  [])
          .toCron();
      String cronEnd = CronTimeParser(
              hour: CronTimeParser.getHour(element.endTime?.value),
              minute: CronTimeParser.getMinute(element.endTime?.value),
              weekday: element.dayModel
                      ?.where((p0) => p0.isActive?.value ?? false)
                      .map((element) => element.id ?? -1)
                      .toList() ??
                  [])
          .toCron();
      RuleAppModel rule = RuleAppModel(
          type: application?.rxType?.value, startTimePattern: cronStart, endTimePattern: cronEnd);
      return rule;
    }).toList() ?? [];
    if (args?.timeModel == null) {
      rules.add(timeModel!);
    }
    ApiResponse<dynamic> response = await UpdateRuleUseCase(
        repository: DeviceRepositoryImpl(),
        deviceId: AppConfig().getDeviceId(),
        profileId: ProfileManager().getProfile().profileId.toString(),
        dnsMode: Get.find<UserDetailSettingController>().contextModel?.dnsMode,
        apps: [
          ApplicationModel(
              applicationId: int.tryParse(application?.applicationId.toString() ?? '-1'), ruleModels: rules)
        ]).invoke();
    if (checkCode(response)) return true;
    await Get.find<UserDetailSettingController>().fetchData();
    await Get.find<AppWebController>().fetchData();
    setStatus(Status.success);
    Get.back();

    return false;
  }

  bool validateTime(ApplicationModel? application) {
    return false;
  }
}
