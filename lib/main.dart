import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/common/error/error_handler.dart';
import 'package:places/data/database/database.dart';
import 'package:places/data/interactor/init_app_interactor.dart';
import 'package:places/ui/screen/favorites_screen/favorites_route.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen.dart';
import 'package:places/data/repository/storage/app_preferences.dart';
import 'package:places/ui/screen/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:places/res/themes.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/interactor/places_search_interactor.dart';

void main() {
  runApp(
    MultiProvider(
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
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    /// Find out the current theme from [SettingsInteractor]
    bool _isDarkMode = context.watch<SettingsInteractor>().isDarkMode;

    /// Run the application
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? darkTheme : lightTheme,
      home: SplashScreen(),
    );
  }
}
