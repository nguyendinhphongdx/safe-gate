import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/data/model/context_model.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/data/model/report/report_model.dart';
import 'package:get/get.dart';

class ProfileModel {
  String? profileName;
  String? profileAvatar;
  String? lastApp;
  int? createdTime;
  int? updatedTime;
  @Deprecated('Sửa api mới bị mất')
  List<String>? endUserDevices;
  List<DeviceModel?>? mEndUserDevices;
  ContextModel? context;
  List<AppReportDataModel?>? reportModels;
  int? profileId;
  int? deviceConnecting;
  String? profileInfo;
  String? dnsMode;
  int? endDeviceId;
  int? violateCount;
  double? spentTime;
  RxBool isSelected = false.obs;
  RxString status = UserStatus.ACTIVE.obs;

  ProfileModel(
      {this.profileName,
      this.profileAvatar,
      this.createdTime,
        this.dnsMode,
      this.updatedTime,
      this.endUserDevices,
      this.profileId,
      this.profileInfo,
      this.endDeviceId});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    profileName = json['profile_name'];
    profileAvatar = json['profile_avatar'];
    createdTime = json['created_time'];
    updatedTime = json['updated_time'];
    lastApp = json['last_app'];
    dnsMode = json['dnsMode'];
    violateCount = json['violate_count'];
    spentTime = json['spentTime'];
    if (json['end_user_devices']!= null) {
      endUserDevices = json['end_user_devices'].cast<String>();
    }
    profileId = json['profile_id'];
    profileInfo = json['profile_info'];
    endDeviceId = json['end_device_id'];
    deviceConnecting = json['euDevices_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profile_name'] = profileName;
    data['profile_avatar'] = profileAvatar;
    data['violate_count'] = violateCount;
    data['last_app'] = lastApp;
    data['dnsMode'] = dnsMode;
    data['spentTime'] = spentTime;
    data['created_time'] = createdTime;
    data['updated_time'] = updatedTime;
    data['end_user_devices'] = endUserDevices;
    data['profile_id'] = profileId;
    data['profile_info'] = profileInfo;
    data['end_device_id'] = endDeviceId;
    return data;
  }
}
