import 'package:flutter/material.dart';
import 'package:places/res/icons.dart';
import 'package:places/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/app_bars/flexible_app_bar_delegate.dart';
import 'package:places/ui/widgets/sight_list.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:places/models/sights_search.dart';
import 'package:provider/provider.dart';
import 'dart:async';

/// [SightListScreen] - a screen with a list of interesting places.
/// Displays in the header [SliverPersistentHeader] with [FlexibleAppBarDelegate],
/// in the footer [AppBottomNavigationBar] and list of sights with [SightList].
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
        seconds: 2,
      ),
      () {
        setState(() {
          _isSightListLoading = false;
        });
      },
    );

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// Flexible header
            SliverPersistentHeader(
              delegate: FlexibleAppBarDelegate(),
              pinned: true,
            ),

            /// While the sights are not loaded - display [CircularProgressIndicator]
            if (_isSightListLoading)
              SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),

            /// Display search results if they exist
            /// or display the data obtained in the constructor [sightsData]
            SightList(
              sights: _searchFieldIsNotEmpty == true
                  ? _searchResults
                  : widget.sightsData,
            ),

            SliverList(
              delegate: SliverChildListDelegate([
                Container(height: 900, color: Colors.black),
              ]),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _createSightButton(),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }

  /// [_createSightButton] - action button for adding a new location in SightListScreen
  Widget _createSightButton() {
    return ClipRRect(
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
            AppIcons.plus,
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
    );
  }
}
