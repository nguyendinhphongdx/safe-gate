import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/profile/report_profile_model.dart';
import 'package:base_pm2/domain/repository/device/device_repository.dart';

class GetHistoryByDeviceIdUseCase extends BaseUseCase<ApiResponse<ReportProfileModel?>> {
  final DeviceRepository repository;
  final String? deviceId;
  final String? profileId;
  final String? dateTime;

  GetHistoryByDeviceIdUseCase({required this.repository, this.deviceId, this.profileId, this.dateTime});

  @override
  Future<ApiResponse<ReportProfileModel?>> invoke() async {
    // ReportProfileModel.fromJson(json)
    //
    // ApiResponse<dynamic>response = await repository.getHistoryByProfileId(deviceId, profileId, dateTime);
    // List<String>? keys  = response.allData?['keys']?.cast<String>();
    // Map<String,dynamic>? data = response.allData?['data'];
    // keys?.map((key){
    //
    // });
    // ReportProfileModel reportProfileModel = ReportProfileModel()

    return await repository.getHistoryByProfileId(deviceId, profileId, dateTime);
  }

  @override
  void validate() {
    notNullOrEmpty(deviceId);
    notNullOrEmpty(profileId);
  }
}
