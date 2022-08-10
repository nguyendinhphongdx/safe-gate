import 'package:base_pm2/application.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

enum ToastMode {
  none,
  success,
  error,
}

class ViewUtils {
  static void hideKeyboard({BuildContext? context}) => Get.focusScope?.unfocus();

  static double get width => MediaQuery.of(Application.navigator.currentContext!).size.width;

  static double get height => MediaQuery.of(Application.navigator.currentContext!).size.height;

  static double get heightStatusBar => MediaQuery.of(Application.navigator.currentContext!).padding.top;

  static void openUrl(String? url) async {
    if (!await canLaunchUrlString(url ?? '')) return;
    launchUrlString(url ?? '');
  }

  static void toast(String msg, {ToastMode mode = ToastMode.none, double fontSize = 16.0}) =>
      Fluttertoast.showToast(
          msg: msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          // backgroundColor: _getToastColor(mode),
          textColor: Colors.white,
          fontSize: fontSize,
          webPosition: "right",
          webShowClose: true,
          webBgColor: _getToastColor(mode));

  static String _getToastColor(ToastMode mode) {
    switch (mode) {
      case ToastMode.success:
        return "#09ff00";
      case ToastMode.error:
        return "#ff0000";
      default:
        return "#0A1F72FF";
    }
  }
}
