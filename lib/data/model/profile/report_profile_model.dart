import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/data/model/report/report_model.dart';

class ReportProfileModel {
  List<AppReportDayModel?>? apps;
  List<AppReportDataModel?>? reportModels;
  List<int?>? appIds;
  int? capacityMax;
  int? capacityMin;

  ReportProfileModel();

  ReportProfileModel.fromJson(Map<String, dynamic> json) {
    appIds = [];
    apps = [];
    List<String>? keys = json['keys'].cast<String>();
    keys?.sort((s1, s2) => int.tryParse(s2)?.compareTo(int.tryParse(s1) ?? -1) ?? 0);
    Map<String, dynamic>? mapApplications = json['data'];
    Set<int?> applicationIds = {};

    reportModels = keys?.map((key) {
      List<Map<String, dynamic>> mAppDays = mapApplications?[key].cast<Map<String, dynamic>>();

      List<AppReportDayModel> mapperAppDays = mAppDays.map((e) {
        AppReportDayModel dayModel = AppReportDayModel.fromJson(e);

        apps?.add(dayModel);

        applicationIds.add(dayModel.appId);

        return dayModel;
      }).toList();

      return AppReportDataModel(dayReports: mapperAppDays, day: DateTimeUtils.toTimeFormat(key));
    }).toList();

    apps =
        applicationIds.map((appId) => apps?.where((element) => element?.appId == appId).firstOrNull).toList();

    apps?.sort((a1, a2) => a1?.capacity?.compareTo(a2?.capacity ?? -1) ?? 0);

    apps?.forEachIndexed((index, element) => element?.color = AppConfig().mColors[index]);

    capacityMax = apps?.lastOrNull?.capacity;

    capacityMin = apps?.firstOrNull?.capacity;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    return data;
  }
}
