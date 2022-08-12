import 'package:base_pm2/common/core/widget/date_picker/body_picker.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/data/model/mode_model.dart';
import 'package:base_pm2/screen/account/account_page.dart';
import 'package:base_pm2/screen/device/device_page.dart';
import 'package:base_pm2/screen/login/login_page.dart';
import 'package:base_pm2/screen/otp/opt_page.dart';
import 'package:base_pm2/screen/home/panel_screen.dart';
import 'package:base_pm2/screen/splash/splash_page.dart';
import 'package:base_pm2/screen/widget/device/dialog/device_assigned_dl.dart';
import 'package:base_pm2/screen/widget/dialog_wifi/add_wifi_dl.dart';
import 'package:base_pm2/screen/widget/dialog_wifi/find_device/search_device_dl.dart';
import 'package:base_pm2/screen/widget/edit_time/edit_time_page.dart';
import 'package:base_pm2/screen/widget/filter_access/access_filter_screen.dart';
import 'package:base_pm2/screen/widget/filter_access/add_category/add_category_page.dart';
import 'package:base_pm2/screen/widget/time_table_edit/user_edit_page.dart';
import 'package:base_pm2/screen/widget/user_detail/dialog/pause_dialog_dl.dart';
import 'package:base_pm2/screen/widget/user_detail/dialog/temporarily_open_dl.dart';
import 'package:base_pm2/screen/widget/user_detail/user_detail_page.dart';
import 'package:base_pm2/screen/widget/user_list/user_list_page.dart';
import 'package:base_pm2/screen/widget/user_mode_detail/dialog/pick_mode_dialog.dart';
import 'package:base_pm2/screen/widget/user_mode_detail/user_mode_detail_page.dart';
import 'package:base_pm2/screen/widget/user_mode_edit/user_mode_edit_page.dart';
import 'package:base_pm2/screen/widget/user_mode_list/user_mode_page.dart';
import 'package:base_pm2/screen/widget/violation/violation_page.dart';
import 'package:get/get.dart';

List<GetPage> listPage = [
  GetPage(name: RoutePath.INITIAL, page: () => SplashPage()),
  GetPage(name: RoutePath.LOGIN, page: () => LoginPage()),
  GetPage(name: RoutePath.OTP, page: () => OtpPage()),
  GetPage(name: RoutePath.PANEL, page: () => PanelPage()),
  GetPage(
      name: RoutePath.SEARCH_DEVICE,
      page: () => SearchDeviceDL(),
      opaque: false),
  GetPage(name: RoutePath.DEVICE, page: () => DevicePage()),
  GetPage(name: RoutePath.LOGIN, page: () => LoginPage()),
  GetPage(name: RoutePath.USER_MODE, page: () => UserModePage()),
  GetPage(name: RoutePath.PANEL, page: () => PanelPage()),
  GetPage(name: RoutePath.USER_MODE_EDIT, page: () => UserModeEditPage()),
  GetPage(name: RoutePath.USER_MODE_DETAIL, page: () => UserModeDetailPage()),
  GetPage(name: RoutePath.ACCESS_FILTER, page: () => AccessFilterPage()),
  GetPage(name: RoutePath.VIOLATION, page: () => ViolationPage()),
  GetPage(name: RoutePath.ADD_WIFI, page: () => AddWifiDL(), opaque: false),
  GetPage<ModeModel?>(
      name: RoutePath.SWITCH_MODE, page: () => PickModeDialog(), opaque: false),
  GetPage(
      name: RoutePath.PAUSE_DIALOG, page: () => const PauseDL(), opaque: false),
  GetPage(
      name: RoutePath.TIME_TABLE_EDIT,
      page: () => EditUserPage(),
      opaque: false),
  GetPage(
      name: RoutePath.OPEN_TMP,
      page: () => const TemporarilyOpenDL(),
      opaque: false),
  GetPage(
      name: RoutePath.DEVICE_ASSIGNED,
      page: () => DeviceAssignedDL(),
      opaque: false),
  GetPage(
      name: RoutePath.DATE_PICKER, page: () => BodyPickerPage(), opaque: false),
  GetPage(
      name: RoutePath.ADD_CATEGORY,
      page: () => AddCategoryPage(),
      opaque: false),
  GetPage(
      name: RoutePath.EDIT_CONFIG_TIME,
      page: () => EditTimePage(),
      opaque: false),
  GetPage(name: RoutePath.USER_DETAIL, page: () => UserDetailPage()),
  GetPage(name: RoutePath.USER_LIST, page: () => UserListPage()),
  GetPage(name: RoutePath.ACCOUNT, page: () => AccountPage()),
];
