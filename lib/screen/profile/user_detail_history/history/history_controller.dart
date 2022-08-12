import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryController extends BaseController with GetSingleTickerProviderStateMixin{
  TabController? tabController;

  @override
  Future<void> initialData() async {
    tabController = TabController(length: 2, vsync: this,initialIndex: 1);
    setStatus(Status.success);
  }


  @override
  Future<void> fetchData() async{

  }
}
