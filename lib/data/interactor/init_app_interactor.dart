import 'package:flutter/material.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/interactor/places_search_interactor.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
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
    context.read<PlacesInteractor>().initFavoritesTable(context);
  }
}
