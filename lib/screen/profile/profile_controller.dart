import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/extension/datetime_extension.dart';
import 'package:base_pm2/common/extension/string_extension.dart';
import 'package:base_pm2/common/helper/view_utils.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/profile/account_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/core/widget/bottom_sheet/cupertino_picker_bottom_shet.dart';

class ProfileController extends BaseController {
  var fullNameController = TextEditingController().obs;
  var phoneNumberController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var birthdayController = TextEditingController().obs;
  XFile? xFile;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validator(int index) {
    switch (index) {
      case 0:
        if (fullNameController.value.text.isEmpty) {
          return 'Vui lòng nhập họ và tên';
        }
        break;
      case 1:
        if (phoneNumberController.value.text.isEmpty) {
          return 'Vui lòng nhập số điện thoại';
        }
        if (!phoneNumberController.value.text.isValidPhone) {
          return 'Số điện thoại không đúng định dạng';
        }
        break;
      case 2:
        if (emailController.value.text.isEmpty) {
          return 'Vui lòng nhập email';
        }
        if (!emailController.value.text.isValidEmail) {
          return 'Email không đúng định dạng';
        }
        break;
    }
    return null;
  }

  @override
  Future<void> initialData() async {
    await fetchData();
  }

  Future<void> onUpdateProfile() async {
    ViewUtils.hideKeyboard();
    if (formKey.currentState!.validate()) {
      setStatus(Status.waiting);
      await updateProfileUseCase();
    }
  }

  Future<void> updateProfileUseCase() async {
    if (await getConnection(reconnect: updateProfileUseCase)) return;
    AccountModel accountModel = AccountModel(
      name: fullNameController.value.text,
      phone: phoneNumberController.value.text,
      email: emailController.value.text,
      birthday: birthdayController.value.text,
      avatar: xFile?.path
    );
    //
    // ApiResponse response = await UpdateAccountUseCase(
    //         accountModel: accountModel, repository: AccountRepositoryImpl())
    //     .invoke();
    // if (checkCode(response)) return;

    ViewUtils.toast('Cập nhật hồ sơ thành công', mode: ToastMode.success);
    Get.back();
    setStatus(Status.success);
  }

  Future<void> getBirthday() async {
    DateTime? date = await Get.bottomSheet(
        CupertinoPickerBottomSheet(
          isShowCancel: true,
          isShowConfirm: true,
          maximumDate: DateTime.now(),
          initialDateTime: DateTime(DateTime.now().year - 1,
              DateTime.now().month, DateTime.now().day),
        ),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))));
    if (date == null) return;
    birthdayController.value.text = date.dayMonthYear;
  }

  @override
  Future<void> fetchData() async {
    if (await getConnection(reconnect: fetchData)) return;

    // ApiResponse response =
    //     await GetInfoAccountUseCase(repository: AccountRepositoryImpl())
    //         .invoke();
    // if (checkCode(response)) return;
    // if (checkNull(response.data)) return;
    // AccountModel accountModel = response.data;
    // fullNameController.value.text = accountModel.name ?? '';
    // phoneNumberController.value.text = accountModel.phone ?? '';
    // emailController.value.text = accountModel.email ?? '';
    // birthdayController.value.text = accountModel.birthday?.changeFormatDateTime(newPattern: ddMMyyyy, currentPattern: yyyyMMddTHHmmssSSS) ?? '';

    setStatus(Status.success);
  }

  void callBackFile(XFile? file){
    xFile=file;
  }
}
