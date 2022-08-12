import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_auth/LocalAuth.dart';
import 'package:base_pm2/common/local_storage/local_storage.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/keylanguage_resource/localization_service.dart';
import 'package:base_pm2/screen/otp/otp_controller.dart';
import 'package:base_pm2/common/resource/enum_resource.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginController extends BaseController implements LocalAuthListener {
  TextEditingController phoneEdtController = TextEditingController(text: kDebugMode ? '0123456789' : null);
  TextEditingController pwdController = TextEditingController(text: kDebugMode ? '123456' : null);

  Rx<bool> isAuth = false.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final GlobalKey<PopupMenuButtonState> popupMenu = GlobalKey<PopupMenuButtonState>();
  List<String> languageList = [];
  RxBool showLanguage = false.obs;
  RxString currentArena = CountryCode.VN_CODE.obs;

  @override
  Future<void> initialData() {
    languageList.addAll([
      KeyLanguage.language_vi.tr,
      KeyLanguage.language_en.tr,
    ]);
    String languageCode = LocalStorage().get<String>(StorageKey.LANGUAGE);
    showLanguage.value = languageCode == LanguageCodeConstant.VI;
    setStatus(Status.success);
    return super.initialData();
  }

  localAuth() {
    LocalAuth().checkLocalAuth(this, KeyLanguage.localAuthNotAvailable.tr);
  }

  @override
  authenticated(authenticated) {
    throw UnimplementedError();
  }

  String? validatePhone(int index) {
    switch (index) {
      case 0:
        String pattern = r'(^(?:[0])?[0-9]{9,12}$)';
        RegExp regExp = RegExp(pattern);
        if (phoneEdtController.text.isEmpty) {
          return KeyLanguage.cannot_blank.tr;
        } else if (!regExp.hasMatch(phoneEdtController.text)) {
          return KeyLanguage.notPhone.tr;
        }
        break;
      case 1:
        if (pwdController.text.isEmpty) {
          return KeyLanguage.cannot_blank.tr;
        } else if (pwdController.text.length < 6) {
          return KeyLanguage.lessSix.tr;
        }
    }
    return null;
  }

  Future<void> loginCall() async {
    Get.toNamed(RoutePath.OTP,
        parameters:
            OtpArgs(otpType: OtpType.OTP_LOGIN, phoneNumber: '$currentArena${phoneEdtController.text}')
                .toJson());
  }

  void onChangeLanguage() {
    showLanguage.value = !showLanguage.value;
    LocalizationService.changeLocale(showLanguage.value ? LanguageCodeConstant.VI : LanguageCodeConstant.EN);
  }

  void onArenaPressed() {
    popupMenu.currentState?.showButtonMenu();
  }

  void onMenuSelected(value) {
    if (value == ArenaCode.VIETNAM) currentArena.value = CountryCode.VN_CODE;
    if (value == ArenaCode.UK) currentArena.value = CountryCode.UK_CODE;
    if (value == ArenaCode.US) currentArena.value = CountryCode.US_CODE;
  }
}

class PhoneLocation {
  String? value;
  String? img;
  String? name;

  PhoneLocation({this.value, this.img, this.name});
}
