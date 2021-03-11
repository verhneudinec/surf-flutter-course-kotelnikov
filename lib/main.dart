import 'package:flutter/material.dart';
import 'package:places/data/interactor/add_sight.dart';
import 'package:places/data/interactor/favorite_sights.dart';
import 'package:places/res/app_routes.dart';
import 'package:places/res/themes.dart';
import 'package:places/ui/screen/map_screen.dart';
import 'package:places/ui/screen/places_list_screen.dart';
import 'package:places/ui/screen/splash_screen.dart';
import 'package:places/ui/screen/favorites.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/mocks.dart';
import 'package:provider/provider.dart';
import 'package:places/data/interactor/app_settings.dart';
import 'package:places/data/interactor/sight_types.dart';
import 'package:places/data/interactor/sights.dart';
import 'package:places/data/interactor/sights_search.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppSettings()),
        ChangeNotifierProvider(create: (_) => AddSight()),
        ChangeNotifierProvider(create: (_) => SightTypes()),
        ChangeNotifierProvider(create: (_) => Sights()),
        ChangeNotifierProvider(create: (_) => SightsSearch()),
        ChangeNotifierProvider(create: (_) => FavoriteSights()),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _isDarkMode = context.watch<AppSettings>().isDarkMode;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? darkTheme : lightTheme,
      home: SplashScreen(),
      routes: {
        AppRoutes.home: (context) => SightListScreen(
              sightsData: mocks,
            ),
        AppRoutes.map: (BuildContext context) => MapScreen(),
        AppRoutes.favorites: (BuildContext context) => VisitingScreen(),
        AppRoutes.settings: (BuildContext context) => SettingsScreen(),
      },
      // home: OnboardingScreen(),
      // home: SightDetails(sight: mocks[2]),
      // home: AddSightScreen(),
      // home: SelectingSightTypeScreen(),
      // home: SettingsScreen(),
      // home: FilterScreen(),
      // home: VisitingScreen(),
      // home: SightListScreen(
      //   sightsData: mocks,
      // ),
      // home: SightSearchScreen(),
    );
  }
}
