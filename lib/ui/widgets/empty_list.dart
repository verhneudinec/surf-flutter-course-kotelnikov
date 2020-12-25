///
/// Виджет [EmptyList] отображает заглушку,
/// когда в избранном пустой список.
///

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/colors.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/text_styles.dart';

class EmptyList extends StatelessWidget {
  final String cardType;
  const EmptyList({Key key, this.cardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            cardType == "toVisit"
                ? "assets/icons/Card.svg"
                : "assets/icons/Go.svg",
            width: 64,
            height: 64,
            color: AppColors.inactiveBlack,
          ),
          const SizedBox(height: 24),
          Text(
            AppTextStrings.emptyPageTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.emptyPageTitle,
          ),
          const SizedBox(height: 8),
          Text(
            cardType == "toVisit"
                ? AppTextStrings.emptyPageSubtitle
                : AppTextStrings.emptyPageSubtitleVisited,
            textAlign: TextAlign.center,
            style: AppTextStyles.emptyPageSubtitle,
          )
        ],
      ),
    );
  }
}
