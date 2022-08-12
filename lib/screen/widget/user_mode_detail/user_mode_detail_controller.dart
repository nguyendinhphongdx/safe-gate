import 'package:base_pm2/common/core/interface/i_avatar_listener.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/constant.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/common/resource/keylanguage_resource/key_language.dart';
import 'package:base_pm2/data/model/context_model.dart';
import 'package:base_pm2/data/model/mode_model.dart';
import 'package:base_pm2/screen/widget/user_detail_setting/user_detail_setting_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_list_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_manager.dart';
import 'package:base_pm2/screen/widget/user_mode_detail/dialog/pick_mode_controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserModeDetailArgs {
  ContextModel? contextModel;

  UserModeDetailArgs({this.contextModel});

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};

    return data;
  }

  UserModeDetailArgs.fromJson(Map<String, String?> json) {}
}

class UserModeDetailController extends BaseController with GetTickerProviderStateMixin, IAvatarListener {
  UserModeDetailArgs? args;
  Rx<ModeModel> mode = ModeModel().obs;
  RxBool isActiveMode = false.obs;
  TabController? tabController;

  @override
  Future initialData() async {
    args = Get.arguments;
    tabController = TabController(length: 2, vsync: this);
    setName(ProfileManager().getProfile().profileName);
    setAvatar(ProfileManager().getProfile().profileAvatar);
    changeDataByProfile(args?.contextModel?.dnsMode);
    setStatus(Status.success);
  }

  void changeDataByProfile(String? dnsMode) {
    mode.value = AppConfig().getConfig().modes!.singleWhereOrNull((element) => element.type == dnsMode) ??
        ModeModel(
            name: KeyLanguage.mode_child.tr,
            type: DNSMode.CHILD,
            policies: [
              'Tìm kiếm an toàn',
              'Bảo vệ trẻ em',
              'Chặn website giả mạo',
              'Chặn web đen',
              'Chặn web cờ bạc',
            ],
            description: KeyLanguage.mode_child_desc.tr,
            isActive: false.obs);
    isActiveMode.value = dnsMode == DNSMode.ADULT;
  }

  void onChangeStatus() async {
    var result = await Get.toNamed(RoutePath.SWITCH_MODE, arguments: PickModeArgs(mode: mode.value));
    if (result == null) return;
    changeDataByProfile(result);
    if (Get.isRegistered<UserDetailSettingController>()) Get.find<UserDetailSettingController>().fetchData();
    if (Get.isRegistered<UserListController>()) Get.find<UserListController>().fetchData();
  }

  @override
  void onImagePicked(XFile? file) {
    // TODO: implement onImagePicked
  }
}
