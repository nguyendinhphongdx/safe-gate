import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/page_manager/page_manager.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/keylanguage_resource/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'common/core/theme/theme_manager.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);
  static final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        navigatorKey: navigator,
        title: AppConstant.APP_NAME,
        defaultTransition: Transition.fade,
        smartManagement: SmartManagement.full,
        showPerformanceOverlay: false,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        locale: LocalizationService.locale,
        getPages: listPage,
        supportedLocales: const <Locale>[
          Locale(LanguageCodeConstant.VI, LanguageCountryConstant.VI),
          Locale(LanguageCodeConstant.EN, LanguageCountryConstant.EN),
        ],
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeManager().currentStyle,
        scrollBehavior: NoScrollBehavior(),
        initialRoute: RoutePath.INITIAL,
      );
}

class NoScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
