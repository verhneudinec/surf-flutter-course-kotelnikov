import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/widgets/app_bars/app_bar_custom.dart';
import 'package:places/ui/screen/place_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/error_stub.dart';
import 'package:places/data/interactor/places_search.dart';
import 'package:places/ui/widgets/image_loader_builder.dart';
import 'package:places/ui/widgets/app_bottom_navigation_bar.dart';

/// Screen for searching places by request
class PlaceSearchScreen extends StatefulWidget {
  const PlaceSearchScreen({Key key}) : super(key: key);

  @override
  _PlaceSearchScreenState createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            _body(),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }

  Widget _header() {
    return AppBarCustom(
      title: AppTextStrings.appBarMiniTitle,
      backButtonEnabled: false,
    );
  }

  Widget _body() {
    bool _searchFieldIsNotEmpty =
        context.watch<PlacesSearch>().searchFieldIsNotEmpty;
    bool _isPlacesNotFound = context.watch<PlacesSearch>().isPlacesNotFound;
    List _searchHistory = context.watch<PlacesSearch>().searchHistory;
    List _searchResults = context.watch<PlacesSearch>().searchResults;

    final Map _placeTypes = {
      "hotel": AppTextStrings.hotel,
      "restourant": AppTextStrings.restourant,
      "particular_place": AppTextStrings.particularPlace,
      "park": AppTextStrings.park,
      "museum": AppTextStrings.museum,
      "cafe": AppTextStrings.cafe,
    };

    /// When clicking on a query from the search history
    void _onTapQueryFromHistory(searchQuery) {
      context.read<PlacesSearch>().onSearchSubmitted(
            searchQuery: searchQuery,
            isTapFromHistory: true,
          );
    }

    /// When clicking on a search result
    void _onPlaceClick(int placeIndex) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaceDetails(
            place: Place(id: 1), // TODO MOCKSmocks[placeIndex],
          ),
        ),
      );
    }

    /// When deleting a request from history
    void _onQueryDelete(index) {
      context.read<PlacesSearch>().onQueryDelete(index);
    }

    /// Deleting all requests from the search history
    void _onCleanHistory() {
      context.read<PlacesSearch>().onCleanHistory();
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 6,
            ),
            child: SearchBar(
              readonly: false,
            ),
          ),
          const SizedBox(
            height: 24,
          ),

          /// Display search history
          if (_searchHistory.isNotEmpty && _searchFieldIsNotEmpty == false)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTextStrings.placeSearchScreenSearchHistory.toUpperCase(),
                  style: AppTextStyles.placeSearchScreenSearchHistoryTitle
                      .copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                for (int i = 0; i < _searchHistory.length; i++)
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _searchHistoryButton(
                              text: _searchHistory[i],
                              onTapQueryFromHistory: _onTapQueryFromHistory,
                              onQueryDelete: _onQueryDelete,
                              index: i,
                            ),
                          ),
                        ],
                      ),
                      _divider(),
                    ],
                  ),

                const SizedBox(
                  height: 15,
                ),

                // Clean hostory
                if (_searchHistory.isNotEmpty)
                  InkWell(
                    onTap: () => _onCleanHistory(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 3,
                        bottom: 2,
                      ),
                      child: Text(
                        AppTextStrings.placeSearchScreenCleanHistory,
                        style: AppTextStyles.placeSearchScreenCleanHistory
                            .copyWith(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

          /// Display search results if the conditions are met
          if (_searchFieldIsNotEmpty == true && _searchResults.isNotEmpty)
            Column(
              children: [
                for (int i = 0; i < _searchResults.length; i++)
                  InkWell(
                    onTap: () => _onPlaceClick(i),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: ClipRRect(
                        borderRadius: AppDecorations
                            .placeSearchScreenSearchListTileImage.borderRadius,
                        child: Container(
                          color: Theme.of(context).backgroundColor,
                          width: 56,
                          height: 56,
                          child: Image.network(
                            _searchResults[i].url,
                            fit: BoxFit.cover,
                            loadingBuilder: imageLoaderBuilder,
                            errorBuilder: imageErrorBuilder,
                          ),
                        ),
                      ),
                      title: Text(
                        _searchResults[i].name,
                        style: AppTextStyles
                            .placeSearchScreenSearchListTileTitle
                            .copyWith(
                          color: Theme.of(context).textTheme.headline5.color,
                        ),
                      ),
                      subtitle: Text(
                        _placeTypes[_searchResults[i].type],
                        style: AppTextStyles
                            .placeSearchScreenSearchListTileSubtitle
                            .copyWith(
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

          /// If nothing was found
          if (_searchFieldIsNotEmpty == true && _isPlacesNotFound == true)
            Center(
              child: SizedBox(
                width: 255,
                height: MediaQuery.of(context).size.height -
                    300, // TODO исправить размеры, Expanded
                child: ErrorStub(
                  icon: AppIcons.search,
                  title: AppTextStrings.placesNotFoundTitle,
                  subtitle: AppTextStrings.placesNotFoundSubtitle,
                ),
              ),
            )
        ],
      ),
    );
  }

  // The list item - the element of search history.
  Widget _searchHistoryButton({
    text,
    onTapQueryFromHistory,
    onQueryDelete,
    index,
  }) {
    return InkWell(
      onTap: () => onTapQueryFromHistory(text),
      child: Container(
        height: 48,
        padding: EdgeInsets.symmetric(
          vertical: 14,
        ),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: AppTextStyles.placeSearchScreenSearchHistoryElement
                    .copyWith(
                  color: Theme.of(context).textTheme.caption.color,
                ),
              ),
            ),
            InkWell(
              onTap: () => onQueryDelete(index),
              child: Container(
                margin: EdgeInsets.only(
                  right: 8,
                ),
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  AppIcons.delete,
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Separator between [_searchHistoryButton]
  Widget _divider() {
    return Container(
      child: Divider(
        color: Theme.of(context).disabledColor,
        indent: 0,
        endIndent: 0,
        height: 1,
      ),
    );
  }
}
