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
      appBar: CustomAppBar(),
      // appBar: AppBar(
      //   // AppBar settings
      //   toolbarHeight: 136, // heigh 72px + top margin 64px
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0, // remove shadow

      //   // Title text
      //   title: Text(
      //     appBarTitle,
      //     style: AppTextStyles.appBarTitle,
      //     textAlign: TextAlign.left,
      //     maxLines: 2,
      //     overflow: TextOverflow.ellipsis,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: mocks.map((item) => SightCard(sight: item)).toList(),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 40,
            left: 16,
            bottom: 16,
          ),
          child: Text(
            AppTextStrings.appBarTitle,
            style: AppTextStyles.appBarTitle,
            textAlign: TextAlign.left,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 136);
}
