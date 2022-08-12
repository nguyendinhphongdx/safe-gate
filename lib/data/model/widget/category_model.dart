import 'package:base_pm2/data/model/widget/app/application_model.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryModel {
  int? updatedTime;
  String? categoryInfo;
  String? categoryName;
  int? categoryId;
  String? categoryAlias;
  int? createdTime;
  RxBool? isActive = false.obs;

  List<RuleAppModel>? ruleModels;
  RxList<RuleAppModel>? rxRuleModels;
  ExpandableController? expController;
  RxBool? isTimeActive;
  RxString? rxType;
  GlobalKey<PopupMenuButtonState> popupKey = GlobalKey<PopupMenuButtonState>();

  CategoryModel(
      {this.updatedTime,
      this.categoryInfo,
      this.categoryName,
      this.categoryId,
      this.categoryAlias,
      this.createdTime});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    updatedTime = json['updatedTime'];
    categoryInfo = json['category_info'];
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    categoryAlias = json['category_alias'];
    createdTime = json['createdTime'];
    expController = ExpandableController();
    isTimeActive = false.obs;
    rxType = ''.obs;
    rxRuleModels = <RuleAppModel>[].obs;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['updatedTime'] = updatedTime;
    data['category_info'] = categoryInfo;
    data['category_name'] = categoryName;
    data['category_id'] = categoryId;
    data['category_alias'] = categoryAlias;
    data['createdTime'] = createdTime;
    return data;
  }
}
