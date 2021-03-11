import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:places/res/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/ui/screen/places_list_screen.dart';

import '../../mocks.dart';

/// The [OnboardingScreen] displays hints on how to use the app.
/// The screen is displayed when you first launch the app or through the settings screen.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  /// Controller for pages [PageView].
  PageController _onboardingPageController;

  /// Current controller index.
  int _currentOnboardingPageIndex;

  @override
  void initState() {
    super.initState();
    _onboardingPageController = new PageController();
    _currentOnboardingPageIndex = 0;
  }

  /// Called when the current page changes.
  /// The timer is implemented for the beauty of the [_pageIndicator] switching.
  void _updateCurrentOnboardingPageIndex(int currentIndex) {
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SightListScreen(
          sightsData: mocks,
        ),
      ),
    );
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
                SvgPicture.asset(
                  icon,
                  width: 104.0,
                  height: 104.0,
                  color: Theme.of(context).iconTheme.color,
                  fit: BoxFit.scaleDown,
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
          style: AppTextStyles.addSightScreenSightCreateButton,
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
