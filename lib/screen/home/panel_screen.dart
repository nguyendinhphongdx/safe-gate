import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/home/comp/pannel_body_comp.dart';
import 'package:base_pm2/screen/home/panel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PanelPage extends GetWidget<PanelController> with WidgetsBindingObserver{
  PanelPage({Key? key}) : super(key: key);
  final _panelController = Get.lazyPut(() => PanelController());

  @override
  Widget build(BuildContext context) {
    return MainLayout<PanelController>(
      resizeToAvoidBottomInset: false,
      appBar: AppBarComp(height: 0,isLight: true,),
      child: Stack(children: [
        const Positioned.fill(
            child: ImageViewer(
          ImageResource.img_bg_main,
          fit: BoxFit.cover,
        )),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: const PanelBodyComp(),
          extendBody: true,
          floatingActionButton: Obx(
            () => Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    if (controller.currentTab.value == 2)
                      BoxShadow(
                          blurRadius: 7,
                          offset: const Offset(0, 2),
                          color: Colors.white.withOpacity(.1))
                  ],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100))),
              margin: const EdgeInsets.only(top: 24),
              child: InkWellComp(
                paddingAll: 0,
                isTransparent: true,
                onTap: () => controller.onChangePage(2),
                child: const ImageViewer(
                  ImageResource.logo,
                  width: 48,
                  height: 48,
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Obx(() => BottomAppBarComp(
              onChangeTab: controller.onChangePage,
              tabIndex: controller.currentTab.value)),
        )
      ]),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed) controller.resumedData();
  }
}
