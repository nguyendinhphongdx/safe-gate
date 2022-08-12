import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/enum_resource.dart';
import 'package:base_pm2/screen/device/device_controller.dart';
import 'package:base_pm2/screen/report/controllers/last_week_controller.dart';
import 'package:base_pm2/screen/report/controllers/option_controller.dart';
import 'package:base_pm2/screen/report/controllers/this_week_controller.dart';
import 'package:base_pm2/screen/report/controllers/yesterday_controller.dart';
import 'package:base_pm2/screen/report/today_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_list_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class PanelController extends BaseController {
  PageController? pageController;
  RxInt currentTab = 2.obs;
  DateTime now = DateTime.now();

  @override
  Future<void> initialData() async{
    pageController = PageController(initialPage: currentTab.value);
    setStatus(Status.success);
    DateTime current = DateTime.now();
    now = DateTimeUtils.custom(mYear: current.year, mMonth: current.month, mDay: current.day);
  }

  void onChangePage(int value) {
    pageController?.jumpToPage(value);
    currentTab.value = value;
  }

  @override
  Future<void> onReady() async {
    Get.toNamed(RoutePath.SEARCH_DEVICE);
    super.onReady();
  }

  void resumedData() async {
    DateTime current = DateTime.now();
    DateTime resumedTime =
        DateTimeUtils.custom(mYear: current.year, mMonth: current.month, mDay: current.day);
    if (now.compareTo(resumedTime) == 0) return;
    if (Get.isRegistered<TodayController>()) Get.find<TodayController>().fetchData();
    if (Get.isRegistered<YesterdayController>()) Get.find<YesterdayController>().fetchData();
    if (Get.isRegistered<ThisWeekController>()) Get.find<ThisWeekController>().fetchData();
    if (Get.isRegistered<LastWeekController>()) Get.find<LastWeekController>().fetchData();
    if (Get.isRegistered<OptionController>()) Get.find<OptionController>().fetchData();
    if (Get.isRegistered<UserListController>()) Get.find<UserListController>().fetchData();
    if (Get.isRegistered<DeviceController>()) Get.find<DeviceController>().fetchData();
  }
}
