import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  late SharedPreferences _prefs;

  CacheService() {
    init();
  }

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> setMap(String key, Map<String, dynamic> value) async {
    return await _prefs.setString(key, jsonEncode(value));
  }

  Map<String, dynamic>? getMap(String key) {
    return _prefs.getString(key) != null ? jsonDecode(_prefs.getString(key)!) : null;
  }

  // Future<bool> setString(String key, String value) async {
  //   return await _prefs.setString(key, value);
  // }

  // String? getString(String key) {
  //   return _prefs.getString(key);
  // }

  // Future<bool> setBool(String key, bool value) async {
  //   return await _prefs.setBool(key, value);
  // }

  // bool? getBool(String key) {
  //   return _prefs.getBool(key);
  // }

  // Future<bool> delete(String key) async {
  //   return await _prefs.remove(key);
  // }

  // Future<bool> exists(String key) async {
  //   return _prefs.containsKey(key);
  // }
}
