import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/avatar/avatar_pick_comp.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/common/resource/keylanguage_resource/key_language.dart';
import 'package:base_pm2/data/model/mode_model.dart';
import 'package:base_pm2/screen/widget/time_table_edit/comp/item_mode_pick.dart';
import 'package:base_pm2/screen/widget/time_table_edit/comp/pick_user_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickUserModeLayout extends GetWidget<PickUserModeController> {
  PickUserModeLayout({Key? key}) : super(key: key) {
    Get.lazyPut(() => PickUserModeController());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.getStatus() == Status.loading
          ? const Center(
              child: IndicatorComp(
              backgroundColor: Colors.transparent,
              indicatorColor: ColorResource.primary,
            ))
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Text(
                        KeyLanguage.add_new.tr,
                        style: appStyle.textTheme.bodyText2?.copyWith(
                            color: ColorResource.tabIndicator, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      const PickAvatarComp(
                        imageSize: Size(76, 76),
                        iconSize: Size(20, 20),
                        textColor: ColorResource.tabIndicator,
                        shouldShowName: false,
                        inkwellPadding: EdgeInsets.zero,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Form(
                        key: controller.formKey,
                        child: IntrinsicWidth(
                          child: TextFieldComp(
                            editingController: controller.profileName,
                            onValidator: controller.onValidate,
                            isBorder: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                            borderColor: ColorResource.bottomBarItem,
                            hint: KeyLanguage.hint_profile_name.tr,
                            textAlign: TextAlign.center,
                            style: appStyle.textTheme.bodyText1
                                ?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
                            hintStyle: appStyle.textTheme.bodyText1?.apply(color: Colors.black.withOpacity(.5)),
                            enableDefauSuffix: false,
                            padV: 0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(color: ColorResource.grayLine,width: double.infinity,height: 0.5,),
                      const SizedBox(height: 16),
                      Text(
                        KeyLanguage.profile_mode.tr,
                        style: appStyle.textTheme.bodyText1
                            ?.copyWith(color: ColorResource.primary, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: _buildTransition,
                        child: controller.error.value == ''
                            ? const SizedBox()
                            : Text(controller.error.value,
                                style: appStyle.textTheme.bodyText2?.apply(color: Colors.red)),
                      ),
                      Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: _buildItem,
                          itemCount: controller.mModeData.length,
                          padding: EdgeInsets.zero,
                          itemExtent: 75,
                        ),
                      )
                    ],
                  ),
                ),
                if (controller.getStatus() == Status.waiting)
                  const Center(
                      child: IndicatorComp(
                    backgroundColor: Colors.transparent,
                    indicatorColor: ColorResource.primary,
                  ))
              ],
            ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    ModeModel model = controller.mModeData[index];
    return Obx(
      () => ItemModePickComp(
        mode: model,
        shouldShowArrow: false,
        onModePress: controller.onPressMode,
        isActive: model.isActive!.value,
      ),
    );
  }

  Widget _buildTransition(Widget child, Animation<double> animation) {
    return SizeTransition(sizeFactor: animation, child: child);
  }
}
