import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BgDialogComp extends StatelessWidget {
  final Widget child;
  final double? width;
  final bool? canBack;

  const BgDialogComp({Key? key, required this.child, this.width, this.canBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              ColorResource.endGradient,
            ],
          ),
        ),
        child: Stack(
          children: [
            child,
            Positioned(
              top: 0,
              right: 0,
              child: Visibility(
                visible: canBack ?? true,
                child: InkWellComp(
                  isTransparent: true,
                  onTap: () => Get.back(),
                  paddingAll: 0,
                  child: Icon(
                    Icons.close_rounded,
                    size: 32,
                    color: ColorResource.tabIndicator.withOpacity(0.37),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
