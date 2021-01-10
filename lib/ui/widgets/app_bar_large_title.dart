import 'package:flutter/material.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/text_styles.dart';

class AppBarLargeTitle extends StatelessWidget implements PreferredSizeWidget {
  const AppBarLargeTitle({Key key}) : super(key: key);

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
            style: AppTextStyles.appBarTitle.copyWith(
              color: Theme.of(context).textTheme.headline1.color,
            ),
            textAlign: TextAlign.left,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(
        double.infinity,
        136,
      );
}
