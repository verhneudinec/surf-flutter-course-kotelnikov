import 'package:flutter/material.dart';
import 'package:places/res/themes.dart';

// ignore: unused_import
import 'package:places/ui/screen/sight_list_screen.dart';
// ignore: unused_import
import 'package:places/ui/screen/sight_details.dart';
// ignore: unused_import
import 'package:places/ui/screen/visiting_screen.dart';
import 'package:places/ui/screen/filter_screen.dart';
// ignore: unused_import
import 'package:places/mocks.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  final bool isDarkMode;

  const App({Key key, this.isDarkMode = false}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: widget.isDarkMode ? darkTheme : lightTheme,
      home: FilterScreen(),
      // home: VisitingScreen(),
      // home: SightListScreen(),
      // home: SightDetails(sight: mocks[0]),
    );
  }
}
