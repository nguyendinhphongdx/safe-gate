

import 'package:base_pm2/data/model/user/user_report/application_reports_model.dart';

import 'user_status_model.dart';

class UserReportModel {
  UserReportModel({
    this.uid,
    this.userStatus,
    this.applicationReports,
  });

  UserReportModel.fromJson(dynamic json) {
    uid = json['uid'];
    userStatus = json['userstatus'] != null
        ? UserStatusModel.fromJson(json['userstatus'])
        : null;
    if (json['applicationreports'] != null) {
      applicationReports = [];
      json['applicationreports'].forEach((v) {
        applicationReports?.add(ApplicationReportsModel.fromJson(v));
      });
    }
  }

  String? uid;
  UserStatusModel? userStatus;
  List<ApplicationReportsModel>? applicationReports;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = uid;
    if (userStatus != null) {
      map['userstatus'] = userStatus?.toJson();
    }
    if (applicationReports != null) {
      map['applicationreports'] =
          applicationReports?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
