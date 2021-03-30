import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/common/error/error_handler.dart';
import 'package:provider/provider.dart';
import 'package:places/res/app_routes.dart';
import 'package:places/res/themes.dart';
import 'package:places/ui/screen/map_screen/map_screen.dart';
import 'package:places/ui/screen/place_list_screen/places_list_screen.dart';
import 'package:places/ui/screen/favorites_screen/favorites_screen.dart';
import 'package:places/ui/screen/settings_screen/settings_screen.dart';
import 'package:places/ui/view_model/places_search_model.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/view_model/place_types_model.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/interactor/places_search_interactor.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        /// ViewModels for UI logic
        ChangeNotifierProvider(create: (_) => PlaceTypesModel()),
        ChangeNotifierProvider(create: (_) => PlacesSearchModel()),

        /// Interactors for the business logic of the application
        ChangeNotifierProvider(create: (_) => SettingsInteractor()),
        ChangeNotifierProvider(create: (_) => PlacesInteractor()),
        ChangeNotifierProvider(create: (_) => PlacesSearchInteractor()),

        Provider<WidgetModelDependencies>(
          create: (context) => WidgetModelDependencies(
            errorHandler: StandardErrorHandler(),
          ),
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
      home: PlaceListScreen(),
      routes: {
        AppRoutes.home: (BuildContext context) => PlaceListScreen(),
        AppRoutes.map: (BuildContext context) => MapScreen(),
        AppRoutes.favorites: (BuildContext context) => FavoritesScreen(),
        AppRoutes.settings: (BuildContext context) => SettingsScreen(),
      },
    );
  }
}
