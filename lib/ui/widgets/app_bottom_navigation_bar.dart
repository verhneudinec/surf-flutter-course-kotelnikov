import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/localization.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key key}) : super(key: key);

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
              onTap:
                  null, // TODO Сделать навигацию в приложении после изучения темы
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/List.svg",
                    color: Theme.of(context).iconTheme.color,
                  ),
                  label: AppTextStrings.bottomNavigationBarLabelList,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Map.svg",
                    color: Theme.of(context).iconTheme.color,
                  ),
                  label: AppTextStrings.bottomNavigationBarLabelMap,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Heart_full.svg",
                    color: Theme.of(context).iconTheme.color,
                  ),
                  label: AppTextStrings.bottomNavigationBarLabelFavorites,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icons/Settings.svg",
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
