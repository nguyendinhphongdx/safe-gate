import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/core/sys/cron_time_parser.dart';
import 'package:base_pm2/common/core/widget/dialog/app_dialog_comp.dart';
import 'package:base_pm2/common/core/widget/dialog/custom_pop_up_menu_button.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/data/repositories_impl/device/device_repository_impl.dart';
import 'package:base_pm2/domain/use_case/widget/get_application_by_profile_use_case.dart';
import 'package:base_pm2/domain/use_case/widget/update_rule_use_case.dart';
import 'package:base_pm2/screen/widget/edit_time/edit_time_controller.dart';
import 'package:base_pm2/screen/widget/user_detail_setting/user_detail_setting_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_manager.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AppWebController extends BaseController {
  RxList<ApplicationModel?> mApps = <ApplicationModel?>[].obs;
  RxList<ApplicationModel?> applications = <ApplicationModel?>[].obs;
  RxList<ApplicationModel?> applicationsIsChecked = <ApplicationModel>[].obs;

  @override
  Future initialData() async {
    fetchData();
  }

  @override
  Future<void> fetchData() async {
    List<String>? appIds = Get.find<UserDetailSettingController>().contextModel?.appIds;
    if (appIds == null) return;
    ApiResponse<List<ApplicationModel?>?> response = await GetApplicationByProfileIdsUseCase(
      appIds: appIds,
      rules: Get.find<UserDetailSettingController>().contextModel?.appRules,
    ).invoke();
    if (checkCode(response)) return;

    mApps.value = response.data ?? [];

    mApps.forEach((element) {
      element?.rxType?.value = element.ruleModels?.firstOrNull?.type ?? ModeType.UN_LIMIT;
      element?.rxRuleModels?.value = (element.ruleModels ?? []).obs;
    });

    // ApiResponse<List<ApplicationModel?>?> responseData =
    //     await GetAllApplicationUseCase(repository: ApplicationRepositoryImpl())
    //         .invoke();
    // applications.value = responseData.data ?? [];
    // List<ApplicationModel?> appOriginAdded = Get.find<AppWebController>().mApps;
    // appOriginAdded.forEach((element1) {
    //   applications.removeWhere(
    //       (element) => element?.applicationId == element1?.applicationId);
    // });
    // applicationsIsChecked.forEach((element1) {
    //   applications.removeWhere(
    //       (element) => element?.applicationId == element1?.applicationId);
    // });
  }

  void onActiveChange(ApplicationModel? model) async {
    model?.isTimeActive?.value = !(model.isTimeActive?.value ?? false);
    if (await _onUpdateTime(model)) {
      model?.isTimeActive?.value = !(model.isTimeActive?.value ?? false);
    }
  }

  void addData() {}

  void onOptionSelected([ApplicationModel? model]) {
    model?.popupKey.currentState?.showButtonMenu();
  }

  void onMenuSelected(String value, [ApplicationModel? model]) async {
    if (value == ModeType.UN_LIMIT) {
      await Get.dialog(AppDialogComp(
        content: 'Lựa chọn này sẽ xóa tất cả các thời gian đã cấu hình. Bạn có chắc chắn muốn đổi?',
        onConfirm: () {
          model?.rxType?.value = value;
          model?.rxRuleModels?.removeWhere((element) => true);
          Get.back();
          _onUpdateTime(model);
        },
      ));
      return;
    }
    String? s = model?.rxType?.value;
    model?.rxType?.value = value;

    if (await _onUpdateTime(model)) {
      model?.isTimeActive?.value = !(model.isTimeActive?.value ?? false);
    }
  }

  void onDeleteTime(RuleAppModel value, RxList<RuleAppModel>? ruleAppModels, ApplicationModel? model) {
    value.isActiveTime?.value = !(value.isActiveTime?.value ?? false);
    // Get.dialog(AppDialogComp(
    //     content:
    //         '${KeyLanguage.ask_sure_delete.tr} ${value.startTime} - ${value.endTime}?',
    //     onConfirm: () {
    //       ruleAppModels?.remove(value);
    //       _onUpdateTime(model);
    //       Get.back();
    //     }));
  }

  void onAddTime(List<RuleAppModel>? appTimeModels, ApplicationModel? model) {
    // appTimeModels?.add(RuleAppModel(
    //     startTime: '00:00'.obs,
    //     endTime: '00:30'.obs,
    //     startKey: GlobalKey(),
    //     endKey: GlobalKey(),
    //     isActiveStart: false.obs,
    //     isActiveEnd: false.obs,
    //     type: model?.rxType?.value,
    //     dayModel: <AppDayModel>[
    //       AppDayModel(id: 2, title: 'T2', isActive: false.obs),
    //       AppDayModel(id: 3, title: 'T3', isActive: false.obs),
    //       AppDayModel(id: 4, title: 'T4', isActive: false.obs),
    //       AppDayModel(id: 5, title: 'T5', isActive: false.obs),
    //       AppDayModel(id: 6, title: 'T6', isActive: false.obs),
    //       AppDayModel(id: 7, title: 'T7', isActive: false.obs),
    //       AppDayModel(id: 8, title: 'CN', isActive: false.obs),
    //     ].obs));
    Get.toNamed(RoutePath.EDIT_CONFIG_TIME, arguments: EditTimeArgs(application: model));
  }

  void onDayChangeStatus(AppDayModel element, ApplicationModel? application) {
    element.isActive?.value = !element.isActive!.value;
    // Chỗ này cần phải check tính hợp lệ của thời gian và thời gian có hợp lệ hay không
    _onUpdateTime(application);
  }

  void onChangeStartTime(RuleAppModel? timeModel) {
    timeModel?.isActiveStart?.value = true;
    timeModel?.startKey?.currentState?.showButtonMenu();
  }

  void onSelectedStartTime(String? v, RuleAppModel? timeModel, ApplicationModel? application) {
    timeModel?.isActiveStart?.value = false;
    timeModel?.startTime?.value = v ?? '';
    // Chỗ này cần phải check ngày và check cả tính hợp lệ thời gian
    _onUpdateTime(application);
  }

  void onSelectedEndTime(String? v, RuleAppModel? timeModel, ApplicationModel? application) {
    timeModel?.isActiveEnd?.value = false;
    timeModel?.endTime?.value = v ?? '';
    // Chỗ này cần phải check ngày và check cả tính hợp lệ thời gian
    _onUpdateTime(application);
  }

  void onCancelEndTime(RuleAppModel? timeModel) {
    timeModel?.isActiveEnd?.value = false;
  }

  void onChangeEndTime(RuleAppModel? timeModel) {
    timeModel?.isActiveEnd?.value = true;
    timeModel?.endKey?.currentState?.showButtonMenu();
  }

  void onCancelStartTime(RuleAppModel? timeModel) {
    timeModel?.isActiveStart?.value = false;
  }

  Future<bool> _onUpdateTime(ApplicationModel? application) async {
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
      RuleAppModel rule =
          RuleAppModel(type: application.rxType?.value, startTimePattern: cronStart, endTimePattern: cronEnd);
      return rule;
    }).toList();

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
    Get.find<UserDetailSettingController>().fetchData();
    return false;
  }

  bool validateTime(ApplicationModel? application) {
    return false;
  }


  void changeStatusOrigin(ApplicationModel? element) {
    element?.isActive?.value = !element.isActive!.value;
    applicationsIsChecked.add(element);
    applications.remove(element);
  }

  void onEditTime(RuleAppModel value, ApplicationModel? model) {
    Get.toNamed(RoutePath.EDIT_CONFIG_TIME, arguments: EditTimeArgs(application: model, timeModel: value));
  }
}

