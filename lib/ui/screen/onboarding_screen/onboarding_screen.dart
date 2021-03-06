import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:places/data/repository/storage/app_preferences.dart';
import 'package:places/res/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/ui/screen/place_list_screen/place_list_route.dart';
import 'package:provider/provider.dart';

/// The [OnboardingScreen] displays hints on how to use the app.
/// The screen is displayed when you first launch the app or through the settings screen.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  /// Controller for pages [PageView].
  PageController _onboardingPageController;

  /// Current controller index.
  int _currentOnboardingPageIndex;

  /// Animation controller
  AnimationController _animationController;

  /// Zoom animation
  Animation<double> _zoomAnimation;

  /// App shared preferences
  AppPreferences _appPreferences;

  @override
  void initState() {
    super.initState();

    _appPreferences = context.read<AppPreferences>();

    _onboardingPageController = new PageController();
    _currentOnboardingPageIndex = 0;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    // Animate the appearance from small size (15x15 dp) to large  (104x104 dp)
    _zoomAnimation = Tween<double>(begin: 15, end: 104).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    // Start animation for the first icon
    _animationController.forward();
  }

  /// Called when the current page changes.
  /// The timer is implemented for the beauty of the [_pageIndicator] switching.
  void _updateCurrentOnboardingPageIndex(int currentIndex) {
    // Reset the animation
    _animationController.reset();
    // And show it again when turning the page
    _animationController.forward();

    new Timer(
      const Duration(milliseconds: 300),
      () {
        setState(() {
          _currentOnboardingPageIndex = currentIndex;
        });
      },
    );
  }

  /// Function to go to the next screen
  void _goToTheNextScreen() {
    // So that [OnboardingScreen] is no longer shown
    _appPreferences.setIsFirstRun(false);

    Navigator.pushReplacement(
      context,
      PlaceListScreenRoute(),
    );
  }

  @override
  void dispose() {
    _onboardingPageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 56,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            if (_currentOnboardingPageIndex < 2) _skipButton(),
          ],
        ),
        body: Center(
          child: Stack(
            children: [
              PageView(
                controller: _onboardingPageController,
                physics: Platform.isAndroid
                    ? ClampingScrollPhysics()
                    : BouncingScrollPhysics(),
                children: [
                  _firstPage(),
                  _secondPage(),
                  _thirdPage(),
                ],
                onPageChanged: (int page) =>
                    _updateCurrentOnboardingPageIndex(page),
              ),

              /// Display  [_pageIndicator].
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 88),
                  child: _pageIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstPage() {
    return _pageBuilder(
      icon: AppIcons.pointer,
      title: AppTextStrings.onBoardingFirstPageTitle,
      subtitle: AppTextStrings.onBoardingFirstPageSubtitle,
    );
  }

  Widget _secondPage() {
    return _pageBuilder(
      icon: AppIcons.backpack,
      title: AppTextStrings.onBoardingSecondPageTitle,
      subtitle: AppTextStrings.onBoardingSecondPageSubtitle,
    );
  }

  Widget _thirdPage() {
    return _pageBuilder(
      icon: AppIcons.clickerFinger,
      title: AppTextStrings.onBoardingThirdPageTitle,
      subtitle: AppTextStrings.onBoardingThirdPageSubtitle,
    );
  }

  /// Builder for [OnboardingScreen] pages.
  /// [icon] - icon in *.svg format.
  /// [title] - the title of the tooltip.
  /// [subtitle] - hint subtitle.
  /// Outputs also in the footer [_pageIndicator]
  /// and [_startButton] on the last page.
  Widget _pageBuilder({
    @required String icon,
    @required String title,
    @required String subtitle,
  }) {
    return Column(
      children: [
        /// Display  [icon], [title] and [subtitle]
        Expanded(
          child: SizedBox(
            width: 245,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 104,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return SvgPicture.asset(
                        icon,
                        width: _zoomAnimation.value,
                        height: _zoomAnimation.value,
                        color: Theme.of(context).iconTheme.color,
                        fit: BoxFit.scaleDown,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  title,
                  style: AppTextStyles.onboardingScreenTitle.copyWith(
                    color: Theme.of(context).textTheme.headline1.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.onboardingScreenSubtitle.copyWith(
                    color: Theme.of(context).textTheme.subtitle1.color,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

        /// Display  [_startButton].
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _currentOnboardingPageIndex == 2
                ? _startButton()
                : const SizedBox(
                    height: 48,
                  ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ],
    );
  }

  /// Indicator for switching pages, displays different
  /// widgets depending on [_currentOnboardingPageIndex].
  Widget _pageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: i == _currentOnboardingPageIndex
                ? Container(
                    width: 24.0,
                    height: 8.0,
                    decoration: AppDecorations.onboardingPageIndicator.copyWith(
                      color: Theme.of(context).accentColor,
                    ),
                  )
                : Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: AppDecorations.onboardingPageIndicator.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
          ),
      ],
    );
  }

  /// "Go to start" button.
  Widget _startButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () => _goToTheNextScreen(),
        child: Text(
          AppTextStrings.onBoardingStartButton.toUpperCase(),
          style: AppTextStyles.addPlaceScreenPlaceCreateButton,
        ),
        style: Theme.of(context).elevatedButtonTheme.style.copyWith(
              backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).accentColor,
              ),
            ),
      ),
    );
  }

  /// "Skip" button for [AppBar]
  Widget _skipButton() {
    return InkWell(
      onTap: () => _goToTheNextScreen(),
      child: Container(
        alignment: AlignmentDirectional.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          AppTextStrings.onBoardingSkipButton,
          style: AppTextStyles.onboardingSkipButton.copyWith(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
