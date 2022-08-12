import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/dialog/bg_dialog_comp.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PauseDL extends StatelessWidget {
  const PauseDL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 12, right: 12, bottom: Get.height * 0.25),
        child: BgDialogComp(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    titleComp,
                    const SizedBox(height: 24),
                    contentComp,
                    const SizedBox(height: 8),
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
        style: appStyle.textTheme.bodyText2?.copyWith(color: ColorResource.tabIndicator, fontSize: 16),
      );

  Widget get contentComp => Text(
        'Chức năng này sẽ tạm dừng sử dụng toàn bộ thiết bị của Người dùng này.\n\nBạn có muốn thực hiện?',
        style: appStyle.textTheme.bodyText1?.copyWith(color:ColorResource.tabIndicator),
        textAlign: TextAlign.center,
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
              Container(color: Colors.white, width: 1, height: 44),
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
