import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/card_types.dart';
import 'package:places/res/icons.dart';
import 'package:places/ui/screen/place_list_screen/place_list_wm.dart';
import 'package:places/ui/widgets/app_bars/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/app_bars/flexible_app_bar_delegate.dart';
import 'package:places/ui/widgets/loader/loader_builder.dart';
import 'package:places/ui/widgets/places_list.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:relation/relation.dart';

/// [PlaceListScreen] - a screen with a list of interesting places.
/// Displays in the header [SliverPersistentHeader] with [FlexibleAppBarDelegate],
/// in the footer [AppBottomNavigationBar] and list of places with [PlaceList].
class PlaceListScreen extends CoreMwwmWidget {
  const PlaceListScreen({
    @required WidgetModelBuilder widgetModelBuilder,
  }) : super(widgetModelBuilder: widgetModelBuilder ?? PlaceListWidgetModel);

  @override
  _PlaceListScreenState createState() => _PlaceListScreenState();
}

class _PlaceListScreenState extends WidgetState<PlaceListWidgetModel> {
  @override
  Widget build(BuildContext context) {
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
                maxHeight: MediaQuery.of(context).size.height - 94,
                maxWidth: double.infinity,
                child: CustomScrollView(
                  slivers: [
                    /// Flexible header
                    SliverPersistentHeader(
                      delegate: FlexibleAppBarDelegate(
                          isBigTitle: _isPortraitOrientation),
                      pinned: _isPortraitOrientation ? true : false,
                    ),

                    // Display the places loaded from the API
                    EntityStateBuilder<List<Place>>(
                      streamedState: wm.placesState,
                      loadingBuilder: _buildLoadingState,
                      child: (BuildContext context, List<Place> places) {
                        return PlaceList(
                          places: places,
                          cardsType: CardTypes.general,
                        );
                      },
                    ),
                  ],
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

  /// Widget for display loader
  Widget _buildLoadingState(BuildContext context, _) {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Center(
          child: CircularLoader(),
        ),
      ),
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
          onPressed: () => wm.onClickCreateButtonAction(),
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
