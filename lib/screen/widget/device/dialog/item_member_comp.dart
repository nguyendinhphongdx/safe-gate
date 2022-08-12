import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ItemMemberComp extends StatelessWidget {
  final ProfileModel? profileModel;

  final Color? textColor;
  final Function()? onUserPressed;

  const ItemMemberComp({Key? key, this.textColor, this.profileModel, this.onUserPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 8.0),
      width: (ViewUtils.width - 100) / 4,
      child: InkWellComp(
        onTap: onUserPressed,
        paddingAll: 0,
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 10),
                    ]),
                    child: ImageViewer(
                      Utils.concatImageLink(profileModel?.profileAvatar) ?? ImageResource.ic_account,
                      width: (ViewUtils.width - 100) / 5,
                      height: (ViewUtils.width - 100) / 5,
                      fit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(500),
                    ),
                  ),
                ),
                Obx(
                  () => Positioned.fill(
                      child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: _buildTransition,
                    child: profileModel?.isSelected.value ?? false
                        ? Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500),
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                        )
                        : const SizedBox(),
                  )),
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Obx(
                    () => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: _buildCheckTransition,
                      child: profileModel?.isSelected.value ?? false
                          ? const SvgComp(
                              url: ImageResource.ic_avt_selected,
                              width: 16,
                              height: 16,
                            )
                          : const SizedBox(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              profileModel?.profileName ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: appStyle.textTheme.bodyText2
                  ?.copyWith(color: textColor ?? ColorResource.tabIndicator.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransition(Widget child, Animation<double> animation) {
    return ScaleTransition(scale: animation, child: FadeTransition(opacity: animation, child: child));
  }

  Widget _buildCheckTransition(Widget child, Animation<double> animation) {
    return ScaleTransition(scale: animation, child: child);
  }
}
