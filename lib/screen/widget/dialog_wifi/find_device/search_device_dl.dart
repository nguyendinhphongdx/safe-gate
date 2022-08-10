import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/dialog/bg_dialog_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/widget/dialog_wifi/find_device/body_scan_qr_comp.dart';
import 'package:base_pm2/screen/widget/dialog_wifi/find_device/body_searching_comp.dart';
import 'package:base_pm2/screen/widget/dialog_wifi/find_device/body_successful_search_comp.dart';
import 'package:base_pm2/screen/widget/dialog_wifi/search_device_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchDeviceDL extends GetWidget<SearchDeviceController> {
  SearchDeviceDL({Key? key}) : super(key: key) {
    Get.lazyPut(() => SearchDeviceController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(() => Visibility(
          visible: controller.isVisible.value ,
          child: BgDialogComp(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),
                        titleComp,
                        controller.isScanQr.value
                            ? const BodyScanQrComp()
                            : Column(
                                children: [
                                  TextButtonComp(
                                    buttonStyle: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(vertical: 16, horizontal: 12)),
                                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        )),
                                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                                      qrCodeComp,
                                      const SizedBox(height: 8),
                                      textConnectDeviceComp
                                    ]),
                                    onPressed: () => controller.onScanQr(true),
                                  ),
                                  const SizedBox(height: 6),
                                  !controller.isFindDevice.value
                                      ? const BodySearchingComp()
                                      : const BodySuccessfulSearchComp()
                                ],
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  buttonComp,
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  Widget get titleComp => Text(
        controller.isScanQr.value
            ? KeyLanguage.device_connecting.tr
            : KeyLanguage.application_initialization.tr,
        style: appStyle.textTheme.bodyText1?.copyWith(color: ColorResource.tabIndicator,fontSize: 16,fontWeight: FontWeight.w600),
      );

  Widget get qrCodeComp => const SvgComp(url: ImageResource.ic_qr_code, width: 36, height: 36);

  Widget get textConnectDeviceComp => Text(
        KeyLanguage.device_connecting.tr,
        style: appStyle.textTheme.bodyText2?.copyWith(color: ColorResource.titleAppBarWhiteScreen),
      );

  Widget get buttonComp => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(color: Colors.white, height: 1, width: double.infinity),
          Row(
            children: [
              Expanded(
                  child: InkWellComp(   paddingAll: 12,
                      child: Center(
                        child: Text(
                          KeyLanguage.exit.tr,
                          style: appStyle.textTheme.headline6?.apply(color: ColorResource.tabIndicator),
                        ),
                      ),
                      onTap: () => Get.back())),
              Container(color: Colors.white, width: 1, height: 44),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 1, bottom: 1),
                  decoration: const BoxDecoration(
                      color: ColorResource.primary,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(12))),
                  child: InkWellComp(
                    paddingAll: 12,
                    onTap: controller.openAddWifi,
                    child: Center(
                      child: Text(
                        KeyLanguage.resume.tr,
                        style: appStyle.textTheme.headline6?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
}
