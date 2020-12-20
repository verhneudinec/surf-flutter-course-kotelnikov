// Экран со списком интересных мест

import 'package:flutter/material.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/mocks.dart';

class SightListScreen extends StatefulWidget {
  SightListScreen({Key key}) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBar settings
        toolbarHeight: 136, // heigh 72px + top margin 64px
        backgroundColor: Colors.transparent,
        elevation: 0.0, // remove shadow

        // Title text
        title: Text(
          appBarTitle,
          style: AppTextStyles.appBarTitle,
          textAlign: TextAlign.left,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SightCard(sight: mocks[0]),
            SightCard(sight: mocks[1]),
            SightCard(sight: mocks[2]),
          ],
        ),
      ),
    );
  }
}
