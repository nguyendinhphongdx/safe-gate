import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/screen/widget/user_mode_edit/comp/item_edit_text_comp.dart';
import 'package:base_pm2/screen/widget/user_mode_edit/comp/item_profile_comp.dart';
import 'package:base_pm2/screen/widget/user_mode_edit/user_mode_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediumLayout extends GetView<UserModeEditController> {
  const MediumLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // TODO  ten che do
                  Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          ItemEditTextComp(
                              title: KeyLanguage.name_user_mode.tr,
                              hint: KeyLanguage.child_mode.tr,
                              onValidator: (s) => controller.validate(s, 0),
                              right: const SvgComp(
                                url: ImageResource.ic_edit,
                                width: 24,
                                height: 24,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                              ),
                              edtController: controller.nameController),
                          ItemEditTextComp(
                              title: KeyLanguage.desc.tr,
                              hint: KeyLanguage.child_mode_desc.tr,
                              minLine: 1,
                              maxLine: 5,
                              edtController: controller.descController),
                        ],
                      )),
                  //TODO Danh sasch che do
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          KeyLanguage.list_u_mode.tr,
                          style: appStyle.textTheme.bodyText1,
                        ),
                      ),
                      InkWellComp(
                          onTap: () => null,
                          child:
                              const SvgComp(url: ImageResource.ic_add_circle)),
                      InkWellComp(
                          onTap: () {},
                          child: const SvgComp(url: ImageResource.ic_search)),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black.withOpacity(0.2)),
                    child: Obx(
                      () => ListView.builder(
                        itemBuilder: _buildItem,
                        itemCount: controller.subModes.length,
                        shrinkWrap: true,
                        itemExtent: 70,
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButtonComp(
              onPressed: () {
                ViewUtils.hideKeyboard(context: context);
                controller.save();
              },
              title: KeyLanguage.confirm.tr,
              widthValue: double.infinity,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    ProfileModel model = controller.subModes[index];
    return ItemProfileComp(
      mode: model,
      maxLineDesc: 1,
    );
  }
}
