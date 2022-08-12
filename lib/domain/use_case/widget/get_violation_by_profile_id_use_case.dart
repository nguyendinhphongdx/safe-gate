import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/data/model/widget/app/app_access_model.dart';
import 'package:base_pm2/domain/repository/device/device_repository.dart';

class GetViolationByProfileIdUseCase extends BaseUseCase<ApiResponse<List<AppAccessParentModel?>?>> {
  final DeviceRepository repository;
  final String? deviceId;
  final String? profileId;
  final List<String>? dateTime;

  GetViolationByProfileIdUseCase({required this.repository, this.deviceId, this.profileId, this.dateTime});

  @override
  Future<ApiResponse<List<AppAccessParentModel?>?>> invoke() async {
    ApiResponse response = await repository.getViolationByProfileId(deviceId, profileId, dateTime);
    if (isNotOk(response)) return ApiResponse.success([], e: response.err);

    List<String>? keys = response.allData?['keys']?.cast<String>();
    if (keys == null) return ApiResponse.success([], e: response.err);

    List<AppAccessParentModel?>? mListAppAcees = keys.map((e) {
      List<Map<String, dynamic>>? violations = response.allData?[e]?.cast<Map<String, dynamic>>();

      if (violations == null) return null;
      Set<int> times = {};
      int violateCount = 0;
      List<AppAccessModel> appAccesses = violations.map((e) {
        AppAccessModel appAccessModel = AppAccessModel.fromJson(e);
        violateCount += (appAccessModel.count ?? 0);
        appAccessModel.time?.forEach((element) => times.add(element));

        return appAccessModel;
      }).toList();


      List<int> timesTmp = times.toList()..sort((i0, i1) => i1.compareTo(i0));

      List<AppAccessParentModel> mListData = timesTmp
          .map((e) => AppAccessParentModel(
              date: DateTimeUtils.toTimeFormat(e.toString()),
              appAccess: appAccesses.where((element) => element.time?.contains(e) ?? false).toList()))
          .toList();

      // mListData.sort((t1, t2) =>
      // int.tryParse(t1.date ?? '')?.compareTo(int.tryParse(t2.date ?? '') ?? -1) ?? 0);

      return AppAccessParentModel(
          date: e, appAccess: appAccesses, appAccessParentRetail: mListData, countViolation: violateCount);
    }).toList();

    return ApiResponse.success(mListAppAcees, e: response.err);
  }

  @override
  void validate() {
    notNullOrEmpty(deviceId);
    notNullOrEmpty(profileId);
  }
}
