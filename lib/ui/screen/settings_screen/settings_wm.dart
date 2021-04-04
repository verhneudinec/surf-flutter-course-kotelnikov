import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/screen/onboarding_screen/onboarding_screen.dart';
import 'package:relation/relation.dart';

/// Widget model of settings screen
class SettingsWidgetModel extends WidgetModel {
  final SettingsInteractor settingsInteractor;
  final NavigatorState navigator;

  SettingsWidgetModel(
    WidgetModelDependencies baseDependencies,
    this.settingsInteractor,
    this.navigator,
  ) : super(baseDependencies);

  /// Current theme. `true` if theme is dark.
  EntityStreamedState<bool> isDarkMode = EntityStreamedState();

  @override
  void onLoad() {
    // Load the value of the current theme
    isDarkMode.content(settingsInteractor.isDarkMode);
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();

    subscribe(onUpdateThemeAction.stream, (_) {
      settingsInteractor.changeTheme();
      isDarkMode.content(settingsInteractor.isDarkMode);
    });

    subscribe(
      onClickOnboardingButtonAction.stream,
      (_) => _onClickOnboardingButton(),
    );
  }

  /// When initiating a theme change
  Action<void> onUpdateThemeAction = Action();

  /// When clicking on the "Watch the tutorial" button
  Action<void> onClickOnboardingButtonAction = Action();

  /// View the app tutorial
  void _onClickOnboardingButton() {
    navigator.push(
      MaterialPageRoute(
        builder: (context) => OnboardingScreen(),
      ),
    );
  }
}
