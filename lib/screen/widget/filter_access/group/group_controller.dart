import 'dart:convert';

import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/core/sys/cron_time_parser.dart';
import 'package:base_pm2/common/core/widget/dialog/app_dialog_comp.dart';
import 'package:base_pm2/common/helper/constant.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/common/resource/keylanguage_resource/key_language.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/data/model/widget/category_model.dart';
import 'package:base_pm2/data/model/widget/get_all_group_application_use_case.dart';
import 'package:base_pm2/data/repositories_impl/device/device_repository_impl.dart';
import 'package:base_pm2/data/repositories_impl/widget/category_repository_impl.dart';
import 'package:base_pm2/domain/use_case/widget/update_rule_use_case.dart';
import 'package:base_pm2/screen/widget/user_detail_setting/user_detail_setting_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_manager.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupController extends BaseController {
  RxList<CategoryModel?> mGroupApps = <CategoryModel?>[].obs;

  @override
  Future initialData() async {
    await fetchData();
  }

  @override
  Future<void> fetchData() async {
    if (await getConnection(reconnect: fetchData)) return;
    List<String>? catIds = Get.find<UserDetailSettingController>().contextModel?.categoryIds;
    // if (!Utils.isNotNullAndEmpty(catIds)) return;
    // Get.find<UserDetailSettingController>().contextModel?.categoryRules?.forEach((element) {
    //   showLog(jsonEncode(element.rules));
    //   showLog(element.id);
    // });
    ApiResponse<List<CategoryModel?>?> response = await GetAllGroupApplicationUseCase(
            repository: CategoryRepositoryImpl(),
            categoryIds: catIds,
            rules: Get.find<UserDetailSettingController>().contextModel?.categoryRules)
        .invoke();
    if (checkCode(response)) return;
    mGroupApps.value = response.data ?? [];

    mGroupApps.forEach((element) {
      element?.rxType?.value = element.ruleModels?.firstOrNull?.type ?? ModeType.UN_LIMIT;
      element?.rxRuleModels?.value = (element.ruleModels ?? []).obs;
    });
    setStatus(Status.success);
  }

  onOptionSelected(CategoryModel? model) {
    model?.popupKey.currentState?.showButtonMenu();
  }

  onMenuSelected(String value, CategoryModel? model) async {
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
    model?.rxType?.value = value;

    _onUpdateTime(model);
  }

  onChangeStartTime(RuleAppModel? timeModel) {
    timeModel?.isActiveStart?.value = true;
    timeModel?.startKey?.currentState?.showButtonMenu();
  }

  onDeleteTime(RuleAppModel value, RxList<RuleAppModel>? rxRuleModels, CategoryModel? model) {
    Get.dialog(AppDialogComp(
        content: '${KeyLanguage.ask_sure_delete.tr} ${value.startTime} - ${value.endTime}?',
        onConfirm: () {
          rxRuleModels?.remove(value);
          _onUpdateTime(model);
          Get.back();
        }));
  }

  onAddTime(RxList<RuleAppModel>? rxRuleModels, CategoryModel? model) {
    rxRuleModels?.add(RuleAppModel(
        startTime: '00:00'.obs,
        endTime: '00:00'.obs,
        startKey: GlobalKey(),
        endKey: GlobalKey(),
        isActiveStart: false.obs,
        isActiveEnd: false.obs,
        type: model?.rxType?.value,
        dayModel: <AppDayModel>[
          AppDayModel(id: 2, title: 'T2', isActive: false.obs),
          AppDayModel(id: 3, title: 'T3', isActive: false.obs),
          AppDayModel(id: 4, title: 'T4', isActive: false.obs),
          AppDayModel(id: 5, title: 'T5', isActive: false.obs),
          AppDayModel(id: 6, title: 'T6', isActive: false.obs),
          AppDayModel(id: 7, title: 'T7', isActive: false.obs),
          AppDayModel(id: 8, title: 'CN', isActive: false.obs),
        ].obs));
  }

  onSelectedStartTime(String v, RuleAppModel? timeModel, CategoryModel? application) {
    timeModel?.isActiveStart?.value = false;
    timeModel?.startTime?.value = v;
    // Chỗ này cần phải check ngày và check cả tính hợp lệ thời gian
    _onUpdateTime(application);
  }

  onCancelStartTime(RuleAppModel? timeModel) {
    timeModel?.isActiveStart?.value = false;
  }

  onChangeEndTime(RuleAppModel? timeModel) {
    timeModel?.isActiveEnd?.value = true;
    timeModel?.endKey?.currentState?.showButtonMenu();
  }

  onSelectedEndTime(String v, RuleAppModel? timeModel, CategoryModel? application) {
    timeModel?.isActiveEnd?.value = false;
    timeModel?.endTime?.value = v;
    // Chỗ này cần phải check ngày và check cả tính hợp lệ thời gian
    _onUpdateTime(application);
  }

  onCancelEndTime(RuleAppModel? timeModel) {
    timeModel?.isActiveEnd?.value = false;
  }

  onDayChangeStatus(AppDayModel element, CategoryModel? application) {
    element.isActive?.value = !element.isActive!.value;
    // Chỗ này cần phải check tính hợp lệ của thời gian và thời gian có hợp lệ hay không
    _onUpdateTime(application);
  }

  void _onUpdateTime(CategoryModel? application) async {
    if (validateTime(application)) return;
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
              applicationId: int.tryParse(application?.categoryId.toString() ?? '-1'), ruleModels: rules)
        ]).invoke();
    if (checkCode(response)) return;
    Get.find<UserDetailSettingController>().fetchData();
  }

  bool validateTime(CategoryModel? application) {
    return false;
  }
}
