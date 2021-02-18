import 'dart:io';
import 'package:flutter/material.dart';

/// Custom [ListView.builder] with predefined settings.
/// The builder returns the widgets that were passed to [children].
class CustomListViewBuilder extends StatelessWidget {
  final List<Widget> children;
  const CustomListViewBuilder({Key key, @required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      // TODO Переделать в Flexible
      maxWidth: MediaQuery.of(context).size.width,
      maxHeight: MediaQuery.of(context).size.height - 250,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
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
