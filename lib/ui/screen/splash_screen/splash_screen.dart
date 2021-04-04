import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/themes.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen.dart';
import 'package:provider/provider.dart';

/// [SplashScreen] is shown whenever you enter the application.
/// The application data is initialized and proceeds to the next screen.
/// If the entry is the first, then the transition will be to [OnboardingScreen],
/// if not - to the screen [PlaceListScreen].
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  /// Rotation animation controller
  AnimationController _animationController;

  /// Animation of rotation
  Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1600),
    );

    _animationController.repeat();

    // Rotate counterclockwise 360 ​​degrees
    _rotateAnimation = Tween<double>(begin: 0, end: -360).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    initPlaces();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Function for loading the state of these places.
// /During chunking, displays the animation of the logo rotation by [_animationController].
  Future<void> initPlaces() async {
    try {
      /// We are waiting for the initialization of the application
      /// or 4 seconds if initialization was earlier.
      await Future.wait(
        [
          context.read<PlacesInteractor>().loadPlaces(),
          Future.delayed(
            Duration(seconds: 4),
          ),
        ],
        eagerError: true,
      );

      // If there was no error, then go to the next screen.
      navigateToNext();
    } catch (error) {
      print('Error $error');
    }
  }

  /// Function to navigate to next screen,
  /// for now defaults to [OnboardingScreen]
  void navigateToNext() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (BuildContext context) => OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: Theme.of(context).colorScheme.splashScreenBackgroundGradient,
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return RotationTransition(
              turns: AlwaysStoppedAnimation(_rotateAnimation.value / 360),
              child: child,
            );
          },
          child: SvgPicture.asset(
            AppIcons.splashIcon,
            color: Theme.of(context).colorScheme.splashScreenIconColor,
            width: 160,
            height: 160,
          ),
        ),
      ),
    );
  }
}
