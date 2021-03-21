import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/ui/view_model/add_place_model.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:places/res/icons.dart';
import 'package:places/ui/screen/selecting_place_type_screen.dart';
import 'package:places/ui/widgets/app_bars/app_bar_custom.dart';
import 'package:places/ui/widgets/custom_list_view_builder.dart';
import 'package:provider/provider.dart';

/// Screen for adding and editing a place
/// State is controlled by [AddPlace]
class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  /// [_onPlaceCreate] takes the prepared data of the new
  /// place from [AddPlace] and writes them to
  /// array of mock data from [Places].
  void _onPlaceCreate() {
    context.read<AddPlace>().addNewPlace(context);
    Navigator.of(context).pop();
    // TODO Сделать экран с уведомлением о том, что место добавлено
  }

  /// When clicking on the category selection button
  void _onSelectPlaceType() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (BuildContext context) => SelectingPlaceTypeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// [_isFieldsFilled] check for filling in all fields.
    /// The "Save" button becomes active when this field is true.
    bool _isFieldsFilled = context.watch<AddPlace>().isFieldsFilled;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            _body(),
          ],
        ),
      ),
      bottomNavigationBar: _createPlaceButton(
        _isFieldsFilled,
        _onPlaceCreate,
      ),
    );
  }

  Widget _header() {
    return AppBarCustom(
      title: AppTextStrings.addPlaceScreenTitle,
      cancelButtonEnabled: true,
    );
  }

  Widget _body() {
    /// Controllers for text fields
    final TextEditingController _placeTypeController =
            context.watch<AddPlace>().placeTypeController,
        _placeNameController = context.watch<AddPlace>().placeNameController,
        _placeLatitudeController =
            context.watch<AddPlace>().placeLatitudeController,
        _placeLongitudeController =
            context.watch<AddPlace>().placeLongitudeController,
        _placeDescriptionController =
            context.watch<AddPlace>().placeDescriptionController;

    /// Photogallery of the place
    List _placePhotogallery = context.watch<AddPlace>().placePhotogallery;

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          _photogallery(_placePhotogallery),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _placeType(_placeTypeController, _onSelectPlaceType),

                const SizedBox(
                  height: 24,
                ),

                /// Place name
                Text(
                  AppTextStrings.addPlaceScreenPlaceNameLabel.toUpperCase(),
                  style: AppTextStyles.addPlaceScreenLabel.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                _outlinedTextField(
                  hintText: AppTextStrings.addPlaceScreenTextFormFieldEmpty,
                  controller: _placeNameController,
                  focusNode: context.watch<AddPlace>().nameFieldFocusNode,
                  nextFocusNode:
                      context.watch<AddPlace>().latitudeFieldFocusNode,
                ),

                const SizedBox(
                  height: 24,
                ),

                _placeGeolocation(
                  _placeLatitudeController,
                  _placeLongitudeController,
                ),

                const SizedBox(
                  height: 12,
                ),

                _specifyCoordinatesOnMap(),

                const SizedBox(
                  height: 35,
                ),

                Text(
                  AppTextStrings.addPlaceScreenPlaceDescriptionLabel
                      .toUpperCase(),
                  style: AppTextStyles.addPlaceScreenLabel.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                _outlinedTextField(
                  hintText: AppTextStrings.addPlaceScreenTextFormFieldEmpty,
                  maxLines: 4,
                  focusNode: context.watch<AddPlace>().detailsFieldFocusNode,
                  controller: _placeDescriptionController,
                  nextFocusNode:
                      context.watch<AddPlace>().detailsFieldFocusNode,
                  isLastField: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// "Add a new place" button
  Widget _createPlaceButton(bool _isFieldsFilled, _onPlaceCreate) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: TextButton(
        onPressed: () {
          if (_isFieldsFilled == true)
            _onPlaceCreate();
          else
            print("Не все поля заполнены"); // TODO Shake bar
        },
        child: Text(
          AppTextStrings.addPlaceScreenPlaceCreateButton.toUpperCase(),
          style: AppTextStyles.addPlaceScreenPlaceCreateButton,
        ),
        style: _isFieldsFilled == true
            ? Theme.of(context).elevatedButtonTheme.style
            : Theme.of(context).elevatedButtonTheme.style.copyWith(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).backgroundColor,
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).disabledColor,
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(double.infinity, 48),
                  ),
                ),
      ),
    );
  }

  /// [_outlinedTextField] displays a text field with borders
  Widget _outlinedTextField({
    String hintText,
    int maxLines,
    TextEditingController controller,
    bool numberKeyboardType,
    FocusNode focusNode,
    FocusNode nextFocusNode,
    bool isLastField = false,
  }) {
    /// [_clearTextValue] clears the text field
    /// by clicking on the cross.
    void _clearTextValue() {
      context.read<AddPlace>().clearTextValue(controller);
    }

    return TextFormField(
      maxLines: maxLines ?? 1,
      controller: controller,
      keyboardType: numberKeyboardType == true
          ? TextInputType.number
          : TextInputType.text,
      onChanged: (String value) {
        context.read<AddPlace>().changeTextValue(controller, value);
      },
      textInputAction:
          isLastField == false ? TextInputAction.next : TextInputAction.done,
      focusNode: focusNode,
      onFieldSubmitted: (v) {
        focusNode.unfocus();
        if (!isLastField == true)
          FocusScope.of(context).requestFocus(nextFocusNode);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 16,
          right: 8,
        ),
        hintStyle: AppTextStyles.addPlaceScreenHint.copyWith(
          color: Theme.of(context).disabledColor,
        ),
        hintText: hintText,
        suffixIcon: Padding(
          padding: EdgeInsets.only(
            right: 14,
          ),
          child: controller.value.text.isNotEmpty
              ? InkWell(
                  onTap: () => _clearTextValue(),
                  child: SvgPicture.asset(
                    AppIcons.subtract,
                    color: Theme.of(context).iconTheme.color,
                  ),
                )
              : null,
        ),
        suffixIconConstraints: BoxConstraints(
          maxHeight: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).accentColor.withOpacity(0.4),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).accentColor.withOpacity(0.4),
            width: 2,
          ),
        ),
      ),
    );
  }

  /// Type of place
  Widget _placeType(
    TextEditingController _placeTypeController,
    _onSelectPlaceType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTextStrings.addPlaceScreenCategoryLabel.toUpperCase(),
          style: AppTextStyles.addPlaceScreenLabel.copyWith(
            color: Theme.of(context).disabledColor,
          ),
        ),
        InkWell(
          onTap: () => {},
          child: TextFormField(
            controller: _placeTypeController,
            readOnly: true,
            onTap: () => _onSelectPlaceType(),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 0,
              ),
              hintStyle: AppTextStyles.addPlaceScreenHint.copyWith(
                color: Theme.of(context).textTheme.caption.color,
              ),
              hintText: AppTextStrings.addPlaceScreenTextFormFieldNotSelected,
              suffixIcon: SvgPicture.asset(
                AppIcons.view,
                color: Theme.of(context).iconTheme.color,
              ),
              suffixIconConstraints: BoxConstraints(
                maxHeight: 24,
                maxWidth: 24,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).disabledColor.withOpacity(0.3),
                  width: 0.8,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).disabledColor.withOpacity(0.3),
                  width: 0.8,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Geolocation of the place
  Widget _placeGeolocation(
    TextEditingController _placeLatitudeController,
    TextEditingController _placeLongitudeController,
  ) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: [
          /// Latitude
          Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppTextStrings.addPlaceScreenPlaceLatitudeLabel
                        .toUpperCase(),
                    style: AppTextStyles.addPlaceScreenLabel.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                _outlinedTextField(
                  hintText:
                      AppTextStrings.addPlaceScreenTextFormFieldNotSpecified,
                  controller: _placeLatitudeController,
                  numberKeyboardType: true,
                  focusNode: context.watch<AddPlace>().latitudeFieldFocusNode,
                  nextFocusNode:
                      context.watch<AddPlace>().longitideFieldFocusNode,
                ),
              ],
            ),
          ),

          const SizedBox(
            width: 16,
          ),

          /// Longitude
          Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppTextStrings.addPlaceScreenPlaceLongitudeLabel
                        .toUpperCase(),
                    style: AppTextStyles.addPlaceScreenLabel.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                _outlinedTextField(
                  hintText:
                      AppTextStrings.addPlaceScreenTextFormFieldNotSpecified,
                  controller: _placeLongitudeController,
                  numberKeyboardType: true,
                  focusNode: context.watch<AddPlace>().longitideFieldFocusNode,
                  nextFocusNode:
                      context.watch<AddPlace>().detailsFieldFocusNode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Specify coordinates of place on the map
  Widget _specifyCoordinatesOnMap() {
    return InkWell(
      onTap: () => print("Указать на карте"),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 3,
          bottom: 2,
        ),
        child: Text(
          AppTextStrings.addPlaceScreenPlaceSpecifyCoordinates,
          style: AppTextStyles.addPlaceScreenPlaceSpecifyCoordinatesButton
              .copyWith(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }

  Widget _photogallery(List _placePhotogallery) {
    /// Dialog box with options for adding a photo
    void _addPlacePhoto() {
      showDialog(
        context: context,
        builder: (_) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: _addPlacePhotoDialog(),
            ),
          );
        },
        barrierColor: Theme.of(context).dialogBackgroundColor,
      );
    }

    ///  Delete a photo from the gallery
    void _deletePlacePhoto(index) {
      context.read<AddPlace>().deletePlacePhoto(index);
    }

    return CustomListViewBuilder(
      scrollDirection: Axis.horizontal,
      additionalPadding: false,
      children: [
        Container(
          width: 72,
          height: 72,
          margin: EdgeInsets.only(left: 16),
          child: Ink(
            decoration:
                AppDecorations.addPlaceScreenGalleryPrimaryElement.copyWith(
              border: Border.all(
                color: Theme.of(context).accentColor.withOpacity(0.48),
              ),
            ),
            child: GestureDetector(
              onTap: () => _addPlacePhoto(),
              child: SvgPicture.asset(
                AppIcons.union,
                color: Theme.of(context).accentColor,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
        for (int i = 0; i < _placePhotogallery.length; i++)
          Row(
            children: [
              const SizedBox(width: 16),
              Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.vertical,
                onDismissed: (direction) => _deletePlacePhoto(i),
                background: Align(
                  alignment: Alignment.bottomCenter,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: SvgPicture.asset(
                      AppIcons.view,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                child: GestureDetector(
                  onTap: () => print("Нажатие на карточку с индексом $i"),
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: AppDecorations
                        .addPlaceScreenGallerySecondaryElement
                        .copyWith(
                      color: Theme.of(context).accentColor.withOpacity(.70),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 6,
                          right: 6,
                          child: InkWell(
                            onTap: () => _deletePlacePhoto(i),
                            child: SvgPicture.asset(
                              AppIcons.subtract,
                              color: Theme.of(context)
                                  .colorScheme
                                  .addPlaceScreenPhotoDeleteButton,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }

  /// Custom implementation of the [AlertDialog] widget
  Widget _addPlacePhotoDialog() {
    // Function for closing the window
    void _closeDialog() {
      Navigator.of(context).pop();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: AppDecorations.addPhotoDialog.copyWith(
            color: Theme.of(context).backgroundColor,
          ),
          child: Column(
            children: [
              _dialogActionButton(
                  icon: AppIcons.camera,
                  title:
                      AppTextStrings.addPlaceScreenAddPhotoDialogButtonCamera),
              _dialogActionButton(
                  icon: AppIcons.photo,
                  title:
                      AppTextStrings.addPlaceScreenAddPhotoDialogButtonPhoto),
              _dialogActionButton(
                icon: AppIcons.file,
                title: AppTextStrings.addPlaceScreenAddPhotoDialogButtonFile,
                isShowDivider: false,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextButton(
          onPressed: () => _closeDialog(),
          child: Text(
            AppTextStrings.addPlaceScreenAddPhotoDialogCancelButton
                .toUpperCase(),
            style: AppTextStyles.addPlaceScreenPhotoDialogCancelButton.copyWith(
              color: Theme.of(context).accentColor,
            ),
          ),
          style: Theme.of(context).textButtonTheme.style.copyWith(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).backgroundColor,
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).accentColor,
                ),
                elevation: MaterialStateProperty.all<double>(0),
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(double.infinity, 48),
                ),
              ),
        ),
      ],
    );
  }

  /// Action button for [_addPlacePhotoDialog].
  /// [Icon] - path to the svg icon.
  /// [Title] - text for the button.
  /// [isShowDivider] - whether to show the separator.
  Widget _dialogActionButton({
    @required String icon,
    @required String title,
    bool isShowDivider = true,
  }) {
    return Column(
      children: [
        TextButton(
          onPressed: () => print(title),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 24,
                height: 24,
                color: Theme.of(context).textTheme.caption.color,
              ),
              SizedBox(width: 12),
              Text(
                title,
                style:
                    AppTextStyles.addPlaceScreenPhotoDialogTextButtons.copyWith(
                  color: Theme.of(context).textTheme.caption.color,
                ),
              ),
            ],
          ),
          style: Theme.of(context).textButtonTheme.style.copyWith(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).backgroundColor,
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).accentColor,
                ),
                elevation: MaterialStateProperty.all<double>(0),
              ),
        ),
        if (isShowDivider)
          Divider(
            color: Theme.of(context).disabledColor,
            indent: 0,
            endIndent: 0,
            height: 1,
          ),
      ],
    );
  }
}
