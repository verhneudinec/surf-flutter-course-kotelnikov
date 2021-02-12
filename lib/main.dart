import 'package:flutter/material.dart';
import 'package:places/res/themes.dart';
// и все-таки не вижу смысла пока чистить main,
// пока не прошли навигацию. пока пусть вызовы
// останутся, я их постоянно использую.
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/screen/filter_screen.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/mocks.dart';
import 'package:provider/provider.dart';
import 'package:places/models/app_settings.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppSettings()),
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
      home: SettingsScreen(),
      // home: FilterScreen(),
      // home: VisitingScreen(),
      // home: SightListScreen(),
      // home: SightDetails(sight: mocks[0]),
    );
  }
}
