import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/models/add_sight.dart';
import 'package:places/models/sights.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/widgets/app_bar_custom.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:provider/provider.dart';
import 'package:places/ui/widgets/search_bar.dart';
import 'package:places/ui/widgets/error_stub.dart';
import 'package:places/models/sight_types.dart';
import 'package:places/models/sights_search.dart';
import 'package:places/ui/widgets/imageLoaderBuilder.dart';
import 'package:places/ui/widgets/app_bottom_navigation_bar.dart';
import 'package:places/mocks.dart';

/// Screen for selecting a seat category.
///Opened when adding sight in [AddSightScreen].
class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({Key key}) : super(key: key);

  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
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
    // [_sightTypesData] stores place types from provider [SightTypes].
    bool _searchFieldIsNotEmpty =
        context.watch<SightsSearch>().searchFieldIsNotEmpty;
    bool _isSightsNotFound = context.watch<SightsSearch>().isSightsNotFound;
    List _searchHistory = context.watch<SightsSearch>().searchHistory;
    List _searchResults = context.watch<SightsSearch>().searchResults;

    final Map _sightTypes = {
      "hotel": AppTextStrings.hotel,
      "restourant": AppTextStrings.restourant,
      "particular_place": AppTextStrings.particularPlace,
      "park": AppTextStrings.park,
      "museum": AppTextStrings.museum,
      "cafe": AppTextStrings.cafe,
    };

    void _onTapQueryFromHistory(searchQuery) {
      context.read<SightsSearch>().onSearchSubmitted(
            searchQuery: searchQuery,
            isTapFromHistory: true,
          );
    }

    void _onSightClick(sightIndex) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SightDetails(
            sight: mocks[sightIndex],
          ),
        ),
      );
    }

    void _onQueryDelete(index) {
      context.read<SightsSearch>().onQueryDelete(index);
    }

    void _onCleanHistory() {
      context.read<SightsSearch>().onCleanHistory();
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
          if (_searchHistory.isNotEmpty && _searchFieldIsNotEmpty == false)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTextStrings.sightSearchScreenSearchHistory.toUpperCase(),
                  style: AppTextStyles.sightSearchScreenSearchHistoryTitle
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
                        AppTextStrings.sightSearchScreenCleanHistory,
                        style: AppTextStyles.sightSearchScreenCleanHistory
                            .copyWith(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          if (_searchFieldIsNotEmpty == true && _searchResults.isNotEmpty)
            Column(
              children: [
                for (int i = 0; i < _searchResults.length; i++)
                  InkWell(
                    onTap: () => _onSightClick(i),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: ClipRRect(
                        borderRadius: AppDecorations
                            .sightSearchScreenSearchListTileImage.borderRadius,
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
                            .sightSearchScreenSearchListTileTitle
                            .copyWith(
                          color: Theme.of(context).textTheme.headline5.color,
                        ),
                      ),
                      subtitle: Text(
                        _sightTypes[_searchResults[i].type],
                        style: AppTextStyles
                            .sightSearchScreenSearchListTileSubtitle
                            .copyWith(
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          if (_searchFieldIsNotEmpty == true && _isSightsNotFound == true)
            Center(
              child: SizedBox(
                width: 255,
                height: MediaQuery.of(context).size.height -
                    300, // TODO исправить размеры, Expanded
                child: ErrorStub(
                  icon: "assets/icons/Search.svg",
                  title: AppTextStrings.sightsNotFoundTitle,
                  subtitle: AppTextStrings.sightsNotFoundSubtitle,
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
                style: AppTextStyles.sightSearchScreenSearchHistoryElement
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
                  "assets/icons/Delete.svg",
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
