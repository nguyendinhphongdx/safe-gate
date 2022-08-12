import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';

class DeviceConnectedModel{
  List<DeviceModel?>? devices;
  List<ProfileModel?>? profiles;

  DeviceConnectedModel({this.devices, this.profiles});
}