import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

ThemeData appStyle = Theme.of(Get.context!);

class ThemeManager {
  ThemeManager._internal();

  static ThemeManager get _instance => ThemeManager._internal();

  factory ThemeManager() => _instance;

  ThemeData currentStyle = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        centerTitle: true,
        titleSpacing: 0,
        titleTextStyle: TextStyle(fontWeight: FontWeight.w400, color: ColorResource.textBody, fontSize: 16)),
    primaryColor: ColorResource.primary,
    indicatorColor: ColorResource.primary,
    backgroundColor: Colors.white,
    dividerColor: ColorResource.divider,
    toggleableActiveColor: ColorResource.primary,
    primarySwatch: ColorResource.primarySwatchMaterial,
    scaffoldBackgroundColor: Colors.white,

    buttonColor: ColorResource.primary,
    fontFamily: 'OpenSans',
    textTheme: TextTheme(
      headline6: const TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 14),
      headline5: const TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 16),
      headline4: const TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 18),
      headline3: const TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 20),
      headline2: const TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 22),
      headline1: const TextStyle(fontWeight: FontWeight.w600, color: ColorResource.textBody, fontSize: 24),
      bodyText1: const TextStyle(fontWeight: FontWeight.w400, color: ColorResource.textBody, fontSize: 14),
      bodyText2: const TextStyle(fontWeight: FontWeight.w400, color: ColorResource.textBody, fontSize: 12),
      subtitle1: TextStyle(fontWeight: FontWeight.w400, color: Colors.white.withOpacity(.6), fontSize: 12),
      subtitle2: TextStyle(fontWeight: FontWeight.w400, color: Colors.white.withOpacity(.6), fontSize: 10),

    ),
  );
}
