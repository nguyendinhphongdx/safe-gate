import 'package:base_pm2/common/core/sys/config_model.dart';
import 'package:base_pm2/common/resource/report_color.dart';
import 'package:flutter/material.dart';

abstract class AppConfigBase {
  bool _isAuthenticated = false;
  String _deviceId = '';
  ConfigModel? _config;
  late List<Color> mColors;

  bool isAuthenticated() => _isAuthenticated;

  String getDeviceId() => _deviceId;

  ConfigModel getConfig() => _config!;

  void setHasAuthenticated(bool b) => _isAuthenticated = b;

  void setConfig({ConfigModel? config}) => _config = config ?? ConfigModel();

  void setDeviceId({String? deviceId}) => _deviceId = deviceId ?? '';

  void randomColor() {
    mColors = [];
    for (int i = 0; i < colors.length; i++) {
      mColors.add(colors[i]);
    }
  }

  Future<void> authenticate();

  Future<void> unAuthenticate();
}
