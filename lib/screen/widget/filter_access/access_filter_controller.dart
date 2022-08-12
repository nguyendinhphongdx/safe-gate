import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccessFilterArgs {
  String? id;
  String? title;

  AccessFilterArgs({this.id, this.title});

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['id'] = id ?? '';
    data['title'] = title ?? '';
    return data;
  }

  AccessFilterArgs.fromJson(Map<String, String?> json) {
    id = json['id'] ?? '';
    title = json['title'] ?? '';
  }
}

class AccessFilterController extends BaseController with GetTickerProviderStateMixin{
  AccessFilterArgs? args;
  TabController? tabController;

  @override
  Future initialData() async {
    args = AccessFilterArgs.fromJson(Get.parameters);
    tabController = TabController(length: 2, vsync: this);
    setStatus(Status.success);
    await super.initialData();
  }
}
