import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/avatar/avatar_pick_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/profile/comp/text_filed_comp.dart';
import 'package:base_pm2/screen/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileMediumLayout extends GetView<ProfileController> {
  const ProfileMediumLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              PickAvatarComp(
                iconSize: const Size(22, 22),
                imageSize: Size(136,136),
                editPosition: const Offset(20, 0),
                callBackFile: controller.callBackFile,
                inkwellPadding: EdgeInsets.zero,
                shouldShowName: false,
              ),
              const SizedBox(height: 32),
              itemTextFieldComp(
                icon: ImageResource.ic_account,
                textController: controller.fullNameController.value,
                hint: KeyLanguage.full_name.tr,

                onValidator: (value) => controller.validator(0),
              ),
              const SizedBox(height: 28),
              itemTextFieldComp(
                icon: ImageResource.ic_phone,
                colorIcon: Colors.red,
                textController: controller.phoneNumberController.value,
                hint: KeyLanguage.phone.tr,
                onValidator: (value) => controller.validator(1),
              ),
              const SizedBox(height: 28),
              itemTextFieldComp(
                icon: ImageResource.ic_email,
                textController: controller.emailController.value,
                hint: KeyLanguage.email.tr,
                onValidator: (value) => controller.validator(2),
              ),
              const SizedBox(height: 28),
              itemTextFieldComp(
                icon: ImageResource.ic_birthday,
                textController: controller.birthdayController.value,
                hint: KeyLanguage.birthday.tr,
                isReadOnly: true,
                onTap: () => controller.getBirthday(),
              ),
              const SizedBox(height: 24),
              buttonSaveComp,
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget get buttonSaveComp => ElevatedButtonComp(
        onPressed: controller.onUpdateProfile,
        title: Text(KeyLanguage.save.tr),
        style: appStyle.textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w500),
        widthValue: ViewUtils.width *0.5,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 32),
      );

  Widget itemTextFieldComp({
    required String icon,
    Color? colorIcon,
    required TextEditingController textController,
    required String hint,
    TextInputAction? inputAction,
    Function? onValidator,
    TextInputType? inputType,
    Function(String value)? onFieldSubmitted,
    bool? isReadOnly,
    Function()? onTap,
    TextCapitalization? capitalization,
    TextStyle? hintStyle,
  }) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SvgComp(
              url: icon,
              width: 28,
              height: 28,
              color: colorIcon,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextFiledBackGroundComp(
              editingController: textController,
              hint: hint,
              padV: 4,
              inputAction: inputAction,
              onValidator: (value) => onValidator?.call(value),
              isReadOnly: isReadOnly,
              onTap: () => onTap?.call(),
              capitalization: capitalization,
            ),
          ),
        ],
      );
}
