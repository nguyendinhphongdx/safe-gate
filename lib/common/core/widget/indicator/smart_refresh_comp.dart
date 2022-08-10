import 'dart:io';

import 'package:base_pm2/common/core/sys/base_refresh_controller.dart';
import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//pull_to_refresh: ^2.0.0
class BaseSmartRefresh extends StatelessWidget {
  final BaseRefreshController? controller;
  final Widget? child;
  final Widget? header;
  final Widget? footer;
  final bool? enablePullDown;
  final bool? enablePullUp;
  final Function? onLoading;
  final Function? onRefresh;
  final Function(BuildContext context, int index)? itemBuilder;
  final ScrollPhysics? physics;
  final int? itemCount;

  const BaseSmartRefresh(
      {this.controller,
      this.child,
      this.itemBuilder,
      this.header,
      this.footer,
      this.enablePullDown,
      this.enablePullUp,
      this.onLoading,
      this.onRefresh,
      this.physics,
      required this.itemCount,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        itemCount == 0
            ? Center(
                child: Text(
                  'Không có dữ liệu',
                  style: appStyle.textTheme.bodyText1,
                ),
              )
            : const SizedBox(width: 0, height: 0),
        SmartRefresher(
          controller: controller?.controller ?? RefreshController(),
          child: child ??
              ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (context, index) =>
                      itemBuilder?.call(context, index)),
          enablePullDown: enablePullDown ?? true,
          enablePullUp: enablePullUp ?? true,
          header: header,
          footer: footer ??
              ClassicFooter(
                loadingText: 'Đang tải',
                canLoadingText: '',
                idleText: '',
                idleIcon: const SizedBox(width: 0, height: 0),
                loadingIcon: SizedBox(
                  width: 25.0,
                  height: 25.0,
                  child: Platform.isIOS
                      ? const CupertinoActivityIndicator()
                      : const CircularProgressIndicator(
                          strokeWidth: 2.0,
                          color: ColorResource.primary,
                        ),
                ),
              ),
          onLoading: () async =>
              await controller?.loadMoreData() ?? onLoading?.call(),
          onRefresh: () async =>
              await controller?.refreshData() ?? onRefresh?.call(),
          physics: physics,
        ),
      ],
    );
  }
}
