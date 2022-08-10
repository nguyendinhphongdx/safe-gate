import 'dart:convert';

import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utils {
  static String md5Encode(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static String sha256Encode(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }

  static String? concatImageLink(String? path) {
    if (path == null || path == '') return null;
    if (path.startsWith('https://') || path.startsWith('http://')) return path;
    String? s = AppConfig().getConfig().favicon;
    return s
        ?.replaceAll('\$cdn_domain', AppConfig().getConfig().getImageUrl())
        .replaceAll('\$app_name', path);
  }

  static String currency(dynamic value) {
    final formatter = NumberFormat("#,##0", "pt_BR");
    return formatter.format(value.toInt() / 100);
  }

  static bool isNotNullOrEmpty(dynamic value) {
    return value != null || value?.length != 0;
  }

  static bool isNotNullAndEmpty(dynamic value) {
    return value != null && value?.length != 0;
  }

  static void showToast(
    String message, {
    Color? colorBg,
    Color? colorText,
  }) {
    colorBg ??= ColorResource.underline.withOpacity(0.92);
    colorText ??= Colors.black.withOpacity(0.9);
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: colorBg,
      textColor: colorText,
      timeInSecForIosWeb: 10,
      fontSize: 16.0,
    );
  }

  static dynamic validateEmail({required String email}) {
    String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email) || email.isEmpty) {
      return KeyLanguage.valueNotEmail.tr;
    }
    return null;
  }
}
