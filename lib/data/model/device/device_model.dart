import 'package:base_pm2/common/helper/app_common.dart';
import 'package:get/get.dart';

class DeviceModel {
  int? createdTime;
  int? updatedTime;
  DeviceInfo? deviceInfo;
  String? macAddress;
  int? ignore;
  int? lastOnline;
  int? endDeviceId;
  String? deviceNameAlias;
  int? spentTime;
  int? status;
  RxBool? rxStatus;

  DeviceModel(
      {this.createdTime,
      this.updatedTime,
      this.deviceInfo,
      this.macAddress,
      this.ignore,
      this.lastOnline,
      this.endDeviceId,
      this.rxStatus,
      this.deviceNameAlias});

  DeviceModel.fromJson(Map<String, dynamic> json) {
    createdTime = json['created_time'];

    updatedTime = json['updated_time'];
    deviceInfo = json['device_info'] != null
        ? DeviceInfo.fromJson(json['device_info'])
        : null;
    macAddress = json['mac_address'];
    ignore = json['ignore'];
    status = json['status'];
    lastOnline = json['last_online'];
    endDeviceId = json['end_device_id'];
    deviceNameAlias = json['device_name_alias'];
    spentTime =
        Duration(seconds: DateTimeUtils.getSeconds() - (lastOnline ?? 0))
            .inHours;
    rxStatus = false.obs;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_time'] = createdTime;
    data['updated_time'] = updatedTime;
    data['spent_time'] = spentTime;
    data['status'] = status;
    if (deviceInfo != null) {
      data['device_info'] = deviceInfo!.toJson();
    }
    data['mac_address'] = macAddress;
    data['ignore'] = ignore;
    data['last_online'] = lastOnline;
    data['end_device_id'] = endDeviceId;
    data['device_name_alias'] = deviceNameAlias;
    return data;
  }
}

class DeviceInfo {
  String? macAddress;
  String? vendor;
  String? type;

  DeviceInfo({this.macAddress, this.vendor, this.type});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    macAddress = json['macAddress'];
    vendor = json['vendor'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['macAddress'] = macAddress;
    data['vendor'] = vendor;
    data['type'] = type;
    return data;
  }
}
