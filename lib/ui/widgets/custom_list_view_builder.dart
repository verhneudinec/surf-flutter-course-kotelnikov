import 'dart:io';
import 'package:flutter/material.dart';

/// Custom [ListView.builder] with predefined settings.
/// The builder returns the widgets that were passed to [children].
/// [scrollDirection] - Axis.vertical by default.
/// [additionalPadding] - additional padding at the bottom.
class CustomListViewBuilder extends StatelessWidget {
  final List<Widget> children;
  final Axis scrollDirection;
  final bool additionalPadding;
  const CustomListViewBuilder({
    Key key,
    @required this.children,
    this.scrollDirection = Axis.vertical,
    this.additionalPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      // TODO Переделать в Flexible
      maxWidth: MediaQuery.of(context).size.width,
      maxHeight: scrollDirection == Axis.vertical
          ? MediaQuery.of(context).size.height - 250
          : 72,
      child: ListView.builder(
        scrollDirection: scrollDirection ?? Axis.vertical,
        padding:
            additionalPadding ? EdgeInsets.only(bottom: 48) : EdgeInsets.all(0),
        physics: Platform.isAndroid
            ? ClampingScrollPhysics()
            : BouncingScrollPhysics(),
        itemCount: children.length,
        itemBuilder: (context, index) {
          return children[index];
        },
      ),
    );
  }
}
