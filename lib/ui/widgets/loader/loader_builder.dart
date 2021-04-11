import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/ui/widgets/loader/loader_widget.dart';
import 'package:places/ui/widgets/loader/loader_wm.dart';
import 'package:provider/provider.dart';

/// Builder for [CircularLoaderWidget]
class CircularLoader extends StatelessWidget {
  const CircularLoader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularLoaderWidget(
      widgetModelBuilder: (context) => CircularLoaderWidgetModel(
        context.read<WidgetModelDependencies>(),
      ),
    );
  }
}
