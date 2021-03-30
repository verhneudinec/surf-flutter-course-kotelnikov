import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/app_routes.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/ui/screen/place_list_screen/place_list_route.dart';

/// Bottom navigation for the app
/// [currentPageIndex] - the current page index for the navigator.
class AppBottomNavigationBar extends StatelessWidget {
  final int currentPageIndex;
  const AppBottomNavigationBar({
    Key key,
    this.currentPageIndex,
  }) : super(key: key);

  /// Navigator for BottomNavigationBar.
  /// If need to navigate through the current index - do nothing.
  void _onClickBottomNavigationBarItem(BuildContext context, int index) {
    if (currentPageIndex != index)
      switch (index) {
        case 0:
          Navigator.push(context, PlaceListScreenRoute());
          break;
        case 1:
          Navigator.pushNamed(context, AppRoutes.map);
          break;
        case 2:
          Navigator.pushNamed(context, AppRoutes.favorites);
          break;
        case 3:
          Navigator.pushNamed(context, AppRoutes.settings);
          break;
      }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
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
                elevation: 0.0,
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
      ),
    );
  }
}
