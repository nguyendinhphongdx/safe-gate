import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/sys/cron_time_parser.dart';
import 'package:base_pm2/common/core/widget/dialog/custom_pop_up_menu_button.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationModel {
  String? domain;
  String? icon;
  String? label;
  int? priority;
  int? applicationId;
  String? categoryName;
  int? categoryId;
  RxBool? isActive = false.obs;

  List<RuleAppModel>? ruleModels;
  RxList<RuleAppModel>? rxRuleModels;
  ExpandableController? expController;
  RxBool? isTimeActive;
  RxString? rxType;
  GlobalKey<PopupMenuButtonState> popupKey = GlobalKey<PopupMenuButtonState>();

  ApplicationModel(
      {this.domain,
      this.icon,
      this.label,
      this.priority,
      this.isActive,
      this.applicationId,
      this.categoryName,
      this.ruleModels,
      this.categoryId});

  ApplicationModel.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    icon = json['icon'];
    label = json['label'];
    priority = json['priority'];
    applicationId = json['application_id'];
    categoryName = json['categoryName'];
    categoryId = json['categoryId'];
    expController = ExpandableController();
    isTimeActive = false.obs;
    rxType = ''.obs;
    rxRuleModels = <RuleAppModel>[].obs;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['domain'] = domain;
    data['icon'] = icon;
    data['label'] = label;
    data['priority'] = priority;
    data['application_id'] = applicationId;
    data['categoryName'] = categoryName;
    data['categoryId'] = categoryId;
    return data;
  }
}

class RuleAppParentModel {
  int? id;
  List<RuleAppModel>? rules;

  RuleAppParentModel({this.id, this.rules});
}

class RuleAppModel {
  int? id;
  RxString? startTime;
  RxString? endTime;
  String? startTimePattern;
  String? endTimePattern;

  String? type;
  GlobalKey<CustomPopupMenuButtonState>? startKey;
  GlobalKey<CustomPopupMenuButtonState>? endKey;
  RxBool? isActiveStart;
  RxBool? isActiveEnd;
  RxBool? isActiveTime;
  RxList<AppDayModel>? dayModel;

  RuleAppModel(
      {this.startTime,
      this.endTime,
      this.type,
      this.startKey,
      this.startTimePattern,
      this.endTimePattern,
      this.endKey,
      this.isActiveEnd,
      this.dayModel,
      this.isActiveStart}) {
    isActiveTime ??= true.obs;
  }

  RuleAppModel.fromJson(Map<String, dynamic> json) {
    startTime = '00:00'.obs;
    endTime = '00:00'.obs;
    if (json['startTime'] != null && json['startTime'] != null) {
      CronTimeParser parser = CronTimeParser()..parse(json['startTime']);
      startTime = '${parser.hour}:${parser.minute}'.obs;
      CronTimeParser parserEnd = CronTimeParser()..parse(json['endTime']);
      endTime = '${parserEnd.hour}:${parserEnd.minute}'.obs;
      _addDayModelIfNotExist();
      parser.weekday?.forEach((weekDay) {
        dayModel?.singleWhereOrNull((element) => weekDay == element.id)?.isActive?.value = true;
      });
      startTimePattern = CronTimeParser(
              hour: CronTimeParser.getHour(startTime?.value),
              minute: CronTimeParser.getMinute(startTime?.value),
              weekday: dayModel
                      ?.where((p0) => p0.isActive?.value ?? false)
                      .map((element) => element.id ?? -1)
                      .toList() ??
                  [])
          .toCron();
      endTimePattern = CronTimeParser(
              hour: CronTimeParser.getHour(endTime?.value),
              minute: CronTimeParser.getMinute(endTime?.value),
              weekday: dayModel
                      ?.where((p0) => p0.isActive?.value ?? false)
                      .map((element) => element.id ?? -1)
                      .toList() ??
                  [])
          .toCron();
    }

    type = json['type'];
    startKey = GlobalKey();
    endKey = GlobalKey();
    isActiveStart = false.obs;
    isActiveEnd = false.obs;
    isActiveTime = true.obs;
  }

  RuleAppModel.copy(RuleAppModel? ruleAppModel) {

    startTime = '00:00'.obs;
    endTime = '00:00'.obs;
    if (ruleAppModel?.startTime?.value != null) startTime?.value = ruleAppModel!.startTime!.value;
    if (ruleAppModel?.endTime?.value != null) endTime?.value = ruleAppModel!.endTime!.value;

    CronTimeParser parser = CronTimeParser()..parse(ruleAppModel?.startTimePattern);
    startTime = '${parser.hour}:${parser.minute}'.obs;
    CronTimeParser parserEnd = CronTimeParser()..parse(ruleAppModel?.endTimePattern);
    endTime = '${parserEnd.hour}:${parserEnd.minute}'.obs;
    _addDayModelIfNotExist();
    parser.weekday?.forEach((weekDay) {
      dayModel?.singleWhereOrNull((element) => weekDay == element.id)?.isActive?.value = true;
    });
    startTimePattern = CronTimeParser(
            hour: CronTimeParser.getHour(startTime?.value),
            minute: CronTimeParser.getMinute(startTime?.value),
            weekday:  ruleAppModel?.dayModel
                    ?.where((p0) => p0.isActive?.value ?? false)
                    .map((element) => element.id ?? -1)
                    .toList() ??
                [])
        .toCron();
    endTimePattern = CronTimeParser(
            hour: CronTimeParser.getHour(endTime?.value),
            minute: CronTimeParser.getMinute(endTime?.value),
            weekday:  ruleAppModel?.dayModel
                    ?.where((p0) => p0.isActive?.value ?? false)
                    .map((element) => element.id ?? -1)
                    .toList() ??
                [])
        .toCron();

    type = ruleAppModel?.type;
    startKey = GlobalKey();
    endKey = GlobalKey();
    isActiveStart = false.obs;
    isActiveEnd = false.obs;
    isActiveTime = true.obs;
    isActiveStart?.value = ruleAppModel?.isActiveStart?.value ?? false;
    isActiveEnd?.value = ruleAppModel?.isActiveEnd?.value ?? false;
    isActiveTime?.value = ruleAppModel?.isActiveTime?.value ?? true;

    showLog('startTime: ${ruleAppModel?.startTime?.value}');
    showLog('endTime: ${ruleAppModel?.endTime?.value}');
  }

  void _addDayModelIfNotExist() {
    dayModel = [2, 3, 4, 5, 6, 7, 8]
        .mapIndexed(
            (index, e) => AppDayModel(id: e, isActive: false.obs, title: DateTimeUtils.convertWeekDay(e)))
        .toList()
        .obs;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startTime'] = startTimePattern;
    data['endTime'] = endTimePattern;
    data['type'] = type;
    return data;
  }
}

class AppDayModel {
  int? id;
  String? title;
  RxBool? isActive;

  AppDayModel({this.id, this.title, this.isActive});
}
