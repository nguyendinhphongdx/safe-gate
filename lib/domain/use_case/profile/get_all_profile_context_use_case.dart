import 'dart:async';

import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/data/model/context_model.dart';
import 'package:base_pm2/data/model/device/device_model.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/repositories_impl/device/device_repository_impl.dart';
import 'package:base_pm2/domain/repository/profile/profile_repository.dart';
import 'package:base_pm2/domain/use_case/device/get_all_device_connected_by_profile_id_use_case.dart';
import 'package:base_pm2/domain/use_case/device/get_violation_count_use_case.dart';
import 'package:base_pm2/domain/use_case/profile/get_context_by_profile_id_use_case.dart';

class GetAllProfileContextUseCase extends BaseUseCase<ApiResponse<List<ProfileModel?>?>> {
  final ProfileRepository repository;
  final String? deviceId;
  final List<String>? violationDates;

  GetAllProfileContextUseCase({this.violationDates, required this.repository, this.deviceId});

  @override
  Future<ApiResponse<List<ProfileModel?>?>> invoke() async {
    ApiResponse<List<ProfileModel?>?> response = await repository.getAllProfileByDeviceId(deviceId);
    if (isNotOk(response)) return response;

    // await Future.forEach<ProfileModel?>(response.data ?? [], _getContext);
    await Future.forEach<ProfileModel?>(response.data ?? [], _getEndUser);
    // await Future.forEach<ProfileModel?>(response.data ?? [], _getViolation);
    return response;
  }

  @override
  void validate() {
    notNullOrEmpty(deviceId);
  }

  FutureOr _getContext(ProfileModel? element) async {
    ApiResponse<ContextModel?> response = await GetContextByProfileIdUseCase(
            repository: DeviceRepositoryImpl(), profileId: element?.profileId.toString(), deviceId: deviceId)
        .invoke();
    if (isNotOk(response)) return;
    element?.context = response.data;
  }

  FutureOr _getEndUser(ProfileModel? element) async {
    ApiResponse<List<DeviceModel?>?> response = await GetAllDeviceByProfileIdUseCase(
            repository: DeviceRepositoryImpl(), deviceId: deviceId, profileId: element?.profileId.toString())
        .invoke();
    if (isNotOk(response)) return;
    element?.mEndUserDevices = response.data ?? [];
    // element?.deviceConnecting =
    //     element.mEndUserDevices?.where((element) => (element?.spentTime ?? 1) < 0.08).length ?? 0;
    element?.status.value = element.deviceConnecting == 0 ? UserStatus.OFFLINE : UserStatus.ACTIVE;
  }

  FutureOr _getViolation(ProfileModel? element) async {
    int count = await GetViolationCountByProfileIdUseCase(
            repository: DeviceRepositoryImpl(),
            deviceId: AppConfig().getDeviceId(),
            profileId: element?.profileId.toString(),
            dateTime: violationDates)
        .invoke();
    element?.violateCount = count;
  }
}
