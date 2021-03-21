import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/card_types.dart';
import 'package:places/res/icons.dart';
import 'package:places/ui/view_model/places_search_model.dart';
import 'package:places/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/app_bars/flexible_app_bar_delegate.dart';
import 'package:places/ui/widgets/error_stub.dart';
import 'package:places/ui/widgets/places_list.dart';
import 'package:places/ui/screen/add_place_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:places/data/interactor/places_search_interactor.dart';
import 'package:provider/provider.dart';

/// [PlaceListScreen] - a screen with a list of interesting places.
/// Displays in the header [SliverPersistentHeader] with [FlexibleAppBarDelegate],
/// in the footer [AppBottomNavigationBar] and list of places with [PlaceList].
class PlaceListScreen extends StatefulWidget {
  @override
  _PlaceListScreenState createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends State<PlaceListScreen> {
  @override
  void initState() {
    super.initState();
    _initPlaces();
  }

  Stream<List<Place>> _placeListController;

  void _initPlaces() async {
    await context.read<PlacesInteractor>().loadPlaces();
    setState(() {
      // QUESTION // TODO
      _placeListController =
          context.read<PlacesInteractor>().placeListController;
    });
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
    final bool _isPortraitOrientation =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: _isPortraitOrientation
              ? const EdgeInsets.all(0.0)
              : const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomScrollView(
            slivers: [
              /// Flexible header
              SliverPersistentHeader(
                delegate: FlexibleAppBarDelegate(
                    isPortraitOrientation: _isPortraitOrientation),
                pinned: _isPortraitOrientation ? true : false,
              ),

              /// Load places from the server using the [PlacesInteractor] interactor.
              /// At boot time display the loader.
              /// If there is an error - display an error message.
              StreamBuilder<List<Place>>(
                stream: _placeListController,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<Place>> snapshot,
                ) {
                  if (!snapshot.hasData && !snapshot.hasError)
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height /
                                4, // TODO Исправить размеры
                          ),
                          CircularProgressIndicator(),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    );

                  if (snapshot.hasError)
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: ErrorStub(
                          icon: AppIcons.error,
                          title: AppTextStrings.dataLoadingErrorTitle,
                          subtitle: AppTextStrings.dataLoadingErrorSubtitle,
                        ),
                      ),
                    );

                  return PlaceList(
                    places: snapshot.data,
                    cardsType: CardTypes.general,
                  );
                },
              ),
            ],
          ),
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
