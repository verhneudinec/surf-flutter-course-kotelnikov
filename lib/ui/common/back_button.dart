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
    return InkWell(
      onTap: () => print("go back button"),
      child: Container(
        width: 32,
        height: 32,
        child: Material(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: backgroundColor ?? Colors.transparent,
          child: IconButton(
            onPressed: () => print("go back button"),
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
