import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class IndicatorComp extends StatelessWidget {
  const IndicatorComp({Key? key, this.status, this.backgroundColor, this.indicatorColor}) : super(key: key);
  final Status? status;
  final Color? backgroundColor;
  final Color? indicatorColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: backgroundColor ?? Colors.black.withOpacity(0.1),
        child: _getIndicator());
  }

  Widget _getIndicator() {
    return SpinKitFadingCircle(color: indicatorColor ?? Colors.white, size: 46);
    /*if (kIsWeb) {
      return const LinearProgressIndicator(color: ColorResource.primary);
    }

    if (Platform.isIOS) {
      return const CupertinoActivityIndicator(color: ColorResource.primary);
    }
    return const CircularProgressIndicator(color: Colors.white);*/
  }
}
