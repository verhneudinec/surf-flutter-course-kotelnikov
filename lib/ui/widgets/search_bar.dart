import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/view_model/places_search_model.dart';
import 'package:provider/provider.dart';
import 'package:places/data/interactor/places_search_interactor.dart';
import 'package:places/ui/screen/places_search_screen.dart';
import 'package:places/ui/screen/filter_screen.dart';

/// [SearchBar] displays the search bar for places.
class SearchBar extends StatelessWidget {
  final bool readonly;

  const SearchBar({
    Key key,
    this.readonly = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchFieldController =
        context.watch<PlacesSearchModel>().searchFieldController;

    /// When clicking on an inactive [SeachBar].
    void _onClickSearchBar() {
      if (readonly == true)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceSearchScreen(),
          ),
        );
    }

    /// When clicking on the filter button.
    void _onClickFilterButton() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FilterScreen(),
        ),
      );
    }

    /// If the value in the request has changed
    void _onSearchChanged(String searchQuery) {
      context.read<PlacesSearchModel>().onSearchChanged(context);
    }

    /// When submitting the search form
    void _onSearchSubmitted(String searchQuery) {
      if (searchQuery.isNotEmpty)
        context.read<PlacesSearchModel>().onSearchSubmitted(
              context: context,
              searchQuery: searchQuery,
            );
    }

    /// When clicking on the "Clear" button in the form
    void _onClearTextValue() {
      context.read<PlacesSearchModel>().onClearTextValue();
    }

    return ClipRRect(
      borderRadius: AppDecorations.searchBar.borderRadius,
      child: Stack(
        children: [
          Material(
            child: InkWell(
              onTap: () => {},
              child: Ink(
                color: Theme.of(context).backgroundColor,
                child: TextFormField(
                  controller: _searchFieldController,
                  readOnly: readonly,
                  autofocus: !readonly,
                  textInputAction: TextInputAction.search,
                  onChanged: (value) => _onSearchChanged(value),
                  onFieldSubmitted: (value) => _onSearchSubmitted(value),
                  onTap: () => _onClickSearchBar(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 12,
                    ),
                    hintStyle: AppTextStyles.searchBarHintText.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
                    hintText: AppTextStrings.searchBarHintText,
                    prefixIcon: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: SvgPicture.asset(
                        AppIcons.search,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                    prefix: Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      maxHeight: 24,
                    ),
                    suffixIcon: readonly == true
                        ? null
                        : ClipRRect(
                            borderRadius:
                                AppDecorations.searchBarSuffix.borderRadius,
                            child: Material(
                              child: InkWell(
                                onTap: () => _onClearTextValue(),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: SvgPicture.asset(
                                    AppIcons.subtract,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    suffixIconConstraints: BoxConstraints(
                      maxHeight: 24,
                    ),
                    border: _disabledBorder,
                    focusedBorder: _disabledBorder,
                    enabledBorder: _disabledBorder,
                  ),
                ),
              ),
            ),
          ),
          if (readonly == true)
            Positioned(
              right: 12,
              top: 11,
              child: ClipRRect(
                borderRadius: AppDecorations.searchBarSuffix.borderRadius,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _onClickFilterButton(),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: SvgPicture.asset(
                        AppIcons.filter,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  OutlineInputBorder get _disabledBorder => OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      );
}
