import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/mode_model.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/screen/widget/user_mode_list/user_mode_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class UserModeEditArgs {
  String? id;
  String? name;
  String? desc;

  UserModeEditArgs({this.id, this.name, this.desc});

  UserModeEditArgs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['id'] = id ?? '';
    data['name'] = name ?? '';
    data['desc'] = desc ?? '';
    return data;
  }
}

class UserModeEditController extends BaseController {
  TextEditingController? nameController;

  TextEditingController? descController;

  UserModeEditArgs? args;
  RxList<ProfileModel> subModes = <ProfileModel>[].obs;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Future initialData() async {
    args = UserModeEditArgs.fromJson(Get.parameters);
    nameController = TextEditingController(text: args?.name ?? '');
    descController = TextEditingController(text: args?.desc ?? '');
    if (args?.id == null) {
      setStatus(Status.success);
      return;
    }
    fetchData();
  }

  String? validate(String? s, int i) {
    if (s == null) return KeyLanguage.input_mode.tr;
    if (s.isEmpty) return KeyLanguage.input_mode.tr;

    return null;
  }

  Future<void> save() async {
    if (!formKey.currentState!.validate()) return;
    setStatus(Status.waiting);
    ModeModel modeModel = ModeModel(
        name: nameController?.text.trim(),
        description: descController?.text.trim(),
        id: int.tryParse(args?.id ?? ''));

    // ApiResponse<ModeModel?> response = args?.id != null
    //     ? await UpdateModeUseCase(
    //         repository: ModeRepositoryImpl(),
    //         modeId: args?.id,
    //         modeModel: modeModel,
    //       ).invoke()
    //     : await SaveModeUseCase(
    //             repository: ModeRepositoryImpl(),
    //             userId: 'af18a626-9842-479f-a172-52605ec90e34',
    //             modeModel: modeModel)
    //         .invoke();
    // if (checkCode(response)) return;
    // setStatus(Status.success);
    Get.find<UserModeController>().fetchData();
    Get.back();
  }

  @override
  Future<void> fetchData() async {
    // ApiResponse<List<ProfileModel>?> response =
    //     await GetAllProfileUseCase(repository: ProfileRepositoryImpl(), modeId: args?.id).invoke();
    // if (checkCode(response)) return;
    // subModes.value = response.data ?? [];
    setStatus(Status.success);
  }
}
