import 'package:flutter/material.dart';

class AppSettings with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void themeChanger() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
