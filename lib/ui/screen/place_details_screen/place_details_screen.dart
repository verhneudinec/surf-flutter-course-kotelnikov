import 'dart:io';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/res/place_types.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/common/back_button.dart';
import 'package:places/ui/screen/place_details_screen/place_details_wm.dart';
import 'package:places/ui/widgets/error_stub.dart';
import 'package:places/ui/widgets/image_network.dart';
import 'package:relation/relation.dart';

/// Screen with detailed information about the place
/// [PlaceDetails] contains a header [PlaceDetailsHeader]
/// and body [PlaceDetailsBody] with basic information about the place
class PlaceDetailsScreen extends CoreMwwmWidget {
  const PlaceDetailsScreen({
    @required WidgetModelBuilder widgetModelBuilder,
  }) : super(widgetModelBuilder: widgetModelBuilder ?? PlaceDetailsWidgetModel);

  @override
  _PlaceDetailsScreenState createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends WidgetState<PlaceDetailsWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      minChildSize: 0.5,
      builder: (BuildContext context, ScrollController scrollController) {
        return ClipRRect(
          borderRadius: AppDecorations.bottomSheetBorderRadius,
          child: Scaffold(
            body: EntityStateBuilder<Place>(
              streamedState: wm.placeState,
              loadingChild: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  Center(child: CircularProgressIndicator()),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
              errorChild: Center(
                child: SizedBox(
                  width: 300,
                  height: MediaQuery.of(context).size.height / 2,
                  child: ErrorStub(
                    icon: AppIcons.error,
                    title: AppTextStrings.dataLoadingErrorTitle,
                    subtitle: AppTextStrings.dataLoadingErrorSubtitle,
                  ),
                ),
              ),
              child: (context, placeState) {
                return CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      automaticallyImplyLeading: false,
                      expandedHeight: 360,
                      flexibleSpace: FlexibleSpaceBar(
                        background: PlaceDetailsHeader(
                          place: placeState,
                          photogalleryController: wm.photogalleryController,
                          photogalleryPageIndex: wm.photogalleryPageIndex,
                          onPhotogalleryPageChanged:
                              wm.onPhotogalleryPageUpdateAction,
                          isBottomSheet: wm.isBottomSheet,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: PlaceDetailsBody(
                            place: placeState,
                            isPlaceInFavorites: wm.isPlaceInFavorites,
                            onAddingToFavorites: wm.onAddingToFavoritesAction,
                            onRemoveFromFavorites:
                                wm.onRemoveFromFavoritesAction,
                          ),
                        ),
                      ]),
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class PlaceDetailsHeader extends StatefulWidget {
  final Place place;
  final bool isBottomSheet;
  final PageController photogalleryController;
  final EntityStreamedState<int> photogalleryPageIndex;
  final onPhotogalleryPageChanged;

  const PlaceDetailsHeader({
    Key key,
    @required this.place,
    @required this.photogalleryController,
    @required this.photogalleryPageIndex,
    @required this.onPhotogalleryPageChanged,
    this.isBottomSheet,
  }) : super(key: key);

  @override
  _PlaceDetailsHeaderState createState() => _PlaceDetailsHeaderState();
}

class _PlaceDetailsHeaderState extends State<PlaceDetailsHeader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _photogallery(),

        // Container for creating the gradient effect
        Container(
          decoration: AppDecorations.placeCardImageGradient,
          width: double.infinity,
          height: 96,
        ),

        // BottomSheet close slider
        if (widget.isBottomSheet)
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: ClipRRect(
                borderRadius: AppDecorations.bottomSheetTopRectangleRadius,
                child: Container(
                  height: 4,
                  width: 40,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ),
          ),

        // "Go back" button
        SafeArea(
          child: Align(
            alignment:
                widget.isBottomSheet ? Alignment.topRight : Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: widget.isBottomSheet ? 16 : 12,
              ),
              child: AppBackButton(
                backgroundColor: Theme.of(context).backgroundColor,
                isCancelRoundedButton: widget.isBottomSheet,
              ),
            ),
          ),
        ),

        _photogalleryIndicator(),
      ],
    );
  }

  /// Photogallery of the place.
  /// Displays photos from [widget.place.urls]
  Widget _photogallery() {
    return LimitedBox(
      maxWidth: MediaQuery.of(context).size.width,
      maxHeight: 360,
      child: PageView.builder(
        controller: widget.photogalleryController,
        itemCount: widget.place.urls.length,
        physics: Platform.isAndroid
            ? ClampingScrollPhysics()
            : BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: double.infinity,
            height: 360,
            decoration: AppDecorations.placeCardImageGradient,
            child: ImageNetwork(
              widget.place.urls.elementAt(index),
            ),
          );
        },
        onPageChanged: (value) => widget.onPhotogalleryPageChanged(value),
      ),
    );
  }

  /// Gallery indicator.
  /// Displays the indicator if the indicator index matches [_currentPhotogalleryIndex].
  /// Otherwise outputs an empty block.
  Widget _photogalleryIndicator() {
    return Positioned(
      left: 0,
      bottom: 0,
      child: EntityStateBuilder<int>(
        streamedState: widget.photogalleryPageIndex,
        child: (context, page) {
          return Row(
            children: [
              if (widget.place.urls.length > 1)
                for (int i = 0; i < widget.place.urls.length; i++)
                  i == page
                      ? Container(
                          width: MediaQuery.of(context).size.width /
                              widget.place.urls.length,
                          height: 7.5,
                          decoration: AppDecorations.galleryIndicator.copyWith(
                            color: Theme.of(context).iconTheme.color,
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width /
                              widget.place.urls.length,
                        ),
            ],
          );
        },
      ),
    );
  }
}

