import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/ui/screen/settings_screen/settings_screen.dart';
import 'package:places/ui/screen/settings_screen/settings_wm.dart';
import 'package:provider/provider.dart';

/// Settings screen route
class SettingsRoute extends MaterialPageRoute {
  SettingsRoute()
      : super(
          builder: (context) => SettingsScreen(
            widgetModelBuilder: _widgetModelBuilder,
          ),
        );
}

WidgetModel _widgetModelBuilder(BuildContext context) => SettingsWidgetModel(
      context.read<WidgetModelDependencies>(),
      context.read<SettingsInteractor>(),
      Navigator.of(context),
    );
