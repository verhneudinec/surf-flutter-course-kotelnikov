import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/icons.dart';

/// Custom BackButton.
/// [backgroundColor] - color of the container in which the icon is located.
/// [isCancelRoundedButton] - if true, will be displayed the icon [AppIcons.close]
/// with a rounded container. By default a rectangular container with the [AppIcons.arrow]
/// icon is displayed.
class AppBackButton extends StatelessWidget {
  final Color backgroundColor;
  final bool isCancelRoundedButton;
  const AppBackButton({
    Key key,
    this.backgroundColor,
    this.isCancelRoundedButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Remove the current screen from the navigator stack on click
    void _onClickBackButton() {
      Navigator.of(context).pop();
    }

    return InkWell(
      child: Container(
        width: isCancelRoundedButton ? 40 : 32,
        height: isCancelRoundedButton ? 40 : 32,
        child: Material(
          borderRadius: BorderRadius.all(
            isCancelRoundedButton
                ? AppDecorations.appCancelButtonRadius
                : AppDecorations.appBackButtonRadius,
          ),
          color: backgroundColor ?? Colors.transparent,
          child: IconButton(
            onPressed: () => _onClickBackButton(),
            icon: SvgPicture.asset(
              isCancelRoundedButton ? AppIcons.close : AppIcons.arrow,
              color: Theme.of(context).iconTheme.color,
            ),
            iconSize: 24,
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
            splashRadius: 20,
            splashColor: Theme.of(context).splashColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
