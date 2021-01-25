import 'package:flutter/material.dart';
import 'package:places/res/themes.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/screen/filter_screen.dart';
import 'package:places/ui/screen/settings_screen.dart';
import 'package:places/mocks.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool isDarkMode = false;

  @override
  void initState() {
    themeChangeNotifier.addListener(() {
      setState(() {
        isDarkMode = !isDarkMode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? darkTheme : lightTheme,
      // home: SettingsScreen(),
      home: FilterScreen(),
      // home: VisitingScreen(),
      // home: SightListScreen(),
      // home: SightDetails(sight: mocks[0]),
    );
  }
}
