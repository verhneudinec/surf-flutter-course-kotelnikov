import 'package:flutter/material.dart';

/// Interactor for application settings.
/// Provider is used to manage State.
class SettingsInteractor with ChangeNotifier {
  bool _isDarkMode = false;

  /// [isDarkMode] - getter of current theme.
  bool get isDarkMode => _isDarkMode;

  /// The [themeChanger] function changes the current theme.
  void changeTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
