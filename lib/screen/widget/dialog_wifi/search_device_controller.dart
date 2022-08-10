import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:get/get.dart';

class SearchDeviceController extends BaseController {
  var isFindDevice = false.obs;
  var isVisible = true.obs;
  var isScanQr = false.obs;

  @override
  Future<void> initialData() async {
    setStatus(Status.success);
  }

  @override
  Future<void> onReady() async {
    await delay(5000);
    isFindDevice.value = true;
    super.onReady();
  }

  void openAddWifi() async{
    isVisible.value = false;
    await Get.toNamed(RoutePath.ADD_WIFI);
    isVisible.value = true;
    // Get.dialog(Dialog(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    //   child: AddWifiDL(),
    // )).then((value) {
    //   if (value == 'back') {
    //     isVisible.value = true;
    //   } else {
    //     Get.back();
    //   }
    // });
  }

  void onScanQr(bool value) {
    isScanQr.value = value;
  }
}
