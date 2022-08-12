import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/data/model/widget/category_model.dart';
import 'package:base_pm2/data/model/widget/get_all_group_app_default_use_case.dart';
import 'package:base_pm2/data/repositories_impl/widget/category_repository_impl.dart';
import 'package:base_pm2/domain/repository/widget/category_repository.dart';
import 'package:collection/collection.dart';

class GetAllGroupApplicationUseCase extends BaseUseCase<ApiResponse<List<CategoryModel?>?>> {
  final CategoryRepository repository;
  final List<String>? categoryIds;
  final List<RuleAppParentModel>? rules;

  GetAllGroupApplicationUseCase({this.rules, this.categoryIds, required this.repository});

  @override
  Future<ApiResponse<List<CategoryModel?>?>> invoke() async {
    List<CategoryModel?> mListCategory = [];

    // if (categoryIds == null) return ApiResponse.success(mListCategory);

    if (Utils.isNotNullAndEmpty(categoryIds)) {
      ApiResponse<List<CategoryModel?>?> response =
          await repository.getAllGroupApplication(categoryIds: categoryIds);

      if (response.data != null) {
        mListCategory.addAll(response.data ?? []);
        mListCategory.forEach((element) {
          element?.ruleModels = rules?.singleWhereOrNull((rule) => rule.id == element.categoryId)?.rules;
        });
      }
    }
    ApiResponse<List<CategoryModel?>?> responseAllCate =
        await GetAllGroupAppDefaultUseCase(repository: CategoryRepositoryImpl()).invoke();

    categoryIds?.forEach((element) {
      responseAllCate.data?.removeWhere((element1) => int.tryParse(element) == element1?.categoryId);
    });

    if (responseAllCate.data != null) mListCategory.addAll(responseAllCate.data ?? []);

    return ApiResponse.success(mListCategory);
  }

  @override
  void validate() {}
}
