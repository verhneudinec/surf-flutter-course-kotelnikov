import 'package:places/data/repository/storage/preferences_keys.dart';
import 'package:places/data/repository/storage/preferences_helper.dart';

/// Methods for getting and setting store values of ​​shared preferences.
class AppPreferences {
  /// Selected search radius in the filter
  Future<int> get searchRadius =>
      PreferencesHelper().getInt(PreferencesKeys.searchRadius);

  /// Setter for [searchRadius]
  Future<void> setSearchRadius(int value) =>
      PreferencesHelper().setInt(PreferencesKeys.searchRadius, value);

  /// Selected place types in the filter
  Future<List<String>> get searchTypes =>
      PreferencesHelper().getStringList(PreferencesKeys.searchTypes);

  /// Setter for [searchTypes]
  Future<void> setSearchTypes(List<String> value) =>
      PreferencesHelper().setStringList(PreferencesKeys.searchTypes, value);

  /// `true` if dark theme
  Future<bool> get isDarkTheme =>
      PreferencesHelper().getBool(PreferencesKeys.isDarkTheme);

  /// Setter for [isDarkTheme]
  Future<void> setIsDarkTheme(bool value) =>
      PreferencesHelper().setBool(PreferencesKeys.isDarkTheme, value);

  /// `true` if the app hasn't started yet
  Future<bool> get isFirstRun {
    return PreferencesHelper()
        .preferencesInstance
        .then((prefs) => !prefs.containsKey(PreferencesKeys.isFirstRun));
  }

  /// Setter for [isFirstRun]
  Future<void> setIsFirstRun(bool value) =>
      PreferencesHelper().setBool(PreferencesKeys.isFirstRun, value);

  /// User's geoposition. Contains a json string with latitude and longitude.
  Future<String> get userGeolocation =>
      PreferencesHelper().getString(PreferencesKeys.userGeolocation);

  /// Setter for [userGeolocation]
  Future<void> setUserGeolocation(String value) =>
      PreferencesHelper().setString(PreferencesKeys.userGeolocation, value);
}
