import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/res/images.dart';
import 'package:places/ui/widgets/loader/loader_wm.dart';

/// Loader widget. Displayed when loading data.
class CircularLoaderWidget extends CoreMwwmWidget {
  const CircularLoaderWidget({
    @required WidgetModelBuilder widgetModelBuilder,
  }) : super(
            widgetModelBuilder:
                widgetModelBuilder ?? CircularLoaderWidgetModel);

  @override
  _CircularLoaderState createState() => _CircularLoaderState();
}

class _CircularLoaderState extends WidgetState<CircularLoaderWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: wm.animationController,
      builder: (context, child) {
        return RotationTransition(
          turns: AlwaysStoppedAnimation(wm.rotateAnimation.value / 360),
          child: child,
        );
      },
      child: Image.asset(AppImages.circularLoader),
    );
  }
}
