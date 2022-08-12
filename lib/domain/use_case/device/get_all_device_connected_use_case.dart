import 'dart:async';
import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/data/model/device/device_connected_model.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/repositories_impl/device/user_device_management_repository_impl.dart';
import 'package:base_pm2/data/repositories_impl/profile/profile_repository_impl.dart';
import 'package:base_pm2/domain/use_case/device/get_all_device_un_manager_use_case.dart';
import 'package:base_pm2/domain/use_case/profile/get_all_profile_context_use_case.dart';

class GetAllDeviceConnectedUseCase extends BaseUseCase<DeviceConnectedModel?> {
  final String? deviceId;
  final String? deviceStatus;

  GetAllDeviceConnectedUseCase({this.deviceStatus, this.deviceId});

  @override
  Future<DeviceConnectedModel?> invoke() async {
    DeviceConnectedModel connectedModel = DeviceConnectedModel();
    ApiResponse<List<DeviceModel?>?> deviceData = await GetAllDeviceUnManagerUseCase(
            repository: UserDeviceManagementRepositoryImpl(), deviceId: deviceId, deviceStatus: deviceStatus)
        .invoke();
    connectedModel.devices = deviceData.data ?? [];

    ApiResponse<List<ProfileModel?>?> profileData = await GetAllProfileContextUseCase(
        repository: ProfileRepositoryImpl(),
        deviceId: deviceId,
        violationDates: [DateTimeUtils.format(DateTime.now(), DateTimeUtils.YYYYMMDD) ?? '']).invoke();

    connectedModel.profiles = profileData.data ?? [];
    connectedModel.profiles?.removeWhere((element) => !Utils.isNotNullAndEmpty(element?.mEndUserDevices));

    // await Future.forEach<ProfileModel?>(connectedModel.profiles?.toList() ?? [], _getEndUserDevice);

    return connectedModel;
  }

  @override
  void validate() {
    notNullOrEmpty(deviceId);
  }
}
