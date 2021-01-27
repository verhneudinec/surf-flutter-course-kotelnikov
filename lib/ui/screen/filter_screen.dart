/// Screen with filter of places by category and distance.
/// [FilterScreen] contains a header [_FilterScreenHeader] with an AppBar
/// and body [_FilterScreenBody]

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/localization.dart';
import 'package:places/mocks.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:places/ui/common/back_button.dart';
import 'package:cupertino_range_slider/cupertino_range_slider.dart';
import 'package:places/utils/filter.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({Key key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              _FilterScreenHeader(),
              _FilterScreenBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterScreenHeader extends StatelessWidget {
  const _FilterScreenHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => print("Clear button"),
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
}

class _FilterScreenBody extends StatefulWidget {
  const _FilterScreenBody({Key key}) : super(key: key);

  @override
  __FilterScreenBodyState createState() => __FilterScreenBodyState();
}

class __FilterScreenBodyState extends State<_FilterScreenBody> {
  double _searchRangeStart = 100;
  double _searchRangeEnd = 10000;

  final _testGeoPosition = testGeoPosition;

  final List _foundSights = [];
  final List _testMocks = mocks;
  final List _sightTypesData = [
    {
      "name": "hotel",
      "text": AppTextStrings.hotel,
      "icon": "assets/icons/categories/Hotel.svg",
      "selected": false,
    },
    {
      "name": "restourant",
      "text": AppTextStrings.restourant,
      "icon": "assets/icons/categories/Restourant.svg",
      "selected": false,
    },
    {
      "name": "particular_place",
      "text": AppTextStrings.particularPlace,
      "icon": "assets/icons/categories/Particular_place.svg",
      "selected": false,
    },
    {
      "name": "park",
      "text": AppTextStrings.park,
      "icon": "assets/icons/categories/Park.svg",
      "selected": false,
    },
    {
      "name": "museum",
      "text": AppTextStrings.museum,
      "icon": "assets/icons/categories/Museum.svg",
      "selected": false,
    },
    {
      "name": "cafe",
      "text": AppTextStrings.cafe,
      "icon": "assets/icons/categories/Cafe.svg",
      "selected": false,
    },
  ];

  void onClearHandler() {
    setState(() {
      _searchRangeStart = 100;
      _searchRangeEnd = 10000;
      _foundSights.clear();
      _sightTypesData.forEach((sightType) {
        sightType["selected"] = false;
      });
    });
  }

  void _onTypeClickHandler(i) {
    setState(() {
      // inverse a bool value of property [selected]
      _sightTypesData.elementAt(i)["selected"] =
          !_sightTypesData.elementAt(i)["selected"];
    });
    _searchButtonHandler();
  }

  void _onMinSliderChangeHandler(searchRangeStart) {
    setState(() {
      _searchRangeStart = searchRangeStart;
    });
    _searchButtonHandler();
    // TODO сделать задержку 1-2 секунды до вывода результатов
  }

  void _onMaxSliderChangeHandler(searchRangeEnd) {
    setState(() {
      _searchRangeEnd = searchRangeEnd;
    });
    _searchButtonHandler();
    // TODO сделать задержку 1-2 секунды до вывода результатов
  }

  void _searchButtonHandler() {
    List _selectedTypes = [];
    List _foundSightsBySelectedTypes = [];

    setState(() {
      _foundSights.clear();
    });

    /// create a list [_selectedTypes] only with selected categories
    _sightTypesData.forEach(
      (sigth) {
        if (sigth["selected"] == true) _selectedTypes.add(sigth["name"]);
      },
    );

    /// create a list [_foundSightsBySelectedTypes] with filtered
    /// data from [_testMocks] by [_selectedTypes]
    if (_selectedTypes.isNotEmpty && _testMocks.isNotEmpty) {
      _testMocks.forEach((sight) {
        _selectedTypes.forEach(
          (selectedType) {
            if (selectedType == sight.type) {
              _foundSightsBySelectedTypes.add(sight);
            }
          },
        );
      });
    } else
      print("Не выбраны категории"); // TODO Shake alert

    /// finally create the [_foundSights] list, filtered taking into
    /// account the selected categories [_selectedTypes], search range
    /// [_searchRangeStart], [_searchRangeEnd] and the user's location
    /// [_testGeoPosition]
    if (_foundSightsBySelectedTypes.isNotEmpty) {
      _foundSightsBySelectedTypes.forEach(
        (sight) => {
          if (isPointInsideRange(
            imHere: _testGeoPosition,
            checkPoint: sight.geoPosition,
            minDistance: _searchRangeStart,
            maxDistance: _searchRangeEnd,
          ))
            setState(() {
              _foundSights.add(sight);
            })
        },
      );
    } else
      print("Мест не найдено"); // TODO Shake alert
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 16,
        right: 16,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 118,
      constraints: BoxConstraints(
        minHeight: 550,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Wrap(
                  spacing: 44,
                  runSpacing: 40,
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < _sightTypesData.length; i++)
                      Column(
                        children: [
                          /// Category button with text label
                          Container(
                            width: 64,
                            height: 64,
                            decoration: AppDecorations
                                .filterScreenCategoryButton
                                .copyWith(
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.16),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: IconButton(
                                    onPressed: () => _onTypeClickHandler(i),
                                    icon: SvgPicture.asset(
                                      _sightTypesData.elementAt(i)["icon"],
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ),
                                if (_sightTypesData.elementAt(i)["selected"] ==
                                    true)
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: AppDecorations
                                          .filterScreenCategoryButton
                                          .copyWith(
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      child: InkWell(
                                        borderRadius: AppDecorations
                                            .filterScreenCategoryButton
                                            .borderRadius,
                                        onTap: () => _onTypeClickHandler(i),
                                        child: SvgPicture.asset(
                                          "assets/icons/Tick.svg",
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
                            _sightTypesData.elementAt(i)["text"],
                            style:
                                AppTextStyles.fiterScreenCategoryTitle.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
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
                          text: _searchRangeStart.toInt().toString(),
                        ),
                        TextSpan(
                          text: AppTextStrings.filterScreenSliderRangeUntil,
                        ),
                        TextSpan(
                          text: _searchRangeEnd.toInt().toString(),
                        ),
                        TextSpan(
                          text: AppTextStrings.filterScreenSliderRangeUnit,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),

              /// Сustom distance selection slider in Cupertino style
              SizedBox(
                width: double.infinity,
                child: CupertinoRangeSlider(
                  min: 100,
                  max: 10000,
                  minValue: _searchRangeStart.toDouble(),
                  maxValue: _searchRangeEnd.toDouble(),
                  activeColor: Theme.of(context).accentColor,
                  onMinChanged: (value) => _onMinSliderChangeHandler(value),
                  onMaxChanged: (value) => _onMaxSliderChangeHandler(value),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 32,
                maxHeight: 48,
              ),
              child: ElevatedButton(
                onPressed: () => _searchButtonHandler(),
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: AppTextStyles.fiterScreenShowButton,
                    children: [
                      TextSpan(
                          text: AppTextStrings.filterScreenShowButton
                                  .toUpperCase() +
                              " "),
                      TextSpan(
                          text: "(" + _foundSights.length.toString() + ")"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
