import 'package:flutter/material.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/ui/common/back_button.dart';

/// The [AppBarCustom] widget implements a custom [AppBar] with
/// passed in [title] and outputs [AppBackButton]
/// or [_cancelButton] depending on the passed values
/// [backButtonEnabled] and [cancelButtonEnabled].
class AppBarCustom extends StatelessWidget {
  final String title;
  final bool backButtonEnabled;
  final bool cancelButtonEnabled;
  const AppBarCustom({
    Key key,
    this.title = "Places",
    this.backButtonEnabled = false,
    this.cancelButtonEnabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      toolbarHeight: 56,
      title: Text(
        title,
        style: AppTextStyles.appBarMiniTitle.copyWith(
          color: Theme.of(context).textTheme.headline3.color,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
      leading: backButtonEnabled
          ? AppBackButton()
          : cancelButtonEnabled
              ? _cancelButton(context)
              : null,
      leadingWidth: cancelButtonEnabled ? 80 : null,
    );
  }

  Widget _cancelButton(context) {
    return InkWell(
      onTap: () => print("Отмена"),
      child: Center(
        child: Text(
          AppTextStrings.appBarCustomCancelButton,
          style: AppTextStyles.appBarCustomCancelButton.copyWith(
            color: Theme.of(context).textTheme.bodyText2.color,
          ),
        ),
      ),
    );
  }
}
