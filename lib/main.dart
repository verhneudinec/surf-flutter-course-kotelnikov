import 'package:flutter/material.dart';
import 'ui/screen/sight_list_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SightListScreen(),
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: "Roboto"),
    );
  }
}
