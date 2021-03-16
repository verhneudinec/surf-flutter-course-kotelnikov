import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:places/ui/common/back_button.dart';
import 'package:places/data/interactor/places_search_interactor.dart';
import 'package:places/ui/view_model/place_types_model.dart';
import 'package:places/ui/screen/places_list_screen.dart';
import 'package:cupertino_range_slider/cupertino_range_slider.dart';
import 'package:places/ui/widgets/custom_list_view_builder.dart';
import 'package:places/res/icons.dart';
import 'package:provider/provider.dart';

/// Screen with filter of places by category and distance.
/// [FilterScreen] contains a header [_FilterScreenHeader] with an AppBar
/// and body [_FilterScreenBody]
class FilterScreen extends StatefulWidget {
  FilterScreen({Key key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    final bool _isLargeScreenResolution =
        MediaQuery.of(context).size.height > 800;

    int _searchRangeStart =
        context.watch<PlacesSearchInteractor>().searchRangeStart;
    int _searchRangeEnd =
        context.watch<PlacesSearchInteractor>().searchRangeEnd;
    final List _searchResults = context
        .watch<PlacesSearchInteractor>()
        .searchResults; // TODO Типизировать все List'ы
    final List _placeTypes = context.watch<PlaceTypes>().placeTypesData;

    void _onCleanAllSearchParameters() {
      context.read<PlacesSearchInteractor>().onCleanRange();
      context.read<PlaceTypes>().onCleanAllSelectedTypes();
    }

    void _searchButtonHandler() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaceListScreen(),
        ),
      );
    }

    void _onSearchSubmited() {
      context.read<PlacesSearchInteractor>().onSearchSubmitted(
            isSearchFromFilterScreen: true,
          );
    }

    /// The handler is triggered when clicking on a category of a place
    void _onTypeClickHandler(index) {
      context.read<PlaceTypes>().onTypeClickHandler(index);
      _onSearchSubmited();
    }

    /// The handler is triggered when the minimum distance change
    /// in slider.
    void _onMinSliderChangeHandler(searchRangeStart) {
      context.read<PlacesSearchInteractor>().onSearchRangeStartChanged(
            searchRangeStart.toInt(),
          );
      _onSearchSubmited();
      // TODO сделать задержку 1-2 секунды до вывода результатов
    }

    /// The handler is triggered when the maximum distance change
    /// in slider.
    void _onMaxSliderChangeHandler(searchRangeEnd) {
      context.read<PlacesSearchInteractor>().onSearchRangeEndChanged(
            searchRangeEnd.toInt(),
          );
      _onSearchSubmited();
      // TODO сделать задержку 1-2 секунды до вывода результатов
    }

    return Scaffold(
      body: Column(
        children: [
          _filterScreenHeader(_onCleanAllSearchParameters),
          _filterScreenBody(
            isLargeScreenResolution: _isLargeScreenResolution,
            searchRangeStart: _searchRangeStart,
            searchRangeEnd: _searchRangeEnd,
            searchResults: _searchResults,
            placeTypes: _placeTypes,
            searchButtonHandler: _searchButtonHandler,
            onTypeClickHandler: _onTypeClickHandler,
            onMinSliderChangeHandler: _onMinSliderChangeHandler,
            onMaxSliderChangeHandler: _onMaxSliderChangeHandler,
          ),
        ],
      ),
    );
  }

  /// AppBar for [FilterScreen] with [AppBackButton]
  Widget _filterScreenHeader(_onCleanAllSearchParameters) {
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
            width: 90,
            child: TextButton(
              onPressed: () => _onCleanAllSearchParameters(),
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
  Widget _filterScreenBody({
    bool isLargeScreenResolution,
    int searchRangeStart,
    int searchRangeEnd,
    List searchResults,
    List placeTypes,
    searchButtonHandler,
    onTypeClickHandler,
    onMinSliderChangeHandler,
    onMaxSliderChangeHandler,
  }) {
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
      child: Stack(
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
                        spacing: 44,
                        runSpacing: 40,
                        alignment: WrapAlignment.spaceEvenly,
                        children:
                            _buildPlaceTypes(placeTypes, onTypeClickHandler),
                      )
                    : LimitedBox(
                        maxHeight: 92,
                        maxWidth: 312,
                        child: ListView.builder(
                          itemCount: 6,
                          scrollDirection: Axis.horizontal,
                          itemBuilder:
                              (BuildContext context, int placeTypeIndex) => Row(
                            children: [
                              if (placeTypeIndex == 0)
                                const SizedBox(width: 25),
                              _buildPlaceTypes(placeTypes, onTypeClickHandler)[
                                  placeTypeIndex],
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
                      style: AppTextStyles.filterScreenSliderHint.copyWith(
                        color: Theme.of(context).textTheme.subtitle1.color,
                      ),
                      children: [
                        TextSpan(
                          text: AppTextStrings.filterScreenSliderRangeFrom,
                        ),
                        TextSpan(
                          text: searchRangeStart.toInt().toString(),
                        ),
                        TextSpan(
                          text: AppTextStrings.filterScreenSliderRangeUntil,
                        ),
                        TextSpan(
                          text: searchRangeEnd.toInt().toString(),
                        ),
                        TextSpan(
                          text: AppTextStrings.filterScreenSliderRangeUnit,
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
                  min: 100,
                  max: 10000,
                  minValue: searchRangeStart.toDouble(),
                  maxValue: searchRangeEnd.toDouble(),
                  activeColor: Theme.of(context).accentColor,
                  onMinChanged: (value) => onMinSliderChangeHandler(value),
                  onMaxChanged: (value) => onMaxSliderChangeHandler(value),
                ),
              ),

              if (!isLargeScreenResolution)
                Column(
                  children: [
                    const SizedBox(
                      height: 41,
                    ),
                    _buildShowButton(
                      searchResults: searchResults,
                      searchButtonHandler: searchButtonHandler,
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
                searchResults: searchResults,
                searchButtonHandler: searchButtonHandler,
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildPlaceTypes(
    List placeTypes,
    onTypeClickHandler,
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
                        onPressed: () => onTypeClickHandler(i),
                        icon: SvgPicture.asset(
                          placeTypes.elementAt(i)["icon"],
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    if (placeTypes.elementAt(i)["selected"] == true)
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
                            onTap: () => onTypeClickHandler(i),
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
                placeTypes.elementAt(i)["text"],
                style: AppTextStyles.fiterScreenCategoryTitle.copyWith(
                  color: Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
            ],
          ),
      ];

  Widget _buildShowButton({
    List searchResults,
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
                  text: AppTextStrings.filterScreenShowButton.toUpperCase() +
                      " "),
              TextSpan(
                text: "(" + searchResults.length.toString() + ")",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