class AppModel {
  int? id;
  String? title;
  String? desc;
  RxString? label;
  AppExpandModel? appExpandModel;
  ExpandableController? expandController;
  RxBool? isExpand;
  GlobalKey<PopupMenuButtonState> popupKey = GlobalKey<PopupMenuButtonState>();

  AppModel({this.id, this.title, this.desc, this.appExpandModel, this.label}) {
    isExpand ??= false.obs;
    expandController = ExpandableController()
      ..addListener(() {
        isExpand?.value = expandController?.expanded ?? false;
      });
  }
}

class AppExpandModel {
  RxInt? id;
  RxString? title;
  RxBool? isTimeActive = false.obs;
  RxList<AppTimeModel>? appTimeModels;

  AppExpandModel({this.id, this.title, this.isTimeActive, this.appTimeModels});
}

class AppTimeModel {
  int? id;
  RxString? startTime;
  RxString? endTime;
  RxBool? isActiveStart;
  RxBool? isActiveEnd;
  GlobalKey<CustomPopupMenuButtonState>? startKey;
  GlobalKey<CustomPopupMenuButtonState>? endKey;
  RxList<AppDayModel>? dayModel;

  AppTimeModel(
      {this.id,
      this.startTime,
      this.endTime,
      this.dayModel,
      this.startKey,
      this.endKey,
      this.isActiveEnd,
      this.isActiveStart});
}
