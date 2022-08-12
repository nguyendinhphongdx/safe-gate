import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/data/model/user/user_report/user_model.dart';
import 'package:base_pm2/data/model/user/user_report/user_status_model.dart';

abstract class UserRepository{

  Future<ApiResponse<UserModel>> detailUser(String uid);

  Future<ApiResponse<dynamic>> updateUser(String uid);

  Future<ApiResponse<dynamic>> deleteUser(String uid);

  Future<ApiResponse<List<UserStatusModel>?>> getAllUsers();

}