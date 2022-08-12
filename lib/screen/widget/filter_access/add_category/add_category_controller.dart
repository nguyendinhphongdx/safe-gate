import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/core/sys/count_down.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:base_pm2/data/model/widget/category_model.dart';
import 'package:base_pm2/data/model/widget/get_all_group_app_default_use_case.dart';
import 'package:base_pm2/data/repositories_impl/widget/application_repository_impl.dart';
import 'package:base_pm2/data/repositories_impl/widget/category_repository_impl.dart';
import 'package:base_pm2/domain/use_case/widget/confirm_application_use_case.dart';
import 'package:base_pm2/domain/use_case/widget/get_all_group_app_by_key_use_case.dart';
import 'package:base_pm2/screen/widget/filter_access/group/group_controller.dart';
import 'package:base_pm2/screen/widget/user_detail_setting/user_detail_setting_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCategoryController extends BaseController {
  RxList<CategoryModel?> categories = <CategoryModel?>[].obs;
  RxList<CategoryModel?> categoriesChecked = <CategoryModel>[].obs;
  TextEditingController? searchController = TextEditingController();
  CountTimer timer = CountTimer(300);

  @override
  Future initialData() async {
    fetchData();
  }

  @override
  Future<void> fetchData() async {
    ApiResponse<List<CategoryModel?>?> response = searchController!.text.isEmpty
        ? await GetAllGroupAppDefaultUseCase(repository: CategoryRepositoryImpl()).invoke()
        : await GetAllGroupAppByKeyUseCase(
                repository: CategoryRepositoryImpl(), keyword: searchController?.text)
            .invoke();
    categories.value = response.data ?? [];
    List<CategoryModel?> appOriginAdded = Get.find<GroupController>().mGroupApps;
    appOriginAdded.forEach((element1) {
      categories.removeWhere((element) => element?.categoryId == element1?.categoryId);
    });
    categoriesChecked.forEach((element1) {
      categories.removeWhere((element) => element?.categoryId == element1?.categoryId);
    });
  }

  void confirmApplication() async {
    if (!Utils.isNotNullAndEmpty(categoriesChecked)) return;
    List<ApplicationModel?> cates = Get.find<UserDetailSettingController>()
            .contextModel
            ?.categoryRules
            ?.map((e) => ApplicationModel(
                ruleModels: e.rules
                        ?.map((e) => RuleAppModel(
                            startTimePattern: e.startTimePattern,
                            endTimePattern: e.endTimePattern,
                            type: e.type))
                        .toList() ??
                    [],
                applicationId: e.id))
            .toList() ??
        [];
    List<ApplicationModel?> apps = Get.find<UserDetailSettingController>()
            .contextModel
            ?.appRules
            ?.map((e) => ApplicationModel(
                ruleModels: e.rules
                        ?.map((e) => RuleAppModel(
                            startTimePattern: e.startTimePattern,
                            endTimePattern: e.endTimePattern,
                            type: e.type))
                        .toList() ??
                    [],
                applicationId: e.id))
            .toList() ??
        [];

    List<ApplicationModel?> appOriginAdded = [...cates, ...apps];

    categoriesChecked.forEach((element) {
      appOriginAdded.add(ApplicationModel(ruleModels: [], applicationId: element?.categoryId));
    });

    ApiResponse<dynamic> response = await ConfirmApplicationUseCase(
            applicationRepository: ApplicationRepositoryImpl(),
            deviceId: AppConfig().getDeviceId(),
            profileId: ProfileManager().getProfile().profileId.toString(),
            dnsMode: Get.find<UserDetailSettingController>().contextModel?.dnsMode,
            applications: appOriginAdded)
        .invoke();
    if (checkCode(response)) return;

    if (Get.isRegistered<UserDetailSettingController>())
      await Get.find<UserDetailSettingController>().fetchData();
    if (Get.isRegistered<GroupController>()) await Get.find<GroupController>().fetchData();
    Get.back();
  }

  void changeStatusOrigin(CategoryModel? element) {
    element?.isActive?.value = !element.isActive!.value;
    categories.remove(element);
    categoriesChecked.add(element);
  }

  void onActiveChange(CategoryModel? element) {
    element?.isActive?.value = !element.isActive!.value;
    categoriesChecked.remove(element);
  }

  Future<void> onSearch(String value) async {
    timer.start(fetchData);
  }
}
