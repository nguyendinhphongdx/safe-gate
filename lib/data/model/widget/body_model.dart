import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/app_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BodyModel {
  int? id;
  TextEditingController? wifiName;
  TextEditingController? wifiPass;
  RxString? wifiHash;
  RxString? frequency;
  RxString? bandwidth;
  RxBool? noShowNameWifi;
  RxBool? useEnable;

  RxBool? isNotEmptyPass;

  BodyModel({
    this.id,
    this.wifiName,
    this.wifiPass,
    this.wifiHash,
    this.frequency,
    this.bandwidth,
    this.noShowNameWifi,
    this.useEnable,
  }) {
    wifiName ??= TextEditingController();
    wifiPass ??= TextEditingController();
    wifiHash ??= ''.obs;
    frequency ??= ''.obs;
    bandwidth ??= ''.obs;
    noShowNameWifi ??= false.obs;
    useEnable ??= false.obs;
    isNotEmptyPass ??= false.obs;
    wifiPass?.addListener(() {
      isNotEmptyPass?.value = wifiPass?.text.isNotEmpty ?? false;
    });
  }

  @override
  String toString() {
    return 'id: $id,  wifiName: ${wifiName?.text} ,  wifiPass: ${wifiPass?.text}, wifiHash: $wifiHash,frequency: '
        '$frequency,bandwidth: $bandwidth,noShowNameWifi: $noShowNameWifi,useEnable: $useEnable, isNotEmptyPass: $isNotEmptyPass';
  }
}
