import 'package:flutter/material.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';

/// [TabIndicator] displays the indication of tabs for the "Favorites" page.
/// Accepts a [tabController] tab controller as parameters.
class TabIndicator extends StatelessWidget {
  final TabController tabController;
  const TabIndicator({Key key, this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: AppDecorations.tabIndicatorContainer.copyWith(
            color: Theme.of(context)
                .tabBarTheme
                .unselectedLabelStyle
                .backgroundColor),
        width: double.infinity,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < tabController.length; i++)
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    right: i % 2 == 0 ? 1 : 0,
                  ),
                  child: FlatButton(
                    onPressed: () {
                      tabController.index = i;
                    },
                    highlightColor: Theme.of(context)
                        .tabBarTheme
                        .labelStyle
                        .backgroundColor,
                    splashColor: Theme.of(context)
                        .tabBarTheme
                        .unselectedLabelStyle
                        .backgroundColor,
                    height: 40,
                    shape: AppDecorations.tabIndicatorContainerElement,
                    color: tabController.index == i
                        ? Theme.of(context)
                            .tabBarTheme
                            .labelStyle
                            .backgroundColor
                        : Theme.of(context)
                            .tabBarTheme
                            .unselectedLabelStyle
                            .background,
                    child: Center(
                      child: Text(
                        i == 0
                            ? AppTextStrings.visitedTab
                            : AppTextStrings.toVisitTab,
                        style: tabController.index == i
                            ? AppTextStyles.visitingScreenActiveTab.copyWith(
                                color: Theme.of(context)
                                    .tabBarTheme
                                    .labelStyle
                                    .color)
                            : AppTextStyles.visitingScreenInactiveTab.copyWith(
                                color: Theme.of(context)
                                    .tabBarTheme
                                    .unselectedLabelStyle
                                    .color),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
