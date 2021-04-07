import 'package:places/data/repository/storage/preferences_keys.dart';
import 'package:places/data/repository/storage/preferences_helper.dart';

/// Methods for getting and setting store values of ​​shared preferences.
class AppPreferences {
  /// Selected search radius in the filter
  static Future<int> get searchRadius =>
      PreferencesHelper.getInt(PreferencesKeys.searchRadius);

  /// Setter for [searchRadius]
  static Future setSearchRadius(int value) =>
      PreferencesHelper.setInt(PreferencesKeys.searchRadius, value);

  /// Selected place types in the filter
  static Future<List<String>> get searchTypes =>
      PreferencesHelper.getStringList(PreferencesKeys.searchTypes);

  /// Setter for [searchTypes]
  static Future setSearchTypes(List<String> value) =>
      PreferencesHelper.setStringList(PreferencesKeys.searchTypes, value);

  /// `true` if dark theme
  static Future<bool> get isDarkTheme =>
      PreferencesHelper.getBool(PreferencesKeys.isDarkTheme);

  /// Setter for [isDarkTheme]
  static Future setIsDarkTheme(bool value) =>
      PreferencesHelper.setBool(PreferencesKeys.isDarkTheme, value);

  /// `true` if the app hasn't started yet
  static Future<bool> get isFirstRun {
    return PreferencesHelper.preferencesInstance
        .then((prefs) => !prefs.containsKey(PreferencesKeys.isFirstRun));
  }

  /// Setter for [isFirstRun]
  static Future setIsFirstRun(bool value) =>
      PreferencesHelper.setBool(PreferencesKeys.isFirstRun, value);
}
