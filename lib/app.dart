import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/common/error/error_handler.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/repository/storage/app_preferences.dart';
import 'package:places/ui/screen/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:places/res/themes.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/interactor/places_search_interactor.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// Interactors for the business logic of the application
        ChangeNotifierProvider(create: (_) => SettingsInteractor()),
        ChangeNotifierProvider(create: (_) => PlacesInteractor()),
        ChangeNotifierProvider(create: (_) => PlacesSearchInteractor()),

        Provider<WidgetModelDependencies>(
          create: (context) => WidgetModelDependencies(
            errorHandler: StandardErrorHandler(),
          ),
        ),

        /// Moor database
        Provider<AppDB>(create: (_) => AppDB()),

        /// App shared preferences
        Provider<AppPreferences>(
          create: (context) => AppPreferences(),
        ),
      ],
      child: MaterialAppBuilder(),
    );
  }
}

class MaterialAppBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Find out the current theme from [SettingsInteractor]
    bool _isDarkMode = context.watch<SettingsInteractor>().isDarkMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? darkTheme : lightTheme,
      home: SplashScreen(),
    );
  }
}
