import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/screen/login/login_page.dart';
import 'package:base_pm2/screen/otp/opt_page.dart';
import 'package:base_pm2/screen/home/panel_screen.dart';
import 'package:base_pm2/screen/splash/splash_page.dart';
import 'package:base_pm2/screen/widget/dialog_wifi/find_device/search_device_dl.dart';
import 'package:get/get.dart';

List<GetPage> listPage = [
  GetPage(name: RoutePath.INITIAL, page: () => SplashPage()),
  GetPage(name: RoutePath.LOGIN, page: () => LoginPage()),
  GetPage(name: RoutePath.OTP, page: () => OtpPage()),
  GetPage(name: RoutePath.PANEL, page: () => PanelPage()),
  GetPage(name: RoutePath.SEARCH_DEVICE, page: () => SearchDeviceDL(), opaque: false),
];
