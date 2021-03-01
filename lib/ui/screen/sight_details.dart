import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/common/back_button.dart';
import 'package:places/ui/widgets/image_loader_builder.dart';

/// Screen with detailed information about the place
/// [SightDetails] contains a header [SightDetailsHeader]
/// and body [SightDetailsBody] with basic information about the place
class SightDetails extends StatelessWidget {
  final Sight sight;
  const SightDetails({Key key, this.sight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            expandedHeight: 360,
            flexibleSpace: FlexibleSpaceBar(
              background: SightDetailsHeader(sight: sight),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: SightDetailsBody(sight: sight),
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class SightDetailsHeader extends StatefulWidget {
  final Sight sight;
  const SightDetailsHeader({Key key, this.sight}) : super(key: key);

  @override
  _SightDetailsHeaderState createState() => _SightDetailsHeaderState();
}

class _SightDetailsHeaderState extends State<SightDetailsHeader> {
  final PageController _photogalleryController = new PageController();
  int _currentPhotogalleryIndex = 0;

  void _updateCurrentPhotogalleryIndex(int currentIndex) {
    setState(() {
      _currentPhotogalleryIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _photogallery(),

        // Container for creating the gradient effect
        Container(
          decoration: AppDecorations.sightCardImageGradient,
          width: double.infinity,
          height: 96,
        ),

        // "Go back" button
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              top: 12,
            ),
            child: AppBackButton(
              backgroundColor: Theme.of(context).backgroundColor,
            ),
          ),
        ),

        _photogalleryIndicator(),
      ],
    );
  }

  /// Photogallery of the sight.
  /// Displays photos from [widget.sight.urls]
  Widget _photogallery() {
    return LimitedBox(
      maxWidth: MediaQuery.of(context).size.width,
      maxHeight: 360,
      child: PageView.builder(
        controller: _photogalleryController,
        itemCount: widget.sight.urls.length,
        physics: Platform.isAndroid
            ? ClampingScrollPhysics()
            : BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: double.infinity,
            height: 360,
            decoration: AppDecorations.sightCardImageGradient,
            child: Image.network(
              widget.sight.urls.elementAt(index),
              fit: BoxFit.cover,
              loadingBuilder: imageLoaderBuilder,
              errorBuilder: imageErrorBuilder,
            ),
          );
        },
        onPageChanged: (int page) => _updateCurrentPhotogalleryIndex(page),
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
      child: Row(
        children: [
          for (int i = 0; i < widget.sight.urls.length; i++)
            i == _currentPhotogalleryIndex
                ? Container(
                    width: MediaQuery.of(context).size.width /
                        widget.sight.urls.length,
                    height: 7.5,
                    decoration: AppDecorations.galleryIndicator.copyWith(
                      color: Theme.of(context).iconTheme.color,
                    ),
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width /
                        widget.sight.urls.length,
                  ),
        ],
      ),
    );
  }
}

class SightDetailsBody extends StatelessWidget {
  final Sight sight;
  const SightDetailsBody({Key key, this.sight}) : super(key: key);

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

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        children: [
          // Sight name
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 24),
            child: Text(
              sight.name,
              maxLines: 2,
              style: AppTextStyles.sightDetailsTitle.copyWith(
                color: Theme.of(context).textTheme.headline2.color,
              ),
            ),
          ),

          Row(
            children: [
              // Type of sight
              Container(
                margin: EdgeInsets.only(right: 16),
                child: Text(
                  _sightTypes[sight.type],
                  style: AppTextStyles.sightDetailsType.copyWith(
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                ),
              ),

              // Opening hours of the sight
              Container(
                child: Text(
                  "закрыто до 09:00",
                  style: AppTextStyles.sightDetailsWorkingTime.copyWith(
                    color: Theme.of(context).textTheme.caption.color,
                  ),
                ),
              ),
            ],
          ),

          // Sight description
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 24),
            child: Text(
              sight.details,
              style: AppTextStyles.sightDetailsDescription.copyWith(
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
                            AppTextStyles.sightDetailsPlanningButton.copyWith(
                          color: Theme.of(context).textTheme.bodyText1.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // "Add to favorites" button
              Expanded(
                child: TextButton.icon(
                  onPressed: () => print("to favorites button"),
                  icon: SvgPicture.asset(
                    AppIcons.heart,
                    width: 24,
                    height: 24,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  label: Text(
                    AppTextStrings.favoritesButton,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
