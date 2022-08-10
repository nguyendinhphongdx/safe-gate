import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetWidget<SplashController> {
  SplashPage({Key? key}) : super(key: key) {
    Get.lazyPut(() => SplashController());
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBarComp(height: 0,isLight: false),
      backgroundColor: Colors.white,
      body: Center(
        child: ImageViewer(ImageResource.ic_launcher,width: ViewUtils.width/2,),
      ),
    );
  }
}
