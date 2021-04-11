import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/res/durations.dart';

/// Widget model of [CircularLoaderWidget].
class CircularLoaderWidgetModel extends WidgetModel
    with SingleTickerProviderWidgetModelMixin {
  /// Rotation animation controller
  AnimationController animationController;

  /// Animation of rotation
  Animation<double> rotateAnimation;

  CircularLoaderWidgetModel(
    WidgetModelDependencies baseDependencies,
  ) : super(baseDependencies);

  @override
  void onLoad() {
    _startRotateAnimation();
    super.onLoad();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  /// Initializes the animation controller and starts the rotation
  _startRotateAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: AppDurations.loaderDuration,
    );

    animationController.repeat();

    // Rotate counterclockwise 360 ​​degrees
    rotateAnimation = Tween<double>(begin: 0, end: -360).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
    );
  }
}
