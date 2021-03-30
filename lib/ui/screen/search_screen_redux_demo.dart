import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/app_state.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/redux/action/places_search_action.dart';
import 'package:places/data/redux/state/places_search_state.dart';
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
class PlaceSearchScreenReduxDemo extends StatefulWidget {
  const PlaceSearchScreenReduxDemo({Key key}) : super(key: key);

  @override
  _PlaceSearchScreenReduxDemoState createState() =>
      _PlaceSearchScreenReduxDemoState();
}

class _PlaceSearchScreenReduxDemoState
    extends State<PlaceSearchScreenReduxDemo> {
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
      title: "Демо SearchScreen на Redux",
      backButtonEnabled: false,
    );
  }

  Widget _body() {
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
          _SearchResultsStoreConnector(),
        ],
      ),
    );
  }
}

/// Connector for redux store
class _SearchResultsStoreConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SearchState>(
      converter: (store) => store.state.searchState,
      builder: (BuildContext context, SearchState searchState) {
        /// When loading data
        if (searchState is SearchLoadingState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        /// When successfully loaded data
        else if (searchState is SearchDataState) {
          return _LoadedSearchResults(
            searchResults: searchState.results,
          );
        }

        /// If there is an error during loading, we display a stub
        else if (searchState is SearchErrorState) {
          return _ErrorStub();
        }

        /// If nothing has been entered yet, then display an empty block
        else
          return SizedBox.shrink();
      },
    );
  }
}

/// Class for displaying found places
class _LoadedSearchResults extends StatefulWidget {
  final List<Place> searchResults;

  const _LoadedSearchResults({Key key, this.searchResults}) : super(key: key);

  @override
  __LoadedSearchResultsState createState() => __LoadedSearchResultsState();
}

class __LoadedSearchResultsState extends State<_LoadedSearchResults> {
  /// When clicking on a search result
  void onPlaceClick(int placeIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetails(
          placeId: placeIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.searchResults.length; i++)
          InkWell(
            onTap: () => onPlaceClick(i),
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
                    widget.searchResults[i].urls[0],
                    fit: BoxFit.cover,
                    loadingBuilder: imageLoaderBuilder,
                    errorBuilder: imageErrorBuilder,
                  ),
                ),
              ),
              title: Text(
                widget.searchResults[i].name,
                style:
                    AppTextStyles.placeSearchScreenSearchListTileTitle.copyWith(
                  color: Theme.of(context).textTheme.headline5.color,
                ),
              ),
              subtitle: Text(
                widget.searchResults[i].placeType,
                style: AppTextStyles.placeSearchScreenSearchListTileSubtitle
                    .copyWith(
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Error stub
class _ErrorStub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: MediaQuery.of(context).size.height / 2,
        child: ErrorStub(
          icon: AppIcons.error,
          title: AppTextStrings.dataLoadingErrorTitle,
          subtitle: AppTextStrings.dataLoadingErrorSubtitle,
        ),
      ),
    );
  }
}
