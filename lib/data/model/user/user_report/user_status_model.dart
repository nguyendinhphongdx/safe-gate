

import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/data/model/user/user_report/user_model.dart';

class UserStatusModel {
  UserStatusModel({
    this.user,
    this.spentTime,
    this.violateCount,
    this.permitStatus,
  });

  UserStatusModel.fromJson(dynamic json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    lastApp = json['last-app'];
    modeConfigId = json['mode-config-id'];
    spentTime = json['spenttime'];
    violateCount = json['violatecount'];
    connectedTime = json['connected-time'];
  }

  UserModel? user;
  double? spentTime;
  int? violateCount;
  bool? permitStatus;
  List<DeviceInfo>? devices;
  String? connectedTime;
  int? modeConfigId;
  String? lastApp;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['last-app'] = lastApp;
    data['mode-config-id'] = modeConfigId;
    data['spenttime'] = spentTime;
    data['violatecount'] = violateCount;
    data['connected-time'] = connectedTime;
    return data;
  }
}
