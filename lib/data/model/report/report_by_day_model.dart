import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/data/model/report/report_model.dart';
import 'package:collection/collection.dart';

class ReportByDayModel {
  List<AppReportDayModel?>? apps;
  List<AppReportDataModel?>? reportModels;
  List<int?>? appIds;
  int? capacityMax;
  int? capacityMin;

  ReportByDayModel();

  ReportByDayModel.fromJson(Map<String, dynamic> json) {
    appIds = [];
    apps = [];
    List<String>? keys = json['keys']?.cast<String>();
    keys?.sort((s1, s2) => s2.compareTo(s1));
    Set<int?> applicationIds = {};

    reportModels = keys?.map((key) {
      if (json['$key'] == null) return null;

      List<Map<String, dynamic>> mAppDays = json['$key'].cast<Map<String, dynamic>>();

      List<AppReportDayModel> mapperAppDays = mAppDays.map((e) {
        AppReportDayModel dayModel = AppReportDayModel.fromJson(e);

        apps?.add(dayModel);

        applicationIds.add(dayModel.appId);

        return dayModel;
      }).toList();

      return AppReportDataModel(dayReports: mapperAppDays, day: '$key');
    }).toList();
    reportModels?.removeWhere((element) => element == null);
    apps?.sort((a1, a2) => a1?.capacity?.compareTo(a2?.capacity ?? -1) ?? 0);
    capacityMax = apps?.lastOrNull?.capacity;

    capacityMin = apps?.firstOrNull?.capacity;
    apps = applicationIds
        .map<AppReportDayModel?>((appId) => apps?.where((element) => element?.appId == appId).firstOrNull)
        .toList();

    apps?.forEachIndexed((index, element) => element?.color = AppConfig().mColors[index]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    return data;
  }
}
