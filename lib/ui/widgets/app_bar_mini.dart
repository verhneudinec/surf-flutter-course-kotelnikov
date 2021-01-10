///
/// Виджет [appBarMini] реализует кастомный [AppBar] для страниц с
/// заголовком размера [AppTextStyles._subtitle].
/// Также выводит переданный [tabBarIndicator] в подвале.
///

import 'package:flutter/material.dart';
import 'package:places/res/text_styles.dart';

class AppBarMini extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget tabBarIndicator;
  const AppBarMini({Key key, this.title, this.tabBarIndicator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 56,
              child: Center(
                child: Text(
                  title,
                  style: AppTextStyles.appBarMiniTitle.copyWith(
                    color: Theme.of(context).textTheme.headline3.color,
                  ),
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
      ),
    );
  }

  @override
  Size get preferredSize => Size(
        double.infinity,
        108,
      );
}

class AppBarMini2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget tabBarIndicator;
  const AppBarMini2({Key key, this.title, this.tabBarIndicator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      /// AppBar settings
      backgroundColor: Colors.transparent,
      elevation: 0.0,

      /// Text of appbar
      title: Column(
        children: [
          Container(
            height: 56,
            child: Center(
              child: Text(
                title,
                style: AppTextStyles.appBarMiniTitle.copyWith(
                  color: Theme.of(context).textTheme.headline3.color,
                ),
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

  @override
  Size get preferredSize => Size(
        double.infinity,
        108,
      );
}
