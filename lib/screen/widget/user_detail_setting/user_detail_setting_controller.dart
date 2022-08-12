import 'package:base_pm2/common/core/interface/i_mode_listener.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/context_model.dart';
import 'package:base_pm2/data/repositories_impl/device/device_repository_impl.dart';
import 'package:base_pm2/domain/use_case/profile/get_context_by_profile_id_use_case.dart';
import 'package:base_pm2/screen/widget/user_detail/user_detail_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_manager.dart';
import 'package:base_pm2/screen/widget/user_mode_detail/user_mode_detail_controller.dart';
import 'package:get/get.dart';

class UserDetailSettingController extends BaseController with IModeListener {
  List<UserDetailSettingModel> listData = [];
  ContextModel? contextModel;

  @override
  Future<void> initialData() async {
    listData = [
      UserDetailSettingModel(
          title: KeyLanguage.internet_manager.tr,
          icon: ImageResource.config_icon,
          subTitle:
              '${KeyLanguage.using.tr}: ${Get.find<UserDetailController>().dnsMode.value == DNSMode.ADULT ? KeyLanguage.mode_adult : Get.find<UserDetailController>().dnsMode.value == DNSMode.CHILD ? KeyLanguage.mode_child.tr : ''}'
                  .obs),
      UserDetailSettingModel(
          title: KeyLanguage.auto_shell.tr, icon: ImageResource.ic_shield_alt, subTitle: ''.obs),
      UserDetailSettingModel(
        title: KeyLanguage.device_used.tr,
        icon: ImageResource.ic_play_next,
        subTitle: 'Đã sử dụng 0 thiết bị'.obs,
      ),
    ];
    fetchData();
    setStatus(Status.success);
  }

  @override
  Future<void> fetchData() async {
    ApiResponse<ContextModel?> response = await GetContextByProfileIdUseCase(
            repository: DeviceRepositoryImpl(),
            deviceId: AppConfig().getDeviceId(),
            profileId: ProfileManager().getProfile().profileId.toString())
        .invoke();
    if (checkCode(response)) return;
    contextModel = response.data;
    setCurrentMode(response.data?.dnsMode);
    setNumberOfDevice(response.data?.endUserDeviceMacs?.length ?? 0);
  }

  void openPage(int index) {
    switch (index) {
      case 0:
        Get.toNamed(RoutePath.USER_MODE_DETAIL, arguments: UserModeDetailArgs(contextModel: contextModel));
        break;
      case 1:
        Get.toNamed(RoutePath.AUTO_SAFE);

        break;
      case 2:
        Get.toNamed(RoutePath.DEVICE_USED);
        break;
      case 3:
        Get.toNamed(RoutePath.SAFE_ACCESS);
        break;
      case 4:
        Get.toNamed(RoutePath.TIME_TABLE);
        break;
    }
  }

  void setCurrentMode(String? dnsMode) {
    listData[0].subTitle?.value =
        '${KeyLanguage.using.tr}: ${dnsMode == DNSMode.ADULT ? KeyLanguage.mode_adult.tr : KeyLanguage.mode_child.tr}';
  }

  void setNumberOfDevice(int i) {
    listData[2].subTitle?.value = 'Đã sử dụng $i thiết bị';
  }
}

class UserDetailSettingModel {
  String title;
  RxString? subTitle;
  String icon;
  String? status;

  UserDetailSettingModel({
    required this.title,
    this.subTitle,
    required this.icon,
    this.status,
  });
}
