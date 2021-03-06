import 'package:flutter/material.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/ui/widgets/search_bar.dart';

/// Delegate for [SliverPersistentHeader] in [PlaceListScreen].
/// Displays a large or small app bar depending on the value of [shrinkOffset].
/// The big app bar displays [AppTextStrings.appBarTitle] and [SearchBar],
/// and the small one is [AppTextStrings.appBarMiniTitle].
/// [isPortraitOrientation] - true, if the screen orientation is portrait.
class FlexibleAppBarDelegate extends SliverPersistentHeaderDelegate {
  final bool isBigTitle;
  final bool isCenterTitle;
  final String title;
  FlexibleAppBarDelegate({
    this.title,
    this.isBigTitle,
    this.isCenterTitle = false,
  });

  /// The multiplier [_minExtentMultiplier] is used for the condition
  /// of the app bar output depending on the size
  final double _minExtentMultiplier = 1.4;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SafeArea(
      child: Column(
        children: [
          isBigTitle
              ? Expanded(
                  /// Display different app bars depending on [shrinkOffset]
                  child: shrinkOffset < minExtent * _minExtentMultiplier
                      ?
                      // Big AppBar
                      Container(
                          padding: EdgeInsets.only(
                            // Top padding decreases with scrolling
                            top: (minExtent - shrinkOffset).clamp(
                              16.0,
                              40.0,
                            ),
                            left: 16,
                            right: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title of big app bar
                              Text(
                                title ?? AppTextStrings.appBarTitle,
                                style: AppTextStyles.appBarTitle.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .color,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              // Rubber height for nice visual effect,
                              // [SizedBox] decreases on scrolling.
                              SizedBox(
                                height: (minExtent - shrinkOffset).clamp(
                                  2.0,
                                  24.0,
                                ),
                              ),

                              // Search with filter
                              if (shrinkOffset <
                                  minExtent * _minExtentMultiplier)
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    child: SearchBar(),
                                  ),
                                ),
                            ],
                          ),
                        )
                      :
                      // Small app bar
                      Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          height: minExtent,
                          child: Center(
                            child: Text(
                              AppTextStrings.appBarMiniTitle,
                              style: AppTextStyles.appBarMiniTitle.copyWith(
                                color:
                                    Theme.of(context).textTheme.headline3.color,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Container(
                          height: minExtent,
                          child: Align(
                            alignment: isCenterTitle
                                ? Alignment.center
                                : Alignment.centerLeft,
                            child: Text(
                              title ?? AppTextStrings.appBarMiniTitle,
                              style: AppTextStyles.appBarMiniTitle.copyWith(
                                color:
                                    Theme.of(context).textTheme.headline3.color,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 6,
                            ),
                            child: SearchBar(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => isBigTitle ? 216 : 122;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
