import 'package:flutter/material.dart';
import 'package:places/data/interactor/add_place.dart';
import 'package:places/data/interactor/favorite_places.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/app_routes.dart';
import 'package:places/res/themes.dart';
import 'package:places/ui/screen/map_screen.dart';
import 'package:places/ui/screen/places_list_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/screen/favorites.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:places/data/interactor/app_settings.dart';
import 'package:places/data/interactor/place_types.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/interactor/places_search.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppSettings()),
        ChangeNotifierProvider(create: (_) => AddPlace()),
        ChangeNotifierProvider(create: (_) => PlaceTypes()),
        ChangeNotifierProvider(create: (_) => PlacesInteractor()),
        ChangeNotifierProvider(create: (_) => PlacesSearch()),
      ],
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = context.watch<AppSettings>().isDarkMode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? darkTheme : lightTheme,
      home: PlaceListScreen(),
      routes: {
        AppRoutes.home: (BuildContext context) => PlaceListScreen(),
        AppRoutes.map: (BuildContext context) => MapScreen(),
        AppRoutes.favorites: (BuildContext context) => VisitingScreen(),
        AppRoutes.settings: (BuildContext context) => SettingsScreen(),
      },
      // home: OnboardingScreen(),
      // home: PlaceDetails(place: mocks[2]),
      // home: AddPlaceScreen(),
      // home: SelectingPlaceTypeScreen(),
      // home: SettingsScreen(),
      // home: FilterScreen(),
      // home: VisitingScreen(),
      // home: PlaceListScreen(
      //   placesData: mocks,
      // ),
      // home: PlaceSearchScreen(),
    );
  }
}
