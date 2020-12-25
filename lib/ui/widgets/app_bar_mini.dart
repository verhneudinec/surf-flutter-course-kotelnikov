///
/// Виджет [appBarMini] реализует кастомный [AppBar] для страниц с
/// заголовком размера [AppTextStyles._subtitle].
/// Также выводит переданный [tabBarIndicator] в подвале.
///

import 'package:flutter/material.dart';
import 'package:places/res/text_styles.dart';

Widget appBarMini({title, Widget tabBarIndicator}) {
  return AppBar(
    /// AppBar settings
    toolbarHeight: 108,
    backgroundColor: Colors.transparent,
    elevation: 0.0,

    /// Title text
    title: Column(
      children: [
        Container(
          height: 56,
          child: Center(
            child: Text(
              title,
              style: AppTextStyles.appBarMiniTitle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Container(
          height: 52,
          child: tabBarIndicator,
        ),
      ],
    ),
  );
}
