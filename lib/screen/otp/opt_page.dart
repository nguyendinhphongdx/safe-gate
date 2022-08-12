import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/otp/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends GetWidget<OtpController> {
  OtpPage({Key? key}) : super(key: key) {
    Get.lazyPut(() => OtpController());
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout<OtpController>(
      mustSafeView: true,
      child: bodyOtp(),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      indicatorColor: ColorResource.primary,
      appBar: AppBarComp(
        centerTitle: true,
        isLight: false,
        title: KeyLanguage.otp_verify.tr,
        style: appStyle.textTheme.bodyText1?.copyWith(
            fontSize: 16,
            color: ColorResource.tabIndicator,
            fontWeight: FontWeight.w600),
        colorIcon: ColorResource.field,
      ),
    );
  }

  Widget bodyOtp() {
    return Column(
      children: [
        const Expanded(child: ImageViewer(ImageResource.logo_otp)),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 36),
                Pinput(
                  controller: controller.pinController,
                  length: 6,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  defaultPinTheme: PinTheme(
                    width: Get.width / 8.5,
                    height: 56,
                    textStyle: appStyle.textTheme.headline1?.copyWith(
                        color: ColorResource.primary,
                        fontWeight: FontWeight.w900,
                        height: 2),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            style: BorderStyle.solid,
                            color: ColorResource.hint,
                            width: 1),
                      ),
                    ),
                  ),
                  separator: const SizedBox(width: 20),
                  onSubmitted: (_) => controller.onVerifyOtp(),
                  onCompleted: (_) => controller.onVerifyOtp(),
                  pinAnimationType: PinAnimationType.fade,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 20),
                Text(
                  KeyLanguage.otp_send_notify.tr,
                  style: appStyle.textTheme.bodyText1
                      ?.apply(color: ColorResource.tabIndicator),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.args?.phoneNumber ?? '',
                  style: appStyle.textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: ColorResource.tabIndicator),
                ),
                const SizedBox(height: 46),
                ElevatedButtonComp(
                  widthValue: double.infinity,
                  onPressed: controller.onVerifyOtp,
                  title: KeyLanguage.confirm.tr,
                  style: appStyle.textTheme.headline4
                      ?.copyWith(fontWeight: FontWeight.w500),
                  borderRadius: 12,
                ),
                const SizedBox(height: 16),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          controller.currentTime.value != 0
                              ? KeyLanguage.sendOtpAgain.tr
                              : KeyLanguage.not_received_otp.tr,
                          style: appStyle.textTheme.bodyText1
                              ?.apply(color: ColorResource.tabIndicator)),
                      Visibility(
                        visible: controller.currentTime.value != 0,
                        child: Text('${controller.currentTime.value}s',
                            style: appStyle.textTheme.bodyText1
                                ?.apply(color: ColorResource.tabIndicator)),
                      ),
                      Visibility(
                        visible: controller.currentTime.value == 0,
                        child: InkWellComp(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            onTap: controller.onResendOtp,
                            child: Text(KeyLanguage.resend_otp.tr,
                                style: appStyle.textTheme.bodyText1?.copyWith(
                                    color: ColorResource.primary,
                                    fontWeight: FontWeight.w500))),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
