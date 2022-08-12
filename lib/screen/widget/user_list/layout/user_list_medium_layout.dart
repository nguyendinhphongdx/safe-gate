import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/layout/empty_view.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/screen/widget/time_table_edit/edit_user_controller.dart';
import 'package:base_pm2/screen/widget/user_list/comp/item_user_list_comp.dart';
import 'package:base_pm2/screen/widget/user_list/user_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListMediumLayout extends GetView<UserListController> {
  const UserListMediumLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 8),
          child: Row(
            children: [
              Expanded(child: Text(KeyLanguage.userProfiles.tr, style: appStyle.textTheme.bodyText1)),
              InkWellComp(
                  child: const SvgComp(url: ImageResource.ic_add_circle, width: 20, height: 20),
                  onTap: () => Get.toNamed(RoutePath.TIME_TABLE_EDIT,
                      parameters: EditUserArgs(type: UserEditType.PICK_MODE_AND_DEVICE).toJson()),
                  borderRadiusAll: 100),
              const SizedBox(width: 0),
              InkWellComp(
                child: const SvgComp(url: ImageResource.ic_search, width: 20, height: 20),
                onTap: () {},
                borderRadiusAll: 100,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: RefreshIndicator(
            onRefresh: controller.fetchData,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: _buildParentItem,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    ProfileModel? profileModel = controller.mProfiles[index];
    return ItemUserListGComp(profileModel: profileModel);
  }

  Widget _buildParentItem(BuildContext context, int index) {
    return Obx(() => !Utils.isNotNullAndEmpty(controller.mProfiles)
        ? Padding(padding: EdgeInsets.only(top: ViewUtils.height * 0.4), child: const EmptyView())
        : ListView.builder(
            padding:EdgeInsets.zero,
            itemBuilder: _itemBuilder,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.mProfiles.length));
  }
}
