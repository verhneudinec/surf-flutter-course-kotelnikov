import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/models/favorite_sights.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/widgets/imageLoaderBuilder.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:provider/provider.dart';

/// Sight card widget, displays the [sight] data passed to the constructor.
/// The view changes depending on [cardType].
class SightCard extends StatelessWidget {
  final Sight sight;
  final String cardType;

  const SightCard({
    Key key,
    this.sight,
    this.cardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onSightClick() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SightDetails(
            sight: sight,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Container(
        width: double.infinity,
        decoration: AppDecorations.sightCardContainer.copyWith(
          color: Theme.of(context).cardColor,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Header and body of card
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SightCardHeader(
                  sight: sight,
                  cardType: cardType ?? "default",
                ),
                SightCardBody(
                  sight: sight,
                  cardType: cardType ?? "default",
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
              cardType: cardType ?? "default",
            ),
          ],
        ),
      ),
    );
  }
}

class SightCardHeader extends StatelessWidget {
  final Sight sight;
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
            sight.url,
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
            _sightTypes[sight.type.toString()].toString(),
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
  final Sight sight;
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
              maxWidth: cardType == "default" ? 296 : double.infinity,
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

          if (cardType != "default")
            const SizedBox(
              height: 2,
            ),

          // Scheduled date
          if (cardType == "toVisit")
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
          if (cardType == "visited")
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
class SightCardActionButtons extends StatelessWidget {
  final Sight sight;
  final String cardType;
  const SightCardActionButtons({
    Key key,
    this.sight,
    this.cardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Removes the list item from provider
    void onSightCardDelete() {
      context.read<FavoriteSights>().deleteSightFromFavorites(sight.name);
    }

    return _controllButtons(
      onSightCardDelete,
    );
  }

  /// [_controllButtons] Displays buttons based on [cardType].
  Widget _controllButtons(
    onSightCardDelete,
  ) {
    // Add to favorites
    return SizedBox(
      height: 96,
      width: double.infinity,
      child: Stack(
        children: [
          if (cardType == "default")
            Positioned(
              top: 16,
              right: 16,
              child: _iconButton(
                iconPath: "assets/icons/Heart.svg",
              ),
            ),

          // "Remove from list" button
          if (cardType != "default")
            Positioned(
              top: 16,
              right: 16,
              child: _iconButton(
                iconPath: "assets/icons/Delete.svg",
                onPressed: onSightCardDelete,
              ),
            ),

          // Button "Change scheduled visit time"
          if (cardType == "toVisit")
            Positioned(
              top: 16,
              right: 56,
              child: _iconButton(
                iconPath: "assets/icons/Calendar.svg",
              ),
            ),

          // "Share" button
          if (cardType == "visited")
            Positioned(
              top: 16,
              right: 56,
              child: _iconButton(
                iconPath: "assets/icons/Share.svg",
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
}
