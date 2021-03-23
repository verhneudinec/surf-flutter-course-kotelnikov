import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/store/places_store/places_store.dart';
import 'package:places/res/card_types.dart';
import 'package:places/res/icons.dart';
import 'package:places/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/app_bars/flexible_app_bar_delegate.dart';
import 'package:places/ui/widgets/places_list.dart';
import 'package:places/ui/screen/add_place_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:provider/provider.dart';

/// [PlaceListScreen] - a screen with a list of interesting places.
/// Displays in the header [SliverPersistentHeader] with [FlexibleAppBarDelegate],
/// in the footer [AppBottomNavigationBar] and list of places with [PlaceList].
class PlaceListScreen extends StatefulWidget {
  @override
  _PlaceListScreenState createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  PlacesStore _placesStore;

  @override
  void initState() {
    super.initState();
  }

  void _initStore() async {
    _placesStore = context.watch<PlacesStore>();
    await context.read<PlacesStore>().loadPlaces();
  }

  /// To go to the [AddPlaceScreen] screen
  void _onClickCreateButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPlaceScreen(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initStore();
    final bool _isPortraitOrientation =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: _isPortraitOrientation
                  ? const EdgeInsets.all(0.0)
                  : const EdgeInsets.symmetric(horizontal: 16.0),
              child: LimitedBox(
                maxHeight: MediaQuery.of(context).size.height - 138,
                maxWidth: double.infinity,
                child: Observer(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      slivers: [
                        /// Flexible header
                        SliverPersistentHeader(
                          delegate: FlexibleAppBarDelegate(
                              isPortraitOrientation: _isPortraitOrientation),
                          pinned: _isPortraitOrientation ? true : false,
                        ),

                        _placesStore.places.value.isEmpty
                            ? // Display loader
                            SliverToBoxAdapter(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  width: double.infinity,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              )
                            : // Display the places loaded from the API
                            PlaceList(
                                places: _placesStore.places.value,
                                cardsType: CardTypes.general,
                              ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _isPortraitOrientation
          ? _createPlaceButton()
          : const SizedBox.shrink(),
      bottomNavigationBar: AppBottomNavigationBar(currentPageIndex: 0),
    );
  }

  /// [_createPlaceButton] - action button for adding a new location in PlaceListScreen
  Widget _createPlaceButton() {
    return ClipRRect(
      borderRadius: AppDecorations.createPlaceButton.borderRadius,
      child: Container(
        width: 177,
        height: 48,
        decoration: BoxDecoration(
          gradient: Theme.of(context).colorScheme.createPlaceButtonGradient,
        ),
        child: TextButton.icon(
          onPressed: () => _onClickCreateButton(),
          icon: SvgPicture.asset(
            AppIcons.plus,
            width: 24,
            height: 24,
          ),
          label: Text(
            AppTextStrings.createPlaceButton.toUpperCase(),
            style: AppTextStyles.createPlaceButton.copyWith(
              color:
                  Theme.of(context).floatingActionButtonTheme.foregroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
