import 'package:base_pm2/common/core/sys/api_extension.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/network/client.dart';
import 'package:base_pm2/data/model/widget/category_model.dart';
import 'package:base_pm2/domain/repository/widget/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl._internal();

  static final CategoryRepositoryImpl _impl = CategoryRepositoryImpl._internal();

  factory CategoryRepositoryImpl() => _impl;

  @override
  Future<ApiResponse<List<CategoryModel?>?>> getAllGroupApplication({List<String>? categoryIds}) async {
    return Client().service.getAllGroupAppliction({'cate_id': categoryIds}).wrap(cast: (json)=> CategoryModel.fromJson(json));
  }
  @override
  Future<ApiResponse<List<CategoryModel?>?>> getAllGroupApplicationDefault() async {
    return Client().service.getAllGroupAppliction({}).wrap(cast: (json)=> CategoryModel.fromJson(json));
  }
  @override
  Future<ApiResponse<List<CategoryModel?>?>> findAllGroupAppByKeyWord(String? keyword) async {
    return Client().service.findAllGroupAppByKey(keyword).wrap(cast: (json)=> CategoryModel.fromJson(json));
  }
}
