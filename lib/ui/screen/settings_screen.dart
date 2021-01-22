/// Screen with application settings. Contains
/// switch theme using [_switchThemeHandler].

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/ui/widgets/app_bar_mini.dart';

final ChangeNotifier themeChangeNotifier = ChangeNotifier();
bool isDarkMode = false;

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  _switchThemeHandler(bool value) {
    setState(
      () {
        isDarkMode = value;
        themeChangeNotifier.notifyListeners();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          children: [
            AppBarMini(
              title: AppTextStrings.settingsScreenTitle,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App theme switcher
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      AppTextStrings.settingsScreenEnableDarkTheme,
                      style:
                          AppTextStyles.settingsScreenEnableDarkTheme.copyWith(
                        color: Theme.of(context).textTheme.headline5.color,
                      ),
                    ),
                    trailing: CupertinoSwitch(
                      value: isDarkMode,
                      onChanged: (value) => _switchThemeHandler(value),
                      activeColor: Theme.of(context).accentColor,
                      trackColor: Theme.of(context).disabledColor,
                    ),
                  ),

                  _divider(context),
                  // "Watch tutorial" button
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      AppTextStrings.settingsScreenWatchTutorial,
                      style: AppTextStyles.settingsScreenWatchTutorial.copyWith(
                        color: Theme.of(context).textTheme.headline5.color,
                      ),
                    ),
                    trailing: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: SvgPicture.asset(
                        "assets/icons/Info.svg",
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  _divider(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _divider(context) {
  return Divider(
    color: Theme.of(context).disabledColor,
    indent: 0,
    endIndent: 0,
    height: 1,
  );
}
