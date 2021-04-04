import 'package:flutter/material.dart' hide Action;
import 'package:flutter_svg/svg.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/model/place.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/place_types.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/screen/search_screen/search_wm.dart';
import 'package:places/ui/widgets/app_bars/app_bar_custom.dart';
import 'package:places/ui/widgets/error_stub.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/image_loader_builder.dart';
import 'package:places/ui/widgets/app_bars/app_bottom_navigation_bar.dart';
import 'package:relation/relation.dart';

/// Screen for searching places by request
class SearchScreen extends CoreMwwmWidget {
  const SearchScreen({
    @required WidgetModelBuilder widgetModelBuilder,
  }) : super(widgetModelBuilder: widgetModelBuilder ?? SearchWidgetModel);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends WidgetState<SearchWidgetModel> {
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
              searchFieldController: wm.searchFieldAction.controller,
              onClearTextValue: wm.onClearTextValueAction,
              onSearchChanged: wm.onSearchChangedAction,
              onSearchSubmitted: wm.onSearchSubmitted,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          EntityStateBuilder<List<Place>>(
            streamedState: wm.searchResults,
            loadingChild: _buildLoader(),
            errorChild: _buildError(),
            child: (context, searchResults) {
              return StreamBuilder<String>(
                stream: wm.searchFieldAction.stream,
                builder: (context, searchFieldAction) {
                  return !searchFieldAction.hasData
                      ? _buildSearchResults(searchResults)
                      : _buildSearchHistory();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<Place> searchResults) {
    return Column(
      children: [
        for (int i = 0; i < searchResults.length; i++)
          InkWell(
            onTap: () => wm.onPlaceClickAction(i),
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
                    wm.searchResults.value.data[i].urls[0],
                    fit: BoxFit.cover,
                    loadingBuilder: imageLoaderBuilder,
                    errorBuilder: imageErrorBuilder,
                  ),
                ),
              ),
              title: Text(
                wm.searchResults.value.data[i].name,
                style:
                    AppTextStyles.placeSearchScreenSearchListTileTitle.copyWith(
                  color: Theme.of(context).textTheme.headline5.color,
                ),
              ),
              subtitle: Text(
                PlaceTypes.stringFromPlaceType(
                    wm.searchResults.value.data[i].placeType),
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

  Widget _buildLoader() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 300,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: SizedBox(
        width: 255,
        height: MediaQuery.of(context).size.height / 2,
        child: ErrorStub(
          icon: AppIcons.search,
          title: AppTextStrings.placesNotFoundTitle,
          subtitle: AppTextStrings.placesNotFoundSubtitle,
        ),
      ),
    );
  }

  Widget _buildSearchHistory() {
    return EntityStateBuilder<List<String>>(
      streamedState: wm.searchHistory,
      child: (context, searchHistory) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (searchHistory.isNotEmpty)
              Text(
                AppTextStrings.placeSearchScreenSearchHistory.toUpperCase(),
                style:
                    AppTextStyles.placeSearchScreenSearchHistoryTitle.copyWith(
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
                onTap: () => wm.onClearHistoryAction(),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 3,
                    bottom: 2,
                  ),
                  child: Text(
                    AppTextStrings.placeSearchScreenCleanHistory,
                    style: AppTextStyles.placeSearchScreenCleanHistory.copyWith(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  // The list item - the element of search history.
  Widget _searchHistoryButton({
    text,
    index,
  }) {
    return InkWell(
      onTap: () => wm.onSearchSubmitted(
        searchQuery: text,
        isTapFromHistory: true,
      ),
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
              onTap: () => wm.onQueryDeleteAction(index),
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
