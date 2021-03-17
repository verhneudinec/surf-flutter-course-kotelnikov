import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/place_types_strings.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/view_model/places_search_model.dart';
import 'package:places/ui/widgets/app_bars/app_bar_custom.dart';
import 'package:places/ui/screen/place_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/error_stub.dart';
import 'package:places/data/interactor/places_search_interactor.dart';
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
    bool searchFieldIsNotEmpty =
        context.watch<PlacesSearchModel>().searchFieldIsNotEmpty;
    bool isPlacesNotFound = context.watch<PlacesSearchModel>().isPlacesNotFound;
    bool isPlacesLoading = context.watch<PlacesSearchModel>().isPlacesLoading;
    List<String> searchHistory =
        context.watch<PlacesSearchInteractor>().searchHistory;
    List<Place> searchResults =
        context.watch<PlacesSearchInteractor>().searchResults;

    final Map placeTypes = PlaceTypesStrings.map;

    /// When clicking on a query from the search history
    void _onTapQueryFromHistory(searchQuery) {
      context.read<PlacesSearchModel>().onSearchSubmitted(
            context: context,
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
            placeId: placeIndex, // TODO MOCKSmocks[placeIndex],
          ),
        ),
      );
    }

    /// When deleting a request from history
    void _onQueryDelete(int index) {
      context.read<PlacesSearchModel>().onQueryDelete(context, index);
    }

    /// Deleting all requests from the search history
    void _onCleanHistory() {
      context.read<PlacesSearchModel>().onCleanHistory(context);
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
          if (searchHistory.isNotEmpty && searchFieldIsNotEmpty == false)
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
                for (int i = 0; i < searchHistory.length; i++)
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _searchHistoryButton(
                              text: searchHistory[i],
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
                if (searchHistory.isNotEmpty)
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
          if (searchFieldIsNotEmpty && searchResults.isNotEmpty)
            Column(
              children: [
                for (int i = 0; i < searchResults.length; i++)
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
                            searchResults[i].urls[0],
                            fit: BoxFit.cover,
                            loadingBuilder: imageLoaderBuilder,
                            errorBuilder: imageErrorBuilder,
                          ),
                        ),
                      ),
                      title: Text(
                        searchResults[i].name,
                        style: AppTextStyles
                            .placeSearchScreenSearchListTileTitle
                            .copyWith(
                          color: Theme.of(context).textTheme.headline5.color,
                        ),
                      ),
                      subtitle: Text(
                        placeTypes[searchResults[i].placeType],
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

          /// Place loading loader
          if (isPlacesLoading)
            SizedBox(
              height: MediaQuery.of(context).size.height - 300,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),

          /// If nothing was found
          if (searchFieldIsNotEmpty == true && isPlacesNotFound == true)
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
