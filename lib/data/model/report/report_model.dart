// ignore_for_file: unnecessary_string_interpolations

import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ReportModel {
  List<ProfileModel?>? profiles;
  List<AppReportDayModel?>? apps;
  List<int?>? appIds;
  int? capacityMax;
  int? capacityMin;

  ReportModel({this.profiles});

  ReportModel.fromJson(Map<String, dynamic> json) {
    appIds = [];
    apps = [];
    List<String>? keys = json['keys'].cast<String>();

    if (json['profiles'] == null) return;

    Map<String, dynamic>? mapProfile = json['profiles'];
    Map<String, dynamic>? mapApplications = json['data'];
    Set<int?> applicationIds = {};

    profiles = keys?.map((key) {
      ProfileModel model = ProfileModel.fromJson(mapProfile?['$key']);

      Map<String, dynamic>? appUser = mapApplications?['$key'];
      if (appUser == null) return null;

      List<String>? appKeys = appUser['keys']?.cast<String>();
      if (appKeys == null) return null;

      model.reportModels = appKeys.map<AppReportDataModel?>((appKey) {
        List<Map<String, dynamic>>? appData = appUser['$appKey']?.cast<Map<String, dynamic>>();

        if (appData == null) return null;

        List<AppReportDayModel>? mListDays = appData.map<AppReportDayModel>((element) {
          AppReportDayModel dayModel = AppReportDayModel.fromJson(element);

          apps?.add(dayModel);

          applicationIds.add(dayModel.appId);

          return dayModel;
        }).toList();

        return AppReportDataModel(day: '$appKey', dayReports: mListDays);
      }).toList();
      
      model.reportModels?.removeWhere((element) => element == null);
      return model;
    }).toList();
    
    profiles?.removeWhere((element) => element == null);

    apps?.sort((a1, a2) => a1?.capacity?.compareTo(a2?.capacity ?? -1) ?? 0);

    capacityMax = apps?.lastOrNull?.capacity;
    capacityMin = apps?.firstOrNull?.capacity;

    apps = applicationIds.map((appId) => apps?.firstWhere((element) => element?.appId == appId)).toList();

    apps?.forEachIndexed((index, element) => element?.color = AppConfig().mColors[index]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    return data;
  }
}

class AppReportDataModel {
  String? day;
  List<AppReportDayModel>? dayReports;

  AppReportDataModel({this.day, this.dayReports});
}

class AppReportDayModel {
  String? appAlias;
  int? appId;
  String? appFavicon;
  int? capacity;
  Color? color;

  AppReportDayModel({this.appAlias, this.appId, this.appFavicon, this.capacity});

  AppReportDayModel.fromJson(Map<String, dynamic> json) {
    appAlias = json['app_alias'];
    appId = json['app_id'];
    appFavicon = json['app_favicon'];
    capacity = json['capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_alias'] = appAlias;
    data['app_id'] = appId;
    data['app_favicon'] = appFavicon;
    data['capacity'] = capacity;
    return data;
  }
}
