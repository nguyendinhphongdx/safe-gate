import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/mode_model.dart';
import 'package:base_pm2/screen/widget/user_mode_edit/user_mode_edit_controller.dart';
import 'package:get/get.dart';

class UserModeController extends BaseController {
  RxList<ModeModel> mModes = <ModeModel>[].obs;

  @override
  Future initialData() async {
    setStatus(Status.loading);
    fetchData();
  }

  @override
  Future<void> fetchData() async {
    // if (await getConnection(reconnect: fetchData)) return;
    // ApiResponse<List<ModeModel>?> response = await GetAllModeUseCase(
    //         repository: ModeRepositoryImpl(), userId: '84e89086-dc2f-7d79-e629-224c055e5c49')
    //     .invoke();
    // if (checkCode(response)) return;
    // mModes.value = response.data ?? [];
    setStatus(Status.success);
  }

  void onEditMode(ModeModel? mode) {
    // UserModeEditArgs args = UserModeEditArgs(id: mode?.id.toString(), name: lmode?.title, desc: mode?.desc);
    showLog(mode?.id);
    UserModeEditArgs args = UserModeEditArgs(id: mode?.id.toString(), name:  mode?.name,desc: mode?.description);
    Get.toNamed(RoutePath.USER_MODE_EDIT, parameters: args.toJson());
  }

  void addMode() {
    Get.toNamed(RoutePath.USER_MODE_EDIT);
  }
}
