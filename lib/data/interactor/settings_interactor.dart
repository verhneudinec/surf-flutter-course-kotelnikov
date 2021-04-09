import 'package:flutter/material.dart';
import 'package:places/data/repository/storage/app_preferences.dart';

/// Interactor for application settings.
/// Provider is used to manage State.
class SettingsInteractor with ChangeNotifier {
  bool _isDarkMode = false;

  /// [isDarkMode] - getter of current theme.
  bool get isDarkMode => _isDarkMode;

  AppPreferences _appPreferences;

  ///         ///
  /// Setters ///
  ///         ///

  /// TODO Переделать в сеттер
  void setAppPreferences(AppPreferences appPrefs) => _appPreferences = appPrefs;

  ///           ///
  /// Functions ///
  ///           ///

  Future<void> settingsInit() async {
    _isDarkMode = await _appPreferences.isDarkTheme;
    notifyListeners();
  }

  /// The [themeChanger] function changes the current theme.
  void changeTheme() {
    _isDarkMode = !_isDarkMode;

    _appPreferences.setIsDarkTheme(_isDarkMode);

    notifyListeners();
  }
}
