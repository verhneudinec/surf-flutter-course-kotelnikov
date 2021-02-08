import 'package:flutter/material.dart';
import 'package:places/models/add_sight.dart';
import 'package:places/res/themes.dart';
// и все-таки не вижу смысла пока чистить main,
// пока не прошли навигацию. пока пусть вызовы
// останутся, я их постоянно использую.
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/screen/filter_screen.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/selecting_sight_type.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/mocks.dart';
import 'package:provider/provider.dart';
import 'package:places/models/app_settings.dart';
import 'package:places/models/sight_types.dart';
import 'package:places/models/sights.dart';
import 'package:places/models/sights_search.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppSettings()),
        ChangeNotifierProvider(create: (_) => AddSight()),
        ChangeNotifierProvider(create: (_) => SightTypes()),
        ChangeNotifierProvider(create: (_) => Sights()),
        ChangeNotifierProvider(create: (_) => SightsSearch()),
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
      // home: AddSightScreen(),
      // home: SelectingSightTypeScreen(),
      // home: SettingsScreen(),
      // home: FilterScreen(),
      // home: VisitingScreen(),
      home: SightListScreen(),
      // home: SightSearchScreen(),
      // home: SightDetails(sight: mocks[0]),
    );
  }
}
