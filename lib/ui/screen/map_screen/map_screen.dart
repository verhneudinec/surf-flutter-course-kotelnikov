import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/card_types.dart';
import 'package:places/res/icons.dart';
import 'package:places/ui/screen/map_screen/map_wm.dart';
import 'package:places/ui/widgets/app_bars/app_bottom_navigation_bar.dart';
import 'package:places/ui/widgets/app_bars/flexible_app_bar_delegate.dart';
import 'package:places/ui/widgets/place_card/place_card_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:relation/relation.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Map of places. It is initialized by all places in the default search radius
/// or places by the applied filterы.
class MapScreen extends CoreMwwmWidget {
  const MapScreen({
    @required WidgetModelBuilder widgetModelBuilder,
  }) : super(widgetModelBuilder: widgetModelBuilder ?? MapScreenWidgetModel);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends WidgetState<MapScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    final bool _isPortraitOrientation =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: _isPortraitOrientation
                  ? const EdgeInsets.all(0.0)
                  : const EdgeInsets.symmetric(horizontal: 16.0),
              child: LimitedBox(
                maxHeight: MediaQuery.of(context).size.height - 95,
                maxWidth: double.infinity,
                child: CustomScrollView(
                  slivers: [
                    /// Header with title and search bar
                    SliverPersistentHeader(
                      delegate: FlexibleAppBarDelegate(
                        title: AppTextStrings.mapAppBarTitle,
                        isBigTitle: false,
                        isCenterTitle: true,
                      ),
                      pinned: false,
                    ),

                    /// Map
                    SliverToBoxAdapter(
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        child: YandexMap(
                          onMapCreated: (YandexMapController controller) =>
                              wm.initMapAction(controller),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildBottomControlsButtons(),
      bottomNavigationBar: AppBottomNavigationBar(currentPageIndex: 1),
    );
  }

  /// Bottom control buttons
  Widget _buildBottomControlsButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StreamedStateBuilder<Place>(
        streamedState: wm.placeState,
        builder: (context, placeStateValue) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// "Show me" button
                  Container(
                    width: 48,
                    height: 48,
                    decoration:
                        AppDecorations.mapCicrleButtonDecoration.copyWith(
                      color: Theme.of(context)
                          .floatingActionButtonTheme
                          .foregroundColor,
                    ),
                    child: IconButton(
                      onPressed: () => wm.showMeAction(),
                      icon: Center(
                        child: SvgPicture.asset(
                          AppIcons.geolocation,
                        ),
                      ),
                      tooltip: AppTextStrings.mapScreenShowMeButton,
                    ),
                  ),

                  /// "Create place" button
                  if (placeStateValue == null)
                    Container(
                      width: 177,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: Theme.of(context)
                            .colorScheme
                            .createPlaceButtonGradient,
                        boxShadow: AppDecorations.defaultBoxShadow,
                        borderRadius:
                            AppDecorations.mapButtonsRadius.borderRadius,
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
                            color: Theme.of(context)
                                .floatingActionButtonTheme
                                .foregroundColor,
                          ),
                        ),
                      ),
                    ),

                  /// "Refresh" button
                  Container(
                    width: 48,
                    height: 48,
                    decoration:
                        AppDecorations.mapCicrleButtonDecoration.copyWith(
                      color: Theme.of(context)
                          .floatingActionButtonTheme
                          .foregroundColor,
                    ),
                    child: IconButton(
                      onPressed: () => wm.loadMapAction(),
                      icon: Center(
                        child: SvgPicture.asset(
                          AppIcons.refresh,
                        ),
                      ),
                      tooltip: AppTextStrings.mapScreenRefreshButton,
                    ),
                  ),
                ],
              ),

              /// Place card
              if (placeStateValue != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          AppDecorations.placeCardContainer.borderRadius,
                      boxShadow: AppDecorations.defaultBoxShadow,
                    ),
                    child: PlaceCardWidgetBuilder(
                      key: ValueKey(placeStateValue.id),
                      place: placeStateValue,
                      cardType: CardTypes.mapCard,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
