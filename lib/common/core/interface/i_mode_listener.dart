import 'package:base_pm2/common/helper/app_common.dart';
import 'package:get/get.dart';

abstract class IModeListener {
  RxString modeName = ''.obs;
  RxBool isChildMode = true.obs;

  void setMode(String? dnsMode) {
    if (dnsMode == null) return;
    modeName.value = dnsMode;
    isChildMode.value = dnsMode == DNSMode.CHILD;
  }
}
