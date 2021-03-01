///
/// Custom BackButton
///

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/icons.dart';

class AppBackButton extends StatelessWidget {
  final Color backgroundColor;
  const AppBackButton({Key key, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Remove the current screen from the navigator stack on click
    void _onClickBackButton() {
      Navigator.of(context).pop();
    }

    return InkWell(
      child: Container(
        width: 32,
        height: 32,
        child: Material(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: backgroundColor ?? Colors.transparent,
          child: IconButton(
            onPressed: () => _onClickBackButton(),
            icon: SvgPicture.asset(
              AppIcons.arrow,
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
