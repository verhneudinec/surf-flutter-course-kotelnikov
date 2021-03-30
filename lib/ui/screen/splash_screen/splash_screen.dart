import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/themes.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen.dart';

/// [SplashScreen] is shown whenever you enter the application.
/// The application data is initialized and proceeds to the next screen.
/// If the entry is the first, then the transition will be to [OnboardingScreen],
/// if not - to the screen [PlaceListScreen].
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ///[_isInitialized]  monitors the completion of application initialization.
  Future<bool> _isInitialized;

  @override
  void initState() {
    super.initState();

    // Simulate initialization. Let's assume that the data was loaded in 1 second.
    _isInitialized = Future<bool>.delayed(
      Duration(seconds: 1),
      () => true,
    );

    _navigateToNext();
  }

  /// Function to navigate to next screen,
  /// for now defaults to [OnboardingScreen]
  Future<void> _navigateToNext() async {
    try {
      await Future.wait(
        [
          _isInitialized,
          Future.delayed(
            Duration(seconds: 2),
          ),
        ],
        eagerError: true,
      );

      // If there was no error, then go to the next screen.
      // Error handling is not yet provided.
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (BuildContext context) => OnboardingScreen(),
        ),
      );
    } catch (error) {
      print('Error $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: Theme.of(context).colorScheme.splashScreenBackgroundGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          AppIcons.splashIcon,
          color: Theme.of(context).colorScheme.splashScreenIconColor,
          width: 160,
          height: 160,
        ),
      ),
    );
  }
}
