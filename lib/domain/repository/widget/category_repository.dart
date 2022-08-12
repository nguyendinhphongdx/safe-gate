import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/widget/category_model.dart';

abstract class CategoryRepository {
  Future<ApiResponse<List<CategoryModel?>?>> getAllGroupApplication({List<String>? categoryIds});

  Future<ApiResponse<List<CategoryModel?>?>> getAllGroupApplicationDefault();

  Future<ApiResponse<List<CategoryModel?>?>> findAllGroupAppByKeyWord(String? keyword);
}
