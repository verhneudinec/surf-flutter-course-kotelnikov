import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/navigator_pages.dart';

/// Bottom navigation for the app
class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key key}) : super(key: key);

  /// Navigator for BottomNavigationBar
  void _onClickBottomNavigationBarItem(BuildContext context, int index) {
    // Примитивно, но работает. Пока не изучили тему - сойдет
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (index) {
            case 0:
              return NavigatorPages.homePage;
              break;
            case 1:
              // Еще нет экрана MapScreen
              break;
            case 2:
              return NavigatorPages.favorites;
              break;
            case 3:
              return NavigatorPages.settings;
              break;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.2,
      child: Column(
        children: [
          Container(
            height: 0.2,
            color: Theme.of(context).disabledColor,
          ),
          Container(
            height: 56,
            child: BottomNavigationBar(
              backgroundColor: Theme.of(context).bottomAppBarColor,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              iconSize: 24,
              onTap: (int index) =>
                  _onClickBottomNavigationBarItem(context, index),
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.list,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  label: AppTextStrings.bottomNavigationBarLabelList,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.map,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  label: AppTextStrings.bottomNavigationBarLabelMap,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.heartFull,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  label: AppTextStrings.bottomNavigationBarLabelFavorites,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppIcons.settings,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  label: AppTextStrings.bottomNavigationBarLabelSettings,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
