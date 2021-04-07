import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/model/filter.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/place_types.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:places/ui/common/back_button.dart';
import 'package:places/ui/screen/filter_screen/filter_wm.dart';
import 'package:cupertino_range_slider/cupertino_range_slider.dart';
import 'package:places/ui/widgets/custom_list_view_builder.dart';
import 'package:places/res/icons.dart';
import 'package:relation/relation.dart';

/// Screen with filter of places by category and distance.
/// [FilterScreen] contains a header [_FilterScreenHeader] with an AppBar
/// and body [_FilterScreenBody]
class FilterScreen extends CoreMwwmWidget {
  const FilterScreen({
    @required WidgetModelBuilder widgetModelBuilder,
  }) : super(widgetModelBuilder: widgetModelBuilder ?? FilterWidgetModel);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends WidgetState<FilterWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _filterScreenHeader(),
          _filterScreenBody(),
        ],
      ),
    );
  }

  /// AppBar for [FilterScreen] with [AppBackButton]
  Widget _filterScreenHeader() {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      toolbarHeight: 56,
      leading: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 16,
        ),
        child: AppBackButton(),
      ),
      actions: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: 16,
            end: 16,
          ),
          child: SizedBox(
            width: 100,
            child: TextButton(
              onPressed: () => wm.onCleanAllSelectedTypesAction(),
              child: Text(
                AppTextStrings.filterScreenClearButton,
                style: AppTextStyles.filterScreenClearButton.copyWith(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// The body of the screen displaying the categories of places,
  /// distance slider and search button.
  Widget _filterScreenBody() {
    final bool isLargeScreenResolution =
        MediaQuery.of(context).size.height > 800;

    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 16,
        right: 16,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 118,
      constraints: BoxConstraints(
        minHeight: 350,
      ),
      child: EntityStateBuilder<Filter>(
          streamedState: wm.filter,
          child: (context, filter) {
            return Stack(
              children: [
                CustomListViewBuilder(
                  children: [
                    Text(
                      AppTextStrings.fiterScreenTitleText.toUpperCase(),
                      style: AppTextStyles.fiterScreenTitle.copyWith(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),

                    /// Сategory Container
                    Container(
                      width: double.infinity,
                      child: isLargeScreenResolution
                          ? Wrap(
                              // TODO Max elements in row. 45 spacing
                              spacing: 48,
                              runSpacing: 40,
                              alignment: WrapAlignment.spaceEvenly,
                              children: _buildPlaceTypes(
                                filter.searchTypes,
                              ),
                            )
                          : LimitedBox(
                              maxHeight: 92,
                              maxWidth: 312,
                              child: ListView.builder(
                                itemCount: 6,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context,
                                        int placeTypeIndex) =>
                                    Row(
                                  children: [
                                    if (placeTypeIndex == 0)
                                      const SizedBox(width: 25),
                                    _buildPlaceTypes(
                                      filter.searchTypes,
                                    )[placeTypeIndex],
                                    const SizedBox(width: 20),
                                  ],
                                ),
                              ),
                            ),
                    ),

                    const SizedBox(
                      height: 24,
                    ),

                    if (isLargeScreenResolution)
                      const SizedBox(
                        height: 56,
                      ),

                    /// Slider title and
                    /// output the selected search distance
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppTextStrings.filterScreenSliderTitle,
                          style: AppTextStyles.filterScreenSliderTitle.copyWith(
                            color: Theme.of(context).textTheme.headline3.color,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style:
                                AppTextStyles.filterScreenSliderHint.copyWith(
                              color:
                                  Theme.of(context).textTheme.subtitle1.color,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    AppTextStrings.filterScreenSliderRangeFrom,
                              ),
                              TextSpan(
                                text: filter.searchRange.start.toString(),
                              ),
                              TextSpan(
                                text:
                                    AppTextStrings.filterScreenSliderRangeUntil,
                              ),
                              TextSpan(
                                text: filter.searchRange.end.toString(),
                              ),
                              TextSpan(
                                text:
                                    AppTextStrings.filterScreenSliderRangeUnit,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    /// Сustom distance selection slider in Cupertino style
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoRangeSlider(
                        min: 0,
                        max: 10000,
                        minValue: filter.searchRange.start.toDouble().abs(),
                        maxValue: filter.searchRange.end.toDouble().abs(),
                        activeColor: Theme.of(context).accentColor,
                        onMinChanged: (value) =>
                            wm.onSearchRangeStartChangedAction(value.toInt()),
                        onMaxChanged: (value) =>
                            wm.onSearchRangeEndChangedAction(value.toInt()),
                      ),
                    ),

                    if (!isLargeScreenResolution)
                      Column(
                        children: [
                          const SizedBox(
                            height: 41,
                          ),
                          _buildShowButton(
                            searchButtonHandler: wm.onFilterSubmittedAction,
                          ),
                        ],
                      )
                  ],
                ),
                if (isLargeScreenResolution)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: _buildShowButton(
                      searchButtonHandler: wm.onFilterSubmittedAction,
                    ),
                  ),
              ],
            );
          }),
    );
  }

  List<Widget> _buildPlaceTypes(
    Map<String, bool> placeTypes,
  ) =>
      [
        for (int i = 0; i < placeTypes.length; i++)
          Column(
            children: [
              /// Category button with text label
              Container(
                width: 64,
                height: 64,
                decoration: AppDecorations.filterScreenCategoryButton.copyWith(
                  color: Theme.of(context).accentColor.withOpacity(0.16),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: IconButton(
                        onPressed: () => wm.onTypeClickAction(i),
                        icon: SvgPicture.asset(
                          PlaceTypes.iconFromPlaceType(
                            placeTypes.keys.elementAt(i),
                          ),
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    if (placeTypes.values.elementAt(i))
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: AppDecorations.filterScreenCategoryButton
                              .copyWith(
                            color: Theme.of(context).iconTheme.color,
                          ),
                          child: InkWell(
                            borderRadius: AppDecorations
                                .filterScreenCategoryButton.borderRadius,
                            onTap: () => wm.onTypeClickAction(i),
                            child: SvgPicture.asset(
                              AppIcons.tick,
                              color: Theme.of(context)
                                  .colorScheme
                                  .categoryTickColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                PlaceTypes.stringFromPlaceType(
                  placeTypes.keys.elementAt(i),
                ),
                style: AppTextStyles.fiterScreenCategoryTitle.copyWith(
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
            ],
          ),
      ];

  Widget _buildShowButton({
    searchButtonHandler,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 32,
        maxHeight: 48,
      ),
      child: ElevatedButton(
        onPressed: () => searchButtonHandler(),
        child: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: AppTextStyles.fiterScreenShowButton,
            children: [
              TextSpan(
                text: AppTextStrings.filterScreenShowButton,
              )
            ],
          ),
        ),
      ),
    );
  }
}
