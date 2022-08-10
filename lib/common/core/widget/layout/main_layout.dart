import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainLayout<T extends BaseController> extends StatelessWidget {
  const MainLayout({
    this.appBar,
    this.mustSafeView = true,
    this.withImageBackground = true,
    required this.child,
    this.onClick,
    this.backgroundColor = Colors.transparent,
    Key? key,
    this.resizeToAvoidBottomInset,
    this.imageBackground,
    this.extendBody = true,
    this.indicatorColor,
  }) : super(key: key);
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Function? onClick;
  final bool? mustSafeView;
  final bool? withImageBackground;
  final bool? resizeToAvoidBottomInset;
  final bool extendBody;
  final Color backgroundColor;
  final Color? indicatorColor;
  final String? imageBackground;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onBackgroundPress(context),
      child: Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            if (withImageBackground == true)
              Positioned.fill(
                  child: ImageViewer(
                imageBackground ?? ImageResource.img_bg_main,
                fit: BoxFit.cover,
              )),
            Scaffold(
              extendBody: extendBody,
              appBar: appBar,
              backgroundColor: backgroundColor,
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              body: mustSafeView == true
                  ? SafeArea(child: BodyLayout<T>(child: child, indicatorColor: indicatorColor))
                  : BodyLayout<T>(child: child, indicatorColor: indicatorColor),
            ),
          ],
        ),
      ),
    );
  }

  void _onBackgroundPress(BuildContext context) {
    FocusScope.of(context).unfocus();
    onClick?.call();
  }
}

class BodyLayout<T extends BaseController> extends GetView<T> {
  const BodyLayout({this.indicatorColor, Key? key, required this.child}) : super(key: key);
  final Widget child;
  final Color? indicatorColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Obx(
            () => Visibility(
              visible:
                  Get.find<T>().getStatus() != Status.loading && Get.find<T>().getStatus() != Status.error,
              child: child,
            ),
          ),
        ),
        Positioned.fill(
          child: Obx(
            () => Visibility(
              visible:
                  Get.find<T>().getStatus() == Status.loading || Get.find<T>().getStatus() == Status.waiting,
              child: IndicatorComp(status: Get.find<T>().getStatus(), indicatorColor: indicatorColor),
            ),
          ),
        ),
      ],
    );
  }
}
