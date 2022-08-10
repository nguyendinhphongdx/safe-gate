import 'dart:async';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OtpArgs {
  String? phoneNumber;
  String? otpType;

  OtpArgs({this.phoneNumber, this.otpType});

  OtpArgs.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    otpType = json['otp_type'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['phone_number'] = phoneNumber ?? '';
    data['otp_type'] = otpType ?? '';
    return data;
  }
}

class OtpController extends BaseController {
  OtpArgs? args;
  TextEditingController pinController = TextEditingController();
  // ignore: unused_field
  Timer? _timer;
  RxInt currentTime = 120.obs;

  @override
  Future<void> initialData() {
    args = OtpArgs.fromJson(Get.parameters);
    String formatPhone = '';
    for (int i = 0; i < args!.phoneNumber!.length; i++) {
      formatPhone += args!.phoneNumber![i];
      if (i == 4) formatPhone += ' ';
      if (i == 8) formatPhone += ' ';
      if (i == 11) formatPhone += ' ';
      if (i == 14) formatPhone += ' ';
    }
    countDown();
    args?.phoneNumber = formatPhone;
    setStatus(Status.success);

    return super.initialData();
  }

  Future<void> onVerifyOtp() async {
    if (pinController.text.length < 6) return;
    ViewUtils.hideKeyboard();
    setStatus(Status.waiting);
    await delay(500);
    setStatus(Status.success);
    if (args?.otpType == OtpType.OTP_SIGN_UP) {
      Get.offNamedUntil(RoutePath.LOGIN, (_) => false);
    }
    if (args?.otpType == OtpType.OTP_LOGIN) {
      Get.offNamedUntil(RoutePath.PANEL, (_) => true);
    }
    if (args?.otpType == OtpType.OTP_RESET_PASSWORD) {
      Get.offNamed(RoutePath.RESET_PWD);
    }
  }

  Future<void> onResendOtp() async {
    // await OtpUseCase(
    //         otpModelRequest: OtpModelRequest(mobile: '', session: ''), otpRepository: OtpRepositoryImpl())
    //     .invoke();
    countDown();
  }

  void countDown() {
    currentTime.value = 120;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (currentTime.value == 0) {
          timer.cancel();
        } else {
          currentTime.value--;
        }
      },
    );
  }
}
