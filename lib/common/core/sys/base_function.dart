import 'dart:developer';

/*
Black:   \x1B[30m
Red:     \x1B[31m
Green:   \x1B[32m
Yellow:  \x1B[33m
Blue:    \x1B[34m
Magenta: \x1B[35m
Cyan:    \x1B[36m
White:   \x1B[37m
Reset:   \x1B[0m*/

void showLog(dynamic message) {
  print('\x1B[34m[SAFE GATE] $message\x1B[0m');
}

void showError(Object? message) {
  log('', error: message.toString(), name: 'APP EXCEPTION');
}

void showWarning(Object message) {
  print('\x1B[33m[SAFE GATE] $message\x1B[0m');
}

void showLogState(Object message) {
  print('\x1B[36m[SAFE GATE] $message\x1B[0m');
}

void showDioLog(Object message) {
  print('\x1B[35m[SAFE GATE] $message\x1B[0m');
}
