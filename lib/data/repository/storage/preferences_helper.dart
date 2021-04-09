import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

/// Manager for convenient work with [SharedPreferences]
class PreferencesHelper {
  Future<SharedPreferences> get preferencesInstance =>
      SharedPreferences.getInstance();

  Future<bool> getBool(String key) async {
    final prefs = await preferencesInstance;
    return prefs.getBool(key) ?? false;
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await preferencesInstance;
    return prefs.setBool(key, value);
  }

  Future<int> getInt(String key) async {
    final prefs = await preferencesInstance;
    return prefs.getInt(key) ?? 0;
  }

  Future<void> setInt(String key, int value) async {
    final prefs = await preferencesInstance;
    return prefs.setInt(key, value);
  }

  Future<String> getString(String key) async {
    final prefs = await preferencesInstance;
    return prefs.getString(key) ?? '';
  }

  Future<void> setString(String key, String value) async {
    final prefs = await preferencesInstance;
    return prefs.setString(key, value);
  }

  Future<double> getDouble(String key) async {
    final prefs = await preferencesInstance;
    return prefs.getDouble(key) ?? 0.0;
  }

  Future<void> setDouble(String key, double value) async {
    final prefs = await preferencesInstance;
    return prefs.setDouble(key, value);
  }

  Future<List<String>> getStringList(String key) async {
    final prefs = await preferencesInstance;
    return prefs.getStringList(key) ?? [];
  }

  Future<void> setStringList(String key, List<String> value) async {
    final prefs = await preferencesInstance;
    return prefs.setStringList(key, value);
  }
}
