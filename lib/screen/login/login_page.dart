import 'dart:io';

import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:base_pm2/screen/login/comp/item_arena_comp.dart';
import 'package:base_pm2/screen/login/comp/item_language_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginPage extends GetWidget<LoginController> {
  final _controller = Get.lazyPut(() => LoginController());

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => exit(0),
      child: MainLayout<LoginController>(
          resizeToAvoidBottomInset: false,
          mustSafeView: true,
          withImageBackground: true,
          extendBody: false,
          appBar: AppBarComp(
              height: 0, isLight: true, backgroundColor: Colors.transparent),
          child: _body(context: context)),
    );
  }

  Widget _body({required BuildContext context}) {
    return Stack(
      children: [
        ImageViewer(
          ImageResource.img_bg_login,
          width: Get.width,
          height: Get.height,
          fit: BoxFit.cover,
        ),
        Positioned.fill(child: frontLogin(context: context)),
      ],
    );
  }

  Widget frontLogin({required BuildContext context}) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Obx(
                    () => ItemLanguageComp(
                      isVietnamese: controller.showLanguage.value,
                      onChangeLanguage: controller.onChangeLanguage,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 16),
                child: ImageViewer(ImageResource.logo, width: 118),
              ),
              const SizedBox(height: 36),
              Form(
                key: controller.loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldComp(
                      padV: 12,
                      padH: 0,
                      fillColor: Colors.transparent,
                      editingController: controller.phoneEdtController,
                      style: appStyle.textTheme.bodyText1,
                      hintStyle: appStyle.textTheme.bodyText1
                          ?.apply(color: Colors.white.withOpacity(.5)),
                      hint: KeyLanguage.enterPhoneNumber.tr,
                      enableDefauSuffix: true,
                      inputType: TextInputType.phone,
                      visibleClearSuffixIcon: true,
                      colorClear: Colors.white,
                      colorUnderLine: Colors.white,
                      colorIconPassWord: Colors.white,
                      prefixIcon: InkWellComp(
                        onTap: () => controller.onArenaPressed(),
                        padding: const EdgeInsets.only(right: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() => ImageViewer(
                                  controller.currentArena.value == CountryCode.VN_CODE
                                      ? ImageResource.vn
                                      : controller.currentArena.value == CountryCode.UK_CODE
                                          ? ImageResource.ic_uk
                                          : ImageResource.ic_us,
                                  width: 36,
                                  height: 22,
                                )),
                            SizedBox(
                                width: 0,
                                height: 0,
                                child: Theme(
                                    data: Theme.of(context).copyWith(
                                      highlightColor: Colors.white,
                                      splashColor: Colors.white,
                                    ),
                                    child: PopupMenuButton(
                                      key: controller.popupMenu,
                                      itemBuilder: _buildMenu,
                                      offset: const Offset(-36, 20),
                                      onSelected: controller.onMenuSelected,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      color: ColorResource.arena,
                                      iconSize: 0,
                                    ))),
                            const SizedBox(width: 8),
                            Obx(() => Text(
                                  controller.currentArena.value,
                                  style: appStyle.textTheme.bodyText1,
                                ))
                          ],
                        ),
                      ),
                      onValidator: (s) {
                        return controller.validatePhone(0);
                      },
                    ),

                    const SizedBox(height: 20),
                    TextFieldComp(
                      padV: 0,
                      padH: 0,
                      style: appStyle.textTheme.bodyText1,
                      fillColor: Colors.transparent,
                      editingController: controller.pwdController,
                      hintStyle: appStyle.textTheme.bodyText1,
                      hint: KeyLanguage.password.tr,
                      isInvisiblePassword: true,
                      clear: true.obs,
                      enableDefauSuffix: true,
                      colorIconPassWord: Colors.white,
                      colorUnderLine: Colors.white,
                      obscurePadding: const EdgeInsets.symmetric(horizontal: 0),
                      colorClear: Colors.white,
                      visibleClearSuffixIcon: true,
                      onValidator: (s) {
                        return controller.validatePhone(1);
                      },
                    ),
                    SizedBox(height: ViewUtils.height * 0.12),
                    ElevatedButtonComp(
                      widthValue: double.infinity,
                      title: KeyLanguage.login.tr,
                      style: appStyle.textTheme.headline4
                          ?.copyWith(fontWeight: FontWeight.w500),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      onPressed: controller.loginCall,
                    ),
                    // const SizedBox(width: 0, height: 24),
                    Visibility(
                        visible: false,
                        child: Material(
                          color: ColorResource.blue_chart,
                          borderRadius: BorderRadius.circular(6),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () => Future.delayed(
                                const Duration(milliseconds: 200),
                                () => controller.localAuth()),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  // color: ColorResource.blue_chart,
                                  borderRadius: BorderRadius.circular(4)),
                              child: const SvgComp(
                                url: ImageResource.ic_finger,
                                width: 32,
                                height: 32,
                                color: Colors.white,
                                boxFit: BoxFit.contain,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Column(
                children: [
                  InkWellComp(
                    isTransparent: true,
                    onTap: () => Get.toNamed(RoutePath.REQUEST_RESET_PWD),
                    child: Stack(
                      children: [
                        // Container(
                        //   height: 18.5,
                        //   decoration: const BoxDecoration(
                        //       border: Border(bottom: BorderSide(width: 1, color: Colors.white))),
                        //   child: Text(
                        //     KeyLanguage.forgotPassword.tr,
                        //     style: appStyle.textTheme.bodyText1?.copyWith(fontSize: 16),
                        //   ),
                        // ),
                        Text(
                          KeyLanguage.forgotPassword.tr,
                          style: appStyle.textTheme.bodyText1?.copyWith(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2),
                        ),
                      ],
                    ),
                  ),
                  InkWellComp(
                    isTransparent: true,
                    onTap: () => Get.toNamed(RoutePath.SIGNUP),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(KeyLanguage.doSignUpAccount.tr,
                            style: appStyle.textTheme.bodyText1
                                ?.copyWith(fontSize: 16)),
                        Stack(
                          children: [
                            // Container(
                            //     height: 18.5,
                            //     decoration: const BoxDecoration(
                            //         border: Border(bottom: BorderSide(width: 1, color: Colors.white))),
                            //     child: Text('Đăng ký',
                            //         style: appStyle.textTheme.bodyText1?.copyWith(fontSize: 16))),
                            Text(KeyLanguage.signUp.tr,
                                style: appStyle.textTheme.bodyText1?.copyWith(
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry> _buildMenu(BuildContext context) {
    return [
      const PopupMenuItem(
          // padding: EdgeInsets.symmetric(vertical: 0),
          height: 32,
          value: ArenaCode.VIETNAM,
          child:
              ItemArenaComp(title: 'Việt Nam (+84)', icon: ImageResource.vn)),
      const PopupMenuItem(
          height: 32,
          value: ArenaCode.UK,
          child: ItemArenaComp(
              title: 'United Kingdom (+44)', icon: ImageResource.ic_uk)),
      const PopupMenuItem(
          height: 32,
          value: ArenaCode.US,
          child: ItemArenaComp(
              title: 'United State (+1)', icon: ImageResource.ic_us))
    ];
  }
}
