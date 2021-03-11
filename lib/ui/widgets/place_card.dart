import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/interactor/favorite_sights.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:places/res/card_types.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/widgets/image_loader_builder.dart';
import 'package:places/ui/screen/place_details_screen.dart';
import 'package:provider/provider.dart';

/// Sight card widget, displays the [sight] data passed to the constructor.
/// The view changes depending on [cardType].
class SightCard extends StatelessWidget {
  final Place sight;
  final String cardType;

  const SightCard({
    Key key,
    this.sight,
    this.cardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Removes the list item from provider
    void _onSightCardDelete() {
      context.read<FavoriteSights>().deleteSightFromFavorites(sight.name);
    }

    /// Open a window with details of the place,
    /// if there was a click on the card
    void _onSightClick() {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            margin: EdgeInsets.only(top: 84),
            child: SightDetails(
              sight: sight,
              isBottomSheet: true,
            ),
          );
        },
        isScrollControlled: true,
      );

      /// TODO Go to the screen with sight details
      /// when clicking on the card
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => SightDetails(
      //       sight: sight,
      //     ),
      //   ),
      // );
    }

    return Container(
      width: double.infinity,
      decoration: AppDecorations.sightCardContainer.copyWith(
        color: Theme.of(context).cardColor,
      ),
      clipBehavior: Clip.antiAlias,
      child: Dismissible(
        key: ValueKey(sight.name),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) => _onSightCardDelete(),
        background: _dismissibleBackground(context),
        child: Stack(
          children: [
            // Header and body of card
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SightCardHeader(
                  sight: sight,
                  cardType: cardType ?? CardTypes.general,
                ),
                SightCardBody(
                  sight: sight,
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
                  onTap: () => _onSightClick(),
                ),
              ),
            ),

            /// Action buttons: delete sight, calendar, share
            SightCardActionButtons(
              sight: sight,
              cardType: cardType ?? CardTypes.general,
              onSightCardDelete: _onSightCardDelete,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dismissibleBackground(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.sightCardDismissibleBackground,
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
              style: AppTextStyles.sightCardDismissibleText.copyWith(
                  color:
                      Theme.of(context).colorScheme.sightCardDismissibleText),
            ),
          ],
        ),
      ),
    );
  }
}

class SightCardHeader extends StatelessWidget {
  final Place sight;
  final String cardType;
  const SightCardHeader({
    Key key,
    this.sight,
    this.cardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map _sightTypes = {
      "hotel": AppTextStrings.hotel,
      "restourant": AppTextStrings.restourant,
      "particular_place": AppTextStrings.particularPlace,
      "park": AppTextStrings.park,
      "museum": AppTextStrings.museum,
      "cafe": AppTextStrings.cafe,
    };
    return Stack(
      children: [
        // Main photo of the place
        Container(
          width: double.infinity,
          height: 96,
          child: Image.network(
            sight.urls.elementAt(0),
            fit: BoxFit.cover,
            loadingBuilder: imageLoaderBuilder,
            errorBuilder: imageErrorBuilder,
          ),
        ),

        // Container for creating the gradient effect
        Container(
          decoration: AppDecorations.sightCardImageGradient,
          width: double.infinity,
          height: 96,
        ),

        // Type of place
        Positioned(
          top: 16,
          left: 16,
          child: Text(
            _sightTypes[sight.type],
            style: AppTextStyles.sightCardType.copyWith(
              color: Theme.of(context).colorScheme.sightCardTypeColor,
            ),
          ),
        ),
      ],
    );
  }
}

class SightCardBody extends StatelessWidget {
  final Place sight;
  final String cardType;
  const SightCardBody({Key key, this.sight, this.cardType}) : super(key: key);

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
              sight.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.sightCardTitle.copyWith(
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
                style: AppTextStyles.sightCardScheduledDate.copyWith(
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
                style: AppTextStyles.sightCardGoalAchieved.copyWith(
                  color: Theme.of(context).textTheme.subtitle2.color,
                ),
              ),
            ),

          const SizedBox(
            height: 2,
          ),

          // Working hours
          Container(
            child: Text(
              sight.workingTime,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.sightCardWorkingTime.copyWith(
                color: Theme.of(context).textTheme.subtitle1.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Action buttons for SightCard: delete, calendar, share
class SightCardActionButtons extends StatefulWidget {
  final Place sight;
  final String cardType;
  final onSightCardDelete;
  const SightCardActionButtons({
    Key key,
    this.sight,
    this.cardType,
    this.onSightCardDelete,
  }) : super(key: key);

  @override
  _SightCardActionButtonsState createState() => _SightCardActionButtonsState();
}

class _SightCardActionButtonsState extends State<SightCardActionButtons> {
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
    return SizedBox(
      height: 96,
      width: double.infinity,
      child: Stack(
        children: [
          if (widget.cardType == CardTypes.general)
            Positioned(
              top: 16,
              right: 16,
              child: _iconButton(
                iconPath: AppIcons.heart,
              ),
            ),

          // "Remove from list" button
          if (widget.cardType != CardTypes.general)
            Positioned(
              top: 16,
              right: 16,
              child: _iconButton(
                iconPath: AppIcons.delete,
                onPressed: () => widget.onSightCardDelete(),
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
