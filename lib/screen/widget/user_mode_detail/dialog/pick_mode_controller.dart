import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/resource/enum_resource.dart';
import 'package:base_pm2/data/model/mode_model.dart';
import 'package:base_pm2/data/repositories_impl/profile/profile_repository_impl.dart';
import 'package:base_pm2/domain/use_case/profile/update_profie_mode_use_case.dart';
import 'package:base_pm2/screen/widget/user_list/user_manager.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';

class PickModeArgs {
  ModeModel? mode;

  PickModeArgs({this.mode});
}

class PickModeController extends BaseController {
  RxList<ModeModel> mModeData = <ModeModel>[].obs;
  PickModeArgs? args;
  RxBool isEnableUpdate = false.obs;

  @override
  Future initialData() async {
    args = Get.arguments;
    mModeData.value = AppConfig().getConfig().getModes();
    mModeData.singleWhere((element) => element.type == args?.mode?.type).isActive?.value = true;
    setStatus(Status.success);
  }

  void onConfirm() async {
    String? dnsMode = mModeData.singleWhereOrNull((element) => element.isActive?.value ?? false)?.type;
    if (dnsMode == args?.mode?.type) return;
    ApiResponse<dynamic> response = await UpdateProfileModeUseCase(
            repository: ProfileRepositoryImpl(),
            deviceId:  AppConfig().getDeviceId(),
            profileId: ProfileManager().getProfile().profileId.toString(),
            dnsMode: dnsMode)
        .invoke();
    if (checkCode(response)) return;

    Get.back(result: dnsMode);
  }

  void onCancel() {
    Get.back();
  }

  void onPressMode(ModeModel? mode) {
    mModeData.forEach((element) => element.isActive?.value = false);
    mode?.isActive?.value = true;
    isEnableUpdate.value = mode?.type != args?.mode?.type;
  }
}
