import 'package:base_pm2/common/core/sys/api_extension.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/network/client.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/domain/repository/widget/application_repository.dart';

class ApplicationRepositoryImpl implements ApplicationRepository {
  ApplicationRepositoryImpl._internal();

  static final ApplicationRepositoryImpl _impl = ApplicationRepositoryImpl._internal();

  factory ApplicationRepositoryImpl() => _impl;

  @override
  Future<ApiResponse<List<ApplicationModel?>?>> getAllApplications() async {
    return await Client()
        .service
        .getAllDefaultApplication()
        .wrap(cast: (json) => ApplicationModel.fromJson(json));
  }

  @override
  Future<ApiResponse<List<ApplicationModel?>?>> getApplicationsByIds(List<String> appIds) {
    return Client()
        .service
        .getApplicationByIds({'app_id': appIds}).wrap(cast: (json) => ApplicationModel.fromJson(json));
  }

  @override
  Future<ApiResponse<List<ApplicationModel?>?>> getApplicationsByKeyword(String? keyword) async {
    return Client()
        .service
        .addApplicationDevice(keyword ?? ' ')
        .wrap(cast: (json) => ApplicationModel.fromJson(json));
  }

  @override
  Future<ApiResponse<List<ApplicationModel?>?>> confirmAddApplication(
      String? deviceId, String? profileId, String? dnsMode, List<ApplicationModel?> applications) {
    Map<String, dynamic> contexts = {};
    applications.forEach((element) {
      contexts
          .addAll({element!.applicationId.toString(): element.ruleModels?.map((e) => e.toJson()).toList()});
    });

    // TODO: implement confirmAddApplication
    Map<String, dynamic> body = {'dnsMode': dnsMode, 'contexts': contexts};
    return Client().service.confirmAddApplication(deviceId, profileId, body).wrap();
  }
}
