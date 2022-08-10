import 'dart:io';
import 'dart:ui';

import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'en_us.dart';
import 'vi_vn.dart';

class LocalizationService extends Translations {
  static final locale = _getLocaleFromLanguage();

  //static final locale = Get.locale;

  static const fallbackLocale = Locale(LanguageCodeConstant.VI, LanguageCountryConstant.VI);

  static final langCodes = [LanguageCodeConstant.EN, LanguageCodeConstant.VI];

  static final locales = [
    const Locale(LanguageCodeConstant.EN, LanguageCountryConstant.EN),
    const Locale(LanguageCodeConstant.VI, LanguageCountryConstant.VI),
  ];

  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    LocalStorage().put(StorageKey.LANGUAGE, langCode);
    Get.updateLocale(locale!);
  }

  static Locale? _getLocaleFromLanguage({String? langCode}) {
    String? languageCode =
        LocalStorage().get<String>(StorageKey.LANGUAGE) ?? Intl.shortLocale(Platform.localeName);
    var lang = langCode ?? languageCode;

    LocalStorage().put(StorageKey.LANGUAGE, lang);

    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return Get.locale;
  }

  @override
  Map<String, Map<String, String>> get keys => {'en_US': en, 'vi_VN': vi};
}
