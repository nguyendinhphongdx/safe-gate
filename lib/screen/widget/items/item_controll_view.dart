import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemControlView extends StatelessWidget {
  final Function()? onChangeStatus;
  final ProfileModel? user;
  final Function()? onUserPressed;

  const ItemControlView({Key? key, this.onChangeStatus, this.user, this.onUserPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(16),
            gradient: user?.status.value == UserStatus.ACTIVE
                ? const LinearGradient(colors: [
                    Color(0xFFD1D1D1),
                    Color(0xFFFFFFFF),
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)
                : null),
        child: InkWellComp(
          onTap: onUserPressed,
          padding: const EdgeInsets.symmetric(vertical: 6),
          paddingAll: 0,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ImageViewer(
                  Utils.concatImageLink(user?.profileAvatar) ?? ImageResource.ic_account,
                  width: 60,
                  height: 60,
                  borderRadius: BorderRadius.circular(100),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.profileName ?? '',
                        style: appStyle.textTheme.bodyText2
                            ?.copyWith(fontWeight: FontWeight.w600, color: _getNameColor()),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text('${KeyLanguage.violation_of_the_day.tr}: ${user?.violateCount ?? '0'}',
                              maxLines: 1,
                              style: appStyle.textTheme.bodyText2?.apply(color: _getBodyColor())),
                          const SizedBox(width: 5),
                          if ((user?.violateCount ?? 0) > 0)
                            const SvgComp(
                              url: ImageResource.ic_warning,
                              color: ColorResource.pauseColor,
                              width: 16,
                              height: 16,
                            )
                        ],
                      ),
                      Text(
                        '${KeyLanguage.connecting.tr}: ${user?.deviceConnecting ?? '0'} ${KeyLanguage.device.tr.toLowerCase()}',
                        maxLines: 1,
                        style: appStyle.textTheme.bodyText2?.apply(color: _getBodyColor()),
                      ),
                      // const SizedBox(height: 6),
                      // Text(
                      //   _getTextStatus(),
                      //   maxLines: 1,
                      //   style: appStyle.textTheme.bodyText2?.apply(color: _getStatusColor()),
                      // ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: user?.status.value != UserStatus.OFFLINE,
                child: InkWell(
                  onTap: onChangeStatus,
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        color: user?.status.value == UserStatus.ACTIVE ? Colors.red : Colors.transparent,
                        borderRadius: BorderRadius.circular(48),
                        border: Border.all(color: Colors.red, width: 1)),
                    child: Text(
                      user?.status.value == UserStatus.ACTIVE
                          ? KeyLanguage.pause.tr
                          : KeyLanguage.re_opened.tr,
                      style: appStyle.textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }

  Color _getNameColor() {
    switch (user?.status.value) {
      case UserStatus.ACTIVE:
        return ColorResource.primary;
      case UserStatus.PAUSE:
        return Colors.white;
    }
    return Colors.white.withOpacity(.7);
  }

  Color _getBodyColor() {
    switch (user?.status.value) {
      case UserStatus.ACTIVE:
        return ColorResource.tabIndicator;
      case UserStatus.PAUSE:
        return Colors.white;
    }
    return Colors.white.withOpacity(.7);
  }

  // ignore: unused_element
  String _getTextStatus() {
    switch (user?.status.value) {
      case UserStatus.ACTIVE:
        return 'Đang hoạt động';
      case UserStatus.PAUSE:
        return 'Đang tạm dừng';
    }
    return 'Đang offline';
  }

  Color? _getBackgroundColor() {
    switch (user?.status.value) {
      case UserStatus.ACTIVE:
        return null;
      case UserStatus.PAUSE:
        return const Color(0xFF5B6FA8).withOpacity(.9);
    }
    return ColorResource.offline.withOpacity(.6);
  }

  // ignore: unused_element
  Color _getStatusColor() {
    switch (user?.status.value) {
      case UserStatus.ACTIVE:
        return ColorResource.primary;
      case UserStatus.PAUSE:
        return ColorResource.pause;
    }
    return Colors.red;
  }
}
