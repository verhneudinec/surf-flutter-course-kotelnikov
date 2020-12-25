///
/// [SightListScreen] - экран со списком интересных мест.
/// Отображает в хедере [AppBarLargeTitle], а в подвале [AppBottomNavigationBar]
/// и выводит список интересных мест с помощью [SightList]
///

import 'package:flutter/material.dart';
import 'package:places/ui/widgets/app_bar_large_title.dart';
import 'package:places/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/sight_list.dart';

class SightListScreen extends StatefulWidget {
  SightListScreen({Key key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarLargeTitle(),
      bottomNavigationBar: AppBottomNavigationBar(),
      body: SightList(),
    );
  }
}
