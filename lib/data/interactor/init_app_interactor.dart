import 'package:flutter/material.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/storage/app_preferences.dart';
import 'package:places/data/repository/storage/preferences_helper.dart';
import 'package:places/data/repository/storage/preferences_keys.dart';
import 'package:provider/provider.dart';

/// Interactor for initializing the application
class InitAppInteractor {
  /// [initApp] starts initialization of storage and application settings
  void initApp(BuildContext context) {
    _initSharedPreferences(context);
  }

  /// Initialize the shared preferences storage
  Future<void> _initSharedPreferences(BuildContext context) async {
    context.read<SettingsInteractor>().settingsInit();
  }
}
