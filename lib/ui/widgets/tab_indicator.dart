///
/// [TabIndicator] выводит индикацию табов для страницы "Избранное".

import 'package:flutter/material.dart';
import 'package:places/res/colors.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/text_styles.dart';

class TabIndicator extends StatelessWidget {
  final TabController tabController;
  const TabIndicator({Key key, this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: AppDecorations.tabIndicatorContainer,
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
                    highlightColor: AppColors.inactiveBlack,
                    splashColor: AppColors.inactiveBlack,
                    height: 40,
                    shape: AppDecorations.tabIndicatorContainerElement,
                    color: tabController.index == i
                        ? AppColors.secondary
                        : AppColors.background,
                    child: Center(
                      child: Text(
                        i == 0
                            ? AppTextStrings.visitedTab
                            : AppTextStrings.toVisitTab,
                        style: tabController.index == i
                            ? AppTextStyles.visitingScreenActiveTab
                            : AppTextStyles.visitingScreenInactiveTab,
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
