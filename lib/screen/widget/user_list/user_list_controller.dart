import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/repositories_impl/profile/profile_repository_impl.dart';
import 'package:base_pm2/domain/use_case/profile/get_all_profile_use_case.dart';
import 'package:base_pm2/screen/widget/user_detail/user_detail_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_manager.dart';
import 'package:get/get.dart';
class UserListController extends BaseController {
  RxList<ProfileModel?> mProfiles = <ProfileModel?>[].obs;

  @override
  Future<void> initialData() async {
    fetchData();
  }

  @override
  Future<void> fetchData() async {
    ApiResponse<List<ProfileModel?>?> response = await GetAllProfileUseCase(
        repository: ProfileRepositoryImpl(),
        deviceId: AppConfig().getDeviceId(),
    ).invoke();
    if (checkCode(response)) return;
    mProfiles.value = response.data ?? [];
    setStatus(Status.success);
  }

  void onItemClick(ProfileModel? profileModel) {
    ProfileManager().setProfileModel(profileModel);
    Get.toNamed(RoutePath.USER_DETAIL,
        parameters: UserDetailArgs(userId: profileModel?.profileId.toString()).toJson());
  }
}
