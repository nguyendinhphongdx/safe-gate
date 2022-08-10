import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._internal();

  static final LocalStorage _storage = LocalStorage._internal();

  factory LocalStorage() => _storage;
  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> put(String key, dynamic value, {bool isEncode = false}) async {
    switch (value.runtimeType) {
      case String:
        await prefs.setString(key, value);
        break;
      case double:
        await prefs.setDouble(key, value);
        break;
      case bool:
        await prefs.setBool(key, value);
        break;
      case int:
        await prefs.setInt(key, value);
        break;
      default:
        await prefs.setString(key, jsonEncode(value));
        break;
    }
  }

  dynamic get<T>(String key, [dynamic defaultValue]) {
    if (!isExist(key)) return defaultValue;
    
    switch (T) {
      case String:
        return prefs.getString(key) ?? defaultValue;
      case double:
        return prefs.getDouble(key) ?? defaultValue;
      case bool:
        return prefs.getBool(key) ?? defaultValue;
      case int:
        return prefs.getInt(key) ?? defaultValue;

      default:
        String? s = prefs.getString(key);
        if (s == null) return defaultValue;
        return jsonDecode(s);
    }
  }

  bool isExist(String key) => prefs.containsKey(key);

  Future<void> delete(String key) async {
    if (!isExist(key)) return;
    await prefs.remove(key);
  }

  Future<void> clearAll() async {
    await prefs.remove(StorageKey.ACCOUNT);
  }
}

class StorageKey {
  static const String THEME = 'theme';
  static const String LANGUAGE = 'language';
  static const String ACCOUNT = 'account';
}
