import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/icons.dart';
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
