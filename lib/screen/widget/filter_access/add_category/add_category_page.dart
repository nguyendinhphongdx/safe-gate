import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/core/widget/button/button_dialog.dart';
import 'package:base_pm2/common/core/widget/dialog/bg_dialog_comp.dart';
import 'package:base_pm2/common/core/widget/image/image_viewer.dart';
import 'package:base_pm2/common/core/widget/text_field/text_field_comp.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:base_pm2/data/model/widget/category_model.dart';
import 'package:base_pm2/screen/widget/filter_access/add_category/add_category_controller.dart';
import 'package:base_pm2/screen/widget/filter_access/add_category/item_category_comp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCategoryPage extends GetWidget<AddCategoryController> {
  AddCategoryPage({Key? key}) : super(key: key) {
    Get.lazyPut(() => AddCategoryController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BgDialogComp(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => Container(
                  constraints: BoxConstraints(maxHeight: Get.height * 0.8),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 24),
                      Text('Thêm mới nhóm ứng dụng',
                          style: appStyle.textTheme.bodyText1?.copyWith(
                              fontSize: 16, color: ColorResource.tabIndicator, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.05),
                              blurRadius: 5,
                              offset: const Offset(0, -4))
                        ]),
                        child: TextFieldComp(
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          borderRadius: 100,
                          style: appStyle.textTheme.bodyText2?.copyWith(color: Colors.black),
                          hintStyle:
                              appStyle.textTheme.bodyText2?.copyWith(color: Colors.black.withOpacity(.5)),
                          hint: 'Nhập tên nhóm để tìm kiếm',
                          onChange: controller.onSearch,
                          suffixIcon: const Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 16, 6),
                            child: ImageViewer(
                              ImageResource.ic_ios_search,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          fillColor: Colors.white.withOpacity(.6),
                          isBorder: true,
                          borderColor: Colors.white.withOpacity(.6),
                        ),
                      ),
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 12),
                              Visibility(
                                visible: Utils.isNotNullAndEmpty(controller.categoriesChecked),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Đã chọn ${controller.categoriesChecked.length} ứng dụng',
                                          style: appStyle.textTheme.bodyText1?.copyWith(
                                              fontSize: 12,
                                              color: ColorResource.tabIndicator.withOpacity(.6))),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                        width: double.infinity, height: 1, color: ColorResource.tabIndicator),
                                    const SizedBox(height: 4),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ...controller.categoriesChecked
                                            .mapIndexed<Widget>(_buildItemPicked)
                                            .toList(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              AnimatedSwitcher(
                                duration: Duration(milliseconds: 200),
                                child: controller.categories.isEmpty
                                    ? Text('Không tìm thấy nhóm ứng dụng nào',
                                        style: appStyle.textTheme.bodyText1?.copyWith(
                                            fontSize: 12, color: ColorResource.tabIndicator.withOpacity(.6)))
                                    : Column(
                                        children: [
                                          const SizedBox(height: 12),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('Tìm thấy ${controller.categories.length} ứng dụng',
                                                style: appStyle.textTheme.bodyText1?.copyWith(
                                                    fontSize: 12,
                                                    color: ColorResource.tabIndicator.withOpacity(.6))),
                                          ),
                                          const SizedBox(height: 4),
                                          Container(
                                              width: double.infinity,
                                              height: 1,
                                              color: ColorResource.tabIndicator),
                                          const SizedBox(height: 4),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ...controller.categories
                                                  .mapIndexed<Widget>(_buildItem)
                                                  .toList(),
                                            ],
                                          ),
                                        ],
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ButtonDialog(
                confirmLabel: 'Hoàn thành',
                cancelLabel: 'Quay lại',
                onCancel: Get.back,
                onConfirm: controller.confirmApplication,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index, CategoryModel? element) {
    return ItemCategoryComp(
        categoryModel: element, onChangeStatus: () => controller.changeStatusOrigin(element));
  }

  Widget _buildItemPicked(int index, CategoryModel? element) {
    return ItemCategoryComp(categoryModel: element, onChangeStatus: () => controller.onActiveChange(element));
  }
}
