// ignore_for_file: file_names, unused_field, unused_catch_clause

import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/resource/keylanguage_resource/key_language.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:get/get.dart';
import 'dart:convert';

class LocalAuthListener {
  authenticated(authenticated) {}
}

/*
 * @author TaiDM
 * @date 23-09-2021 12:42 AM
 * @update Fix bug App Not Response on below api 21
 * Name bug: You need to use a Theme.AppCompat theme (or descendant) with this activity.
 * <activity
            android:name=".MainActivity"
            android:theme="@style/Theme.AppCompat.NoActionBar"
            ...>
 */

class LocalAuth {
  late LocalAuthListener listener;

  /*
  * Local Authent
  * */
  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType>? _availableBiometrics;

  var isSupportLocalAuth = false;

  Future<void> checkLocalAuth(
      LocalAuthListener listener, String message) async {
    // var localAuthAvailable =
    //     await SharedPref.getBool(KeyResource.availableAuth);
    // print("localAuthAvailable: $localAuthAvailable");
    // if (!localAuthAvailable) {
    //   Utils.showToast("${message}");
    // } else {
    this.listener = listener;
    auth.isDeviceSupported().then((isSupported) {
      if (isSupported) {
        isSupportLocalAuth = true;
        _checkBiometrics();
      } else {
        listener.authenticated(false);
        Utils.showToast(KeyLanguage.localAuthNotAvailable.tr);
      }
    });
    // }
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;

      listener.authenticated(false);
    }
    if (canCheckBiometrics) {
      _authenticateWithBiometrics();
    } else {
      Utils.showToast("Local authenticate not support device!");
      listener.authenticated(false);
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: KeyLanguage.localized_reason.tr,
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      Utils.showToast("Error - ${e.message}");
      listener.authenticated(false);
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    if (authenticated) {
      listener.authenticated(true);
    } else {
      // Utils.showToast("Unable to verify identity. Please try again later!");
      listener.authenticated(false);
    }
    // ignore: avoid_print
    print("Local Auth: $message");
  }
}

class EncodeUtils {
  // String encoded = base64.encode(utf8.encode(credentials));
  // String decoded = utf8.decode(base64.decode(encoded));

  String encode(credentials) {
    return base64.encode(utf8.encode(credentials));
  }

  String decode(encoded) {
    return utf8.decode(base64.decode(encoded));
  }
}
