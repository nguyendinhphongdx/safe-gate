import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/dialog/bg_dialog_comp.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/widget/user_detail/user_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class TemporarilyOpenDL extends GetView<UserDetailController> {
  const TemporarilyOpenDL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Container(
        padding: EdgeInsets.only(left: 12, right: 12, bottom: Get.height * 0.13),
        alignment: Alignment.center,
        child: BgDialogComp(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    titleComp,
                    const SizedBox(height: 20),
                    contentComp,
                    const SizedBox(height: 16),
                    openTimeComp,
                    const SizedBox(height: 8),
                    numberPicker,
                    const SizedBox(height: 2),
                  ],
                ),
              ),
              buttonComp,
            ],
          ),
        ),
      ),
    );
  }

  Widget get titleComp => Text(
        'Cảnh báo',
        style: appStyle.textTheme.bodyText1?.copyWith(fontSize: 16, color: ColorResource.tabIndicator),
      );

  Widget get contentComp => Text(
        'Kích hoạt mở không giới hạn tạm thời cho tất cả thiết bị của Người dùng này',
        style: appStyle.textTheme.bodyText1?.copyWith(color: ColorResource.tabIndicator),
        textAlign: TextAlign.center,
      );

  Widget get openTimeComp => Text(
        'Thời gian mở',
        style: appStyle.textTheme.bodyText1?.copyWith(color: ColorResource.tabIndicator),
        textAlign: TextAlign.center,
      );

  Widget get numberPicker => Obx(
        () => NumberPicker(
          value: controller.valueNumberPicker.value,
          minValue: 1,
          maxValue: 6,
          itemWidth: double.infinity,
          onChanged: controller.updateNumberPicker,
          textMapper: controller.mapToDatetime,
          selectedTextStyle: appStyle.textTheme.bodyText1?.copyWith(fontSize: 16, color: Colors.blue),
          textStyle: appStyle.textTheme.subtitle1?.apply(color: ColorResource.tabIndicator.withOpacity(0.6)),
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(
              color: ColorResource.tabIndicator.withOpacity(0.6),
              width: 0.5,
            ),
            bottom: BorderSide(
              width: 0.5,
              color: ColorResource.tabIndicator.withOpacity(0.6),
            ),
          )),
        ),
      );

  Widget get buttonComp => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(color: Colors.white, height: 1, width: double.infinity),
          Row(
            children: [
              Expanded(
                  child: InkWellComp(
                      paddingAll: 12,
                      child: Center(
                        child: Text(
                          'Đồng ý',
                          style: appStyle.textTheme.subtitle1?.apply(color: ColorResource.tabIndicator),
                        ),
                      ),
                      onTap: () {
                        Get.back();
                      })),
              Container(color: Colors.white, width: 1, height: 40),
              Expanded(
                child: InkWellComp(
                    paddingAll: 12,
                    child: Center(
                      child: Text(
                        'Thoát',
                        style: appStyle.textTheme.subtitle1?.apply(color: ColorResource.tabIndicator),
                      ),
                    ),
                    onTap: () {
                      Get.back();
                    }),
              ),
            ],
          )
        ],
      );
}
