import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:places/ui/screen/sight_list_screen.dart';
// ignore: unused_import
import 'package:places/ui/screen/sight_details.dart';
// ignore: unused_import
import 'package:places/mocks.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SightListScreen(),
      home: SightDetails(sight: mocks[0]),
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: "Roboto"),
    );
  }
}
