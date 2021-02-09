import 'package:flutter/material.dart';
import 'package:places/ui/widgets/app_bar_large_title.dart';
import 'package:places/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/sight_list.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/app_bar_mini.dart';
import 'package:places/ui/widgets/error_stub.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:places/mocks.dart';
import 'package:places/models/sights_search.dart';
import 'package:provider/provider.dart';
import 'dart:async';

/// [SightListScreen] - a screen with a list of interesting places.
/// Displays in the header [AppBarLargeTitle], in the footer [AppBottomNavigationBar]
/// and list of sights with [SightList].
class SightListScreen extends StatefulWidget {
  final List sightsData;
  SightListScreen({
    Key key,
    this.sightsData,
  }) : super(key: key);

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  bool _isSightListLoading = true;

  void _onClickCreateButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSightScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool _searchFieldIsNotEmpty =
        context.watch<SightsSearch>().searchFieldIsNotEmpty;
    List _searchResults = context.watch<SightsSearch>().searchResults;

    // TODO Временное решение для лоадера списка, пока не прошли
    // работу с сетью и не подключились к api
    Timer(
      Duration(
        seconds: 10,
      ),
      () {
        setState(() {
          _isSightListLoading = false;
        });
      },
    );

    return Scaffold(
      bottomNavigationBar: AppBottomNavigationBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarMini(
              title: AppTextStrings.appBarMiniTitle,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 16,
              ),
              child: SearchBar(),
            ),
            if (_isSightListLoading)
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            SightList(
              sights: _searchFieldIsNotEmpty == true
                  ? _searchResults
                  : widget.sightsData,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ClipRRect(
        borderRadius: AppDecorations.createPlaceButton.borderRadius,
        child: Container(
          width: 177,
          height: 48,
          decoration: BoxDecoration(
            gradient: Theme.of(context).colorScheme.createSightButtonGradient,
          ),
          child: TextButton.icon(
            onPressed: () => _onClickCreateButton(),
            icon: SvgPicture.asset(
              "assets/icons/Plus.svg",
              width: 24,
              height: 24,
            ),
            label: Text(
              AppTextStrings.createSightButton.toUpperCase(),
              style: AppTextStyles.createSightButton.copyWith(
                color:
                    Theme.of(context).floatingActionButtonTheme.foregroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
