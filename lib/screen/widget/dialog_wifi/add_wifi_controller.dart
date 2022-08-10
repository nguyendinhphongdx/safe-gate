import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/interface/i_add_network_listener.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/data/model/widget/body_model.dart';
import 'package:get/get.dart';

class AddWifiController extends BaseController with IAddNetWorkListener {
  @override
  Future initialData() async {
    await super.initialData();
    bodyModels.add(BodyModel());
  }

  void onAddConfig() {
    bodyModels.add(BodyModel());
  }

  void onFinish() {
    Get.back();
    Get.back();
    showLog(bodyModels.toString());
    Get.toNamed(RoutePath.CONFIG_DEVICE);
  }

  onDeleteItem(BodyModel? bodyModel) {
    bodyModels.remove(bodyModel);
  }
}
