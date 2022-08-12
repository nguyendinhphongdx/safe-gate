import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/data/repositories_impl/device/device_repository_impl.dart';
import 'package:base_pm2/domain/use_case/device/get_all_device_connected_by_profile_id_use_case.dart';
import 'package:base_pm2/domain/use_case/device/get_violation_count_use_case.dart';

class ViolationDeviceModel {
  int? violationCount;
  int? deviceUsedCount;

  ViolationDeviceModel({this.violationCount, this.deviceUsedCount});
}

class GetViolationAndDeviceCountByProfileUseCase extends BaseUseCase<ViolationDeviceModel> {
  final String? deviceId;
  final String? profileId;
  final List<String>? dateTimes;

  GetViolationAndDeviceCountByProfileUseCase({this.deviceId, this.profileId, this.dateTimes});

  @override
  Future<ViolationDeviceModel> invoke() async {
    int violationCount = await GetViolationCountByProfileIdUseCase(
            repository: DeviceRepositoryImpl(), dateTime: dateTimes, deviceId: deviceId, profileId: profileId)
        .invoke();
    ApiResponse<List<DeviceModel?>?> response = await GetAllDeviceByProfileIdUseCase(
            repository: DeviceRepositoryImpl(), deviceId: deviceId, profileId: profileId)
        .invoke();

    DateTime startTime = DateTimeUtils.parse(
            DateTimeUtils.getTitleReport(dateTimes?.lastOrNull, withTextConverter: false),
            DateTimeUtils.DDMMYYYY) ??
        DateTime.now();

    DateTime endTime = DateTimeUtils.parse(
            DateTimeUtils.getTitleReport(dateTimes?.firstOrNull, withTextConverter: false),
            DateTimeUtils.DDMMYYYY) ??
        DateTime.now();

    List<DeviceModel?> devices = response.data
            ?.where((element) =>
                (element?.lastOnline ?? -1) > DateTimeUtils.getSeconds(date: startTime) &&
                (element?.lastOnline ?? -1) < DateTimeUtils.getSeconds(date: endTime))
            .toList() ??
        [];

    return ViolationDeviceModel(deviceUsedCount: devices.length, violationCount: violationCount);
  }

  @override
  void validate() {
    notNullOrEmpty(deviceId);
    notNullOrEmpty(profileId);
    notNullOrEmpty(dateTimes);
  }
}
