import 'dart:async';

import 'package:flutter/material.dart';

class CountTimer {
  int? milliseconds;
  Timer? _timer;

  CountTimer(this.milliseconds);

  void start(VoidCallback callback) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds ?? 500), callback);
  }
}
