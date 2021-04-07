import 'package:flutter/material.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:provider/provider.dart';

/// Interactor for initializing the application
class InitAppInteractor {
  /// [initApp] starts initialization of storage and application settings
  void initApp(BuildContext context) {
    _initSharedPreferences(context);
  }

  /// Initialize the shared preferences storage
  void _initSharedPreferences(BuildContext context) {
    context.read<SettingsInteractor>().settingsInit();
  }
}
