import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class BodyDialogComp<T extends BaseController> extends GetView<T> {
  const BodyDialogComp({this.child, Key? key}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.getStatus() == Status.loading
        // ignore: sized_box_for_whitespace
        ? Container(height: 120,child: const SpinKitFadingCircle(color: ColorResource.primary, size: 46))
        : child!);
  }
}
