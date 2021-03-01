import 'package:flutter/material.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/ui/common/back_button.dart';

/// The [AppBarCustom] widget implements a custom [AppBar] with
/// passed in [title] and outputs [AppBackButton]
/// or [_cancelButton] depending on the passed values
/// [backButtonEnabled] and [cancelButtonEnabled].
class AppBarCustom extends StatefulWidget {
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
  _AppBarCustomState createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {
  /// Remove the current screen from the navigator stack on click
  void _onClickCancelButton() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      toolbarHeight: 56,
      title: Text(
        widget.title,
        style: AppTextStyles.appBarMiniTitle.copyWith(
          color: Theme.of(context).textTheme.headline3.color,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: true,
      leading: widget.backButtonEnabled
          ? AppBackButton()
          : widget.cancelButtonEnabled
              ? _cancelButton(context)
              : null,
      leadingWidth: widget.cancelButtonEnabled ? 80 : null,
    );
  }

  Widget _cancelButton(context) {
    return InkWell(
      onTap: () => _onClickCancelButton(),
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
