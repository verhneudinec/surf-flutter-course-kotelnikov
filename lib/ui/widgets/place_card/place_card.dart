import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/durations.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/place_types.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:places/res/card_types.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/screen/place_details_screen/place_details_widget_builder.dart';
import 'package:places/ui/widgets/image_network.dart';
import 'package:places/ui/widgets/place_card/place_card_wm.dart';
import 'package:relation/relation.dart';

/// Place card widget, displays the [place] data passed to the constructor.
/// The view changes depending on [cardType].
class PlaceCard extends CoreMwwmWidget {
  const PlaceCard({
    @required WidgetModelBuilder widgetModelBuilder,
  }) : super(widgetModelBuilder: widgetModelBuilder ?? PlaceCardWidgetModel);

  @override
  _PlaceCardState createState() => _PlaceCardState();
}

class _PlaceCardState extends WidgetState<PlaceCardWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: AppDecorations.placeCardContainer.copyWith(
        color: Theme.of(context).cardColor,
      ),
      clipBehavior: Clip.antiAlias,
      child: Dismissible(
        key: ValueKey(wm.place.name),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => wm.onRemoveFromFavoritesAction(),
        background: _dismissibleBackground(context),
        child: Stack(
          children: [
            // Header and body of card
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlaceCardHeader(
                  place: wm.place,
                  cardType: wm.cardType ?? CardTypes.general,
                ),
                PlaceCardBody(
                  place: wm.place,
                  cardType: wm.cardType ?? CardTypes.general,
                ),
              ],
            ),

            // On pressed ripple effect
            Positioned.fill(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  splashColor: Theme.of(context).splashColor,
                  onTap: () {
                    Widget placeDetailsContainer = Container(
                      margin: EdgeInsets.only(top: 84),
                      child: PlaceDetailsWidget(
                        wm.place.id,
                        placeImages: wm.place.urls,
                      ),
                    );

                    wm.onPlaceClickAction(placeDetailsContainer);
                  },
                ),
              ),
            ),

            /// Action buttons: delete place, calendar, share
            PlaceCardActionButtons(
              place: wm.place,
              cardType: wm.cardType ?? CardTypes.general,
              isPlaceinFavoritesState: wm.isPlaceinFavoritesState,
              onAddingToFavorites: wm.onAddingToFavoritesAction,
              onDeleteFromFavoritesAction: wm.onDeleteFromFavoritesAction ??
                  wm.onRemoveFromFavoritesAction,
              onChangeVisitTime: wm.onChangeVisitTimeAction,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dismissibleBackground(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.placeCardDismissibleBackground,
      child: Container(
        margin: EdgeInsets.only(right: 16),
        alignment: AlignmentDirectional.centerEnd,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppIcons.bucket,
            ),
            const SizedBox(height: 10),
            Text(
              AppTextStrings.delete,
              style: AppTextStyles.placeCardDismissibleText.copyWith(
                  color:
                      Theme.of(context).colorScheme.placeCardDismissibleText),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceCardHeader extends StatelessWidget {
  final Place place;
  final String cardType;
  const PlaceCardHeader({
    Key key,
    this.place,
    this.cardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main photo of the place
        Container(
          width: double.infinity,
          height: 96,
          child: Hero(
            tag: place.id,
            child: ImageNetwork(
              place.urls.elementAt(0),
            ),
          ),
        ),

        // Container for creating the gradient effect
        Container(
          decoration: AppDecorations.placeCardImageGradient,
          width: double.infinity,
          height: 96,
        ),

        // Type of place
        Positioned(
          top: 16,
          left: 16,
          child: Text(
            PlaceTypes.stringFromPlaceType(place.placeType),
            style: AppTextStyles.placeCardType.copyWith(
              color: Theme.of(context).colorScheme.placeCardTypeColor,
            ),
          ),
        ),
      ],
    );
  }
}

class PlaceCardBody extends StatelessWidget {
  final Place place;
  final String cardType;
  const PlaceCardBody({Key key, this.place, this.cardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Indent
                const SizedBox(
                  height: 18,
                ),

                // Place name
                Container(
                  constraints: BoxConstraints(
                    maxWidth:
                        cardType == CardTypes.general ? 290 : double.infinity,
                  ),
                  child: Text(
                    place.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.placeCardTitle.copyWith(
                      color: Theme.of(context).textTheme.headline4.color,
                    ),
                  ),
                ),

                if (cardType != CardTypes.general)
                  const SizedBox(
                    height: 2,
                  ),

                // Scheduled date
                if (cardType == CardTypes.unvisited)
                  Container(
                    height: 28,
                    child: Text(
                      AppTextStrings.scheduledDate,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.placeCardScheduledDate.copyWith(
                        color: Theme.of(context).textTheme.subtitle1.color,
                      ),
                    ),
                  ),

                // Goal achieved
                if (cardType == CardTypes.visited)
                  Container(
                    height: 28,
                    child: Text(
                      AppTextStrings.goalAchieved,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.placeCardGoalAchieved.copyWith(
                        color: Theme.of(context).textTheme.subtitle2.color,
                      ),
                    ),
                  ),

                const SizedBox(
                  height: 2,
                ),

                // Distance to place
                Container(
                  child: Text(
                    cardType == CardTypes.general
                        ? place.description
                        : (place.distance / 1000).toStringAsFixed(2) +
                            AppTextStrings.cardWidgetDistanceToPlace,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.placeCardWorkingTime.copyWith(
                      color: Theme.of(context).textTheme.subtitle1.color,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),

          /// Route plotting button
          if (cardType == CardTypes.mapCard)
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: AppDecorations.buttonShape.borderRadius,
              ),
              child: Center(
                child: IconButton(
                  onPressed: () => {},
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    AppIcons.go,
                    color:
                        Theme.of(context).colorScheme.placeCardHeartButtonColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Action buttons for PlaceCard: delete, calendar, share
class PlaceCardActionButtons extends StatefulWidget {
  final Place place;
  final String cardType;
  final StreamedState<bool> isPlaceinFavoritesState;
  final onAddingToFavorites;
  final onDeleteFromFavoritesAction;
  final Action<void> onChangeVisitTime;

  const PlaceCardActionButtons({
    Key key,
    this.place,
    this.cardType,
    this.isPlaceinFavoritesState,
    this.onAddingToFavorites,
    this.onDeleteFromFavoritesAction,
    this.onChangeVisitTime,
  }) : super(key: key);

  @override
  _PlaceCardActionButtonsState createState() => _PlaceCardActionButtonsState();
}

class _PlaceCardActionButtonsState extends State<PlaceCardActionButtons> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      width: double.infinity,
      child: Stack(
        children: [
          // "Add to favorites" button
          if (widget.cardType == CardTypes.general)
            StreamedStateBuilder<bool>(
              streamedState: widget.isPlaceinFavoritesState,
              builder: (context, isPlaceinFavorites) {
                return Positioned(
                  top: 16,
                  right: 16,

                  /// Animate clicking on the "Add to favorites" button on card.
                  /// Display different widgets depending on the value of the [isPlaceinFavorites].
                  child: AnimatedCrossFade(
                    duration: AppDurations.commonDuration,
                    firstCurve: Curves.easeIn,
                    secondCurve: Curves.easeOut,
                    crossFadeState: isPlaceinFavorites
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: _iconButton(
                      iconPath: AppIcons.heartFull,
                      onPressed: () => widget.onDeleteFromFavoritesAction(),
                    ),
                    secondChild: _iconButton(
                      iconPath: AppIcons.heart,
                      onPressed: () => widget.onAddingToFavorites(),
                    ),
                  ),
                );
              },
            ),

          // "Remove from list" button
          if (widget.cardType == CardTypes.unvisited)
            Positioned(
              top: 16,
              right: 16,
              child: _iconButton(
                iconPath: AppIcons.delete,
                onPressed: () =>
                    widget.onDeleteFromFavoritesAction(widget.place),
              ),
            ),

          // Button "Change scheduled visit time"
          if (widget.cardType == CardTypes.unvisited)
            Positioned(
              top: 16,
              right: 56,
              child: _iconButton(
                iconPath: AppIcons.calendar,
                onPressed: () => widget.onChangeVisitTime(),
              ),
            ),

          // "Share" button
          if (widget.cardType == CardTypes.visited)
            Positioned(
              top: 16,
              right: 16,
              child: _iconButton(
                iconPath: AppIcons.share,
              ),
            ),
        ],
      ),
    );
  }

  /// Widget for displaying the IconButton
  /// with icon [iconPath] and action [onPressed]
  Widget _iconButton({
    String iconPath,
    onPressed,
  }) {
    return Material(
      type: MaterialType.transparency,
      child: IconButton(
        onPressed: () => onPressed(),
        padding: EdgeInsets.zero,
        splashRadius: 12,
        constraints: BoxConstraints(),
        icon: SvgPicture.asset(
          iconPath,
          color: Theme.of(context).colorScheme.placeCardHeartButtonColor,
        ),
      ),
    );
  }
}
