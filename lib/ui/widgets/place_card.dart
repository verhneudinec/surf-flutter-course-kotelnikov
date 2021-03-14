import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/interactor/favorite_places.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/place_types_strings.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:places/res/card_types.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/widgets/image_loader_builder.dart';
import 'package:places/ui/screen/place_details_screen.dart';
import 'package:provider/provider.dart';

import '../../res/text_strings.dart';

/// Place card widget, displays the [place] data passed to the constructor.
/// The view changes depending on [cardType].
class PlaceCard extends StatelessWidget {
  final Place place;
  final String cardType;

  const PlaceCard({
    Key key,
    this.place,
    this.cardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Removes the list item from provider
    void _onRemoveFromFavorites() {
      context.read<PlacesInteractor>().removeFromFavorites(place);
    }

    void _onAddingToFavorites() {
      context.read<PlacesInteractor>().addToFavorites(place);
    }

    /// Open a window with details of the place,
    /// if there was a click on the card
    void _onPlaceClick() {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            margin: EdgeInsets.only(top: 84),
            child: PlaceDetails(
              placeId: place.id,
              isBottomSheet: true,
            ),
          );
        },
        isScrollControlled: true,
      );

      /// TODO Go to the screen with place details
      /// when clicking on the card
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => PlaceDetails(
      //       place: place,
      //     ),
      //   ),
      // );
    }

    return Container(
      width: double.infinity,
      decoration: AppDecorations.placeCardContainer.copyWith(
        color: Theme.of(context).cardColor,
      ),
      clipBehavior: Clip.antiAlias,
      child: Dismissible(
        key: ValueKey(place.name),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => _onRemoveFromFavorites(),
        background: _dismissibleBackground(context),
        child: Stack(
          children: [
            // Header and body of card
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PlaceCardHeader(
                  place: place,
                  cardType: cardType ?? CardTypes.general,
                ),
                PlaceCardBody(
                  place: place,
                  cardType: cardType ?? CardTypes.general,
                ),
              ],
            ),

            // On pressed ripple effect
            Positioned.fill(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  splashColor: Theme.of(context).splashColor,
                  onTap: () => _onPlaceClick(),
                ),
              ),
            ),

            /// Action buttons: delete place, calendar, share
            PlaceCardActionButtons(
              place: place,
              cardType: cardType ?? CardTypes.general,
              onAddingToFavorites: _onAddingToFavorites,
              onRemoveFromFavorites: _onRemoveFromFavorites,
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
    Map _placeTypes = PlaceTypesStrings.map;
    return Stack(
      children: [
        // Main photo of the place
        Container(
          width: double.infinity,
          height: 96,
          child: Image.network(
            place.urls.elementAt(0),
            fit: BoxFit.cover,
            loadingBuilder: imageLoaderBuilder,
            errorBuilder: imageErrorBuilder,
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
            _placeTypes[place.placeType] ?? place.placeType,
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
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
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
              maxWidth: cardType == CardTypes.general ? 296 : double.infinity,
            ),
            child: Text(
              place.name,
              maxLines: 2,
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

          // Brief description of the place
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
        ],
      ),
    );
  }
}

/// Action buttons for PlaceCard: delete, calendar, share
class PlaceCardActionButtons extends StatefulWidget {
  final Place place;
  final String cardType;
  final onAddingToFavorites;
  final onRemoveFromFavorites;
  const PlaceCardActionButtons({
    Key key,
    this.place,
    this.cardType,
    this.onRemoveFromFavorites,
    this.onAddingToFavorites,
  }) : super(key: key);

  @override
  _PlaceCardActionButtonsState createState() => _PlaceCardActionButtonsState();
}

class _PlaceCardActionButtonsState extends State<PlaceCardActionButtons> {
  DateTime _scheduledDate;
  DateTime _currentDate = DateTime.now();

  /// Modal window for changing the date of visit
  void _onChangeVisitTime() async {
    DateTime _res;

    if (!Platform.isIOS) {
      _res = await showDialog(
          context: context,
          builder: (context) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: _cupertinoDatePicker(),
              ),
            );
          });
    } else {
      _res = await showDatePicker(
        context: context,
        initialDate: _currentDate,
        firstDate: _currentDate,
        lastDate: _currentDate.add(
          Duration(days: 365 * 10),
        ),
        helpText: AppTextStrings.datePickerHelpText,
        confirmText: AppTextStrings.datePickerConfrimText,
        cancelText: AppTextStrings.datePickerCancelText,
        builder: (_, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              dialogBackgroundColor: Theme.of(context).backgroundColor,
            ),
            child: child,
          );
        },
      );
    }

    if (_res != null) {
      setState(() {
        _scheduledDate = _res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool _isPlaceInFavorites =
        context.watch<PlacesInteractor>().isPlaceInFavorites(widget.place);

    return SizedBox(
      height: 96,
      width: double.infinity,
      child: Stack(
        children: [
          if (widget.cardType == CardTypes.general)
            Positioned(
              top: 16,
              right: 16,
              child: _isPlaceInFavorites
                  ? _iconButton(
                      iconPath: AppIcons.heartFull,
                      onPressed: () => widget.onRemoveFromFavorites(),
                    )
                  : _iconButton(
                      iconPath: AppIcons.heart,
                      onPressed: () => widget.onAddingToFavorites(),
                    ),
            ),

          // "Remove from list" button
          if (widget.cardType != CardTypes.general)
            Positioned(
              top: 16,
              right: 16,
              child: _iconButton(
                iconPath: AppIcons.delete,
                onPressed: () => widget.onRemoveFromFavorites(),
              ),
            ),

          // Button "Change scheduled visit time"
          if (widget.cardType == CardTypes.unvisited)
            Positioned(
              top: 16,
              right: 56,
              child: _iconButton(
                iconPath: AppIcons.calendar,
                onPressed: () => _onChangeVisitTime(),
              ),
            ),

          // "Share" button
          if (widget.cardType == CardTypes.visited)
            Positioned(
              top: 16,
              right: 56,
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

  /// Modal window for date picker in Cupertino style
  Widget _cupertinoDatePicker() {
    // The current date
    DateTime _currentDate = DateTime.now();
    // The selected date in the DatePicker
    DateTime _scheduledDate;

    // Function for closing the window
    void _onDateTimeSubmitted() {
      Navigator.of(context).pop(_scheduledDate);
    }

    // When changing the date in the picker
    void _onDateTimeChanged(DateTime scheduledDate) {
      _scheduledDate = scheduledDate;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LimitedBox(
          maxHeight: 300,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: AppDecorations.addPhotoDialog.copyWith(
              color: Theme.of(context).backgroundColor,
            ),
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _currentDate,
              maximumDate: _currentDate.add(Duration(days: 365 * 10)),
              minimumDate: _currentDate,
              onDateTimeChanged: (scheduledDate) =>
                  _onDateTimeChanged(scheduledDate),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextButton(
          onPressed: () => _onDateTimeSubmitted(),
          child: Text(
            AppTextStrings.datePickerConfrimText.toUpperCase(),
            style:
                AppTextStyles.favoritesScreenDatePickerConfrimButton.copyWith(
              color: Theme.of(context).accentColor,
            ),
          ),
          style: Theme.of(context).textButtonTheme.style.copyWith(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).backgroundColor,
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).accentColor,
                ),
                elevation: MaterialStateProperty.all<double>(0),
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(double.infinity, 48),
                ),
              ),
        ),
      ],
    );
  }
}
