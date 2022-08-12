import 'package:base_pm2/common/core/widget/dialog/app_dialog_comp.dart';
import 'package:base_pm2/common/helper/constant.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class IConfigTimeListener {
  void onActiveChange(ApplicationModel? model) async {
    model?.isTimeActive?.value = !(model.isTimeActive?.value ?? false);
    if (await _onUpdateTime(model)) {
      model?.isTimeActive?.value = !(model.isTimeActive?.value ?? false);
    }
  }

  void addData() {}

  Future<void> onConfirmUpdate()async {}

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
    appTimeModels?.add(RuleAppModel(
        startTime: '00:00'.obs,
        endTime: '00:30'.obs,
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

  void onDayChangeStatus(AppDayModel element, ApplicationModel? application) {
    element.isActive?.value = !element.isActive!.value;
    // Chỗ này cần phải check tính hợp lệ của thời gian và thời gian có hợp lệ hay không
    // _onUpdateTime(application);
  }

  void onChangeStartTime(RuleAppModel? timeModel) {
    timeModel?.isActiveStart?.value = true;
    timeModel?.startKey?.currentState?.showButtonMenu();
  }

  void onSelectedStartTime(String? v, RuleAppModel? timeModel, ApplicationModel? application) {
    timeModel?.isActiveStart?.value = false;
    timeModel?.startTime?.value = v ?? '';
    // Chỗ này cần phải check ngày và check cả tính hợp lệ thời gian
    // _onUpdateTime(application);
  }

  void onSelectedEndTime(String? v, RuleAppModel? timeModel, ApplicationModel? application) {
    timeModel?.isActiveEnd?.value = false;
    timeModel?.endTime?.value = v ?? '';
    // Chỗ này cần phải check ngày và check cả tính hợp lệ thời gian
    // _onUpdateTime(application);
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

  Future<bool> _onUpdateTime(ApplicationModel? application);
}
