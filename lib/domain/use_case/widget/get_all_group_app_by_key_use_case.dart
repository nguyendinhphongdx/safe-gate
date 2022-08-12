import 'package:base_pm2/common/core/model_base/base_use_case.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/widget/category_model.dart';
import 'package:base_pm2/domain/repository/widget/category_repository.dart';

class GetAllGroupAppByKeyUseCase extends BaseUseCase<ApiResponse<List<CategoryModel?>?>>{
  final CategoryRepository repository;
  final String? keyword;


  GetAllGroupAppByKeyUseCase({required this.repository, this.keyword});

  @override
  Future<ApiResponse<List<CategoryModel?>?>> invoke() async{
    return await repository.findAllGroupAppByKeyWord(keyword);
  }

  @override
  void validate() {
    // TODO: implement validate
  }

}