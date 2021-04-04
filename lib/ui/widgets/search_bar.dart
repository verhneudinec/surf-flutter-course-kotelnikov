import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/res/icons.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/decorations.dart';
import 'package:places/ui/screen/filter_screen/filter_route.dart';
import 'package:places/ui/screen/search_screen/search_route.dart';

/// [SearchBar] displays the search bar for places.
class SearchBar extends StatefulWidget {
  final bool readonly;

  final TextEditingController searchFieldController;

  final onSearchChanged;
  final onClearTextValue;
  final onSearchSubmitted;

  const SearchBar(
      {Key key,
      this.readonly = true,
      this.searchFieldController,
      this.onSearchChanged,
      this.onClearTextValue,
      this.onSearchSubmitted})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  /// When clicking on an inactive [SeachBar].
  void _onClickSearchBar() {
    if (widget.readonly == true)
      Navigator.push(
        context,
        SearchScreenRoute(),
      );
  }

  /// When clicking on the filter button.
  void _onClickFilterButton() {
    Navigator.push(
      context,
      FilterScreenRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: widget.searchFieldController,
                  readOnly: widget.readonly,
                  autofocus: !widget.readonly,
                  textInputAction: TextInputAction.search,
                  onChanged: (value) => widget.onSearchChanged(value),
                  onFieldSubmitted: (value) =>
                      widget.onSearchSubmitted(searchQuery: value),
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
                    suffixIcon: widget.readonly == true
                        ? null
                        : ClipRRect(
                            borderRadius:
                                AppDecorations.searchBarSuffix.borderRadius,
                            child: Material(
                              child: InkWell(
                                onTap: () => widget.onClearTextValue(),
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
          if (widget.readonly == true)
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
