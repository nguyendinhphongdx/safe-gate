import 'dart:io';

import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/widget/dialog/app_dialog_comp.dart';
import 'package:base_pm2/common/core/widget/dialog/error_dialog_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/enum_resource.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  Rx<Status> status = Status.loading.obs;
  Rx<String> message = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    initialData();
  }

  Future<void> initialData() async {
    await fetchData();
  }

  Future<void> fetchData() async {}

  Future<void> delay(int millis) async {
    await Future.delayed(Duration(milliseconds: millis));
  }

  void setStatus(Status s) {
    status.value = s;
  }

  Status getStatus() => status.value;

  void setMessage(String s) {
    message.value = s;
    Get.dialog(AppDialogComp(content: s,onConfirm: Get.back,));
  }

  Future<bool> get isConnecting async => await getConnection();

  Future<bool> getConnection({Function()? reconnect}) async {
    if (kIsWeb) return false;
    try {
      final result = await InternetAddress.lookup('google.com');
      return !(result.isNotEmpty && result[0].rawAddress.isNotEmpty);
    } on SocketException catch (_) {
      Get.dialog(BaseErrorDialog(
        content: HttpConstant.CONNECT_ERROR,
        textButtonConfirm: 'Thử lại',
        mConfirm: () {
          setStatus(Status.loading);
          reconnect?.call() ?? Get.back();
        },
        mCancel: Get.back,
      ));
      setStatus(Status.error);
      return true;
    }
  }

  bool checkNull(dynamic value) {
    return value == null;
  }

  bool checkCode(ApiResponse? response) {
    if (response == null) return false;
    if (response.err?.code == CodeConstant.OK) return false;
    setStatus(Status.error);
    setMessage(response.err?.message ?? 'Error');
    return true;
  }
}
