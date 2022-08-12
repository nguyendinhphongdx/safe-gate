import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/data/repositories_impl/widget/application_repository_impl.dart';
import 'package:base_pm2/domain/use_case/widget/get_all_application_use_case.dart';
import 'package:base_pm2/domain/use_case/widget/get_application_by_ids_use_case.dart';
import 'package:collection/collection.dart';

class GetApplicationByProfileIdsUseCase extends BaseUseCase<ApiResponse<List<ApplicationModel?>?>> {
  final List<String>? appIds;
  final List<RuleAppParentModel>? rules;

  GetApplicationByProfileIdsUseCase({this.rules, this.appIds});

  @override
  Future<ApiResponse<List<ApplicationModel?>?>> invoke() async {
    List<ApplicationModel?> mListApplication = [];

    if (Utils.isNotNullAndEmpty(appIds)) {
      ApiResponse<List<ApplicationModel?>?> appProfiles =
          await GetApplicationByIdsUseCase(repository: ApplicationRepositoryImpl(), appIds: appIds).invoke();
      if (appProfiles.data != null) {
        mListApplication.addAll(appProfiles.data ?? []);
        mListApplication.forEach((element) {
          element?.ruleModels = rules?.singleWhereOrNull((rule) => rule.id == element.applicationId)?.rules;
        });
      }
    }

    ApiResponse<List<ApplicationModel?>?> allApp =
        await GetAllApplicationUseCase(repository: ApplicationRepositoryImpl()).invoke();
    appIds?.forEach((element) {
      allApp.data?.removeWhere((element1) => int.tryParse(element) == element1?.applicationId);
    });
    if (allApp.data != null) mListApplication.addAll(allApp.data ?? []);

    return ApiResponse.success(mListApplication);
  }

  @override
  void validate() {
    notNull(appIds);
  }
}
