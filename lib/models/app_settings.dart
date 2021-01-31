import 'package:flutter/material.dart';

/// Application settings.
/// Provider is used to manage State.
/// [isDarkMode] - getter of current theme.
/// The [themeChanger] function changes the current theme.
class AppSettings with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void changeTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