class PlaceDetailsBody extends StatefulWidget {
  final Place place;
  final EntityStreamedState<bool> isPlaceInFavorites;
  final Action<void> onRemoveFromFavorites;
  final Action<void> onAddingToFavorites;

  const PlaceDetailsBody({
    Key key,
    @required this.place,
    @required this.onRemoveFromFavorites,
    @required this.onAddingToFavorites,
    @required this.isPlaceInFavorites,
  }) : super(key: key);

  @override
  _PlaceDetailsBodyState createState() => _PlaceDetailsBodyState();
}

class _PlaceDetailsBodyState extends State<PlaceDetailsBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        children: [
          // Place name
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 24),
            child: Text(
              widget.place.name,
              maxLines: 2,
              style: AppTextStyles.placeDetailsTitle.copyWith(
                color: Theme.of(context).textTheme.headline2.color,
              ),
            ),
          ),

          Row(
            children: [
              // Type of place
              Container(
                margin: EdgeInsets.only(right: 16),
                child: Text(
                  PlaceTypes.stringFromPlaceType(widget.place.placeType),
                  style: AppTextStyles.placeDetailsType.copyWith(
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                ),
              ),

              // Opening hours of the place
              Container(
                child: Text(
                  "закрыто до 09:00",
                  style: AppTextStyles.placeDetailsWorkingTime.copyWith(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                ),
              ),
            ],
          ),

          // Place description
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 24),
            child: Text(
              widget.place.description,
              style: AppTextStyles.placeDetailsDescription.copyWith(
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
            ),
          ),

          // Button for building a route
          Container(
            margin: EdgeInsets.symmetric(vertical: 24),
            child: ElevatedButton.icon(
              onPressed: () => print("plote route button"),
              icon: SvgPicture.asset(
                AppIcons.go,
                width: 24,
                height: 24,
              ),
              label: Text(
                AppTextStrings.ploteRouteButton.toUpperCase(),
              ),
            ),
          ),

          // Separator
          Container(
            margin: EdgeInsets.only(
              bottom: 8,
            ),
            child: Divider(
              color: Theme.of(context).dividerColor,
              height: 0.8,
            ),
          ),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // "Plan a hike" button
              Expanded(
                child: TextButton(
                  onPressed: () => print("plan button"),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.calendar,
                        width: 24,
                        height: 24,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      SizedBox(width: 9),
                      Text(
                        AppTextStrings.planningButton,
                        style:
                            AppTextStyles.placeDetailsPlanningButton.copyWith(
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // "Add to favorites" button
              EntityStateBuilder<bool>(
                  streamedState: widget.isPlaceInFavorites,
                  child: (context, isPlaceInFavorites) {
                    return Expanded(
                      child: isPlaceInFavorites
                          ? TextButton.icon(
                              onPressed: () => widget.onRemoveFromFavorites(),
                              icon: SvgPicture.asset(
                                AppIcons.heartFull,
                                width: 24,
                                height: 24,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              label: Text(
                                AppTextStrings.favoritesButtonActive,
                              ),
                            )
                          : TextButton.icon(
                              onPressed: () => widget.onAddingToFavorites(),
                              icon: SvgPicture.asset(
                                AppIcons.heart,
                                width: 24,
                                height: 24,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              label: Text(
                                AppTextStrings.favoritesButtonInactive,
                              ),
                            ),
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
