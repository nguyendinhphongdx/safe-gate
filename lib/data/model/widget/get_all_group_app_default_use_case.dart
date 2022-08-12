import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/widget/category_model.dart';
import 'package:base_pm2/domain/repository/widget/category_repository.dart';

class GetAllGroupAppDefaultUseCase extends BaseUseCase<ApiResponse<List<CategoryModel?>?>> {
  final CategoryRepository repository;

  GetAllGroupAppDefaultUseCase({required this.repository});

  @override
  Future<ApiResponse<List<CategoryModel?>?>> invoke() async {
    return repository.getAllGroupApplicationDefault();
  }

  @override
  void validate() {}
}
