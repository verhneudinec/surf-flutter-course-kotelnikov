import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/models/add_sight.dart';
import 'package:places/models/sights.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/localization.dart';
import 'package:places/res/text_styles.dart';
import 'package:places/res/themes.dart';
import 'package:places/res/icons.dart';
import 'package:places/ui/widgets/app_bar_custom.dart';
import 'package:provider/provider.dart';

/// Screen for adding and editing a place
/// State is controlled by [AddSight]
class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key key}) : super(key: key);

  @override
  _AddSightScreenState createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  @override
  Widget build(BuildContext context) {
    /// [_isFieldsFilled] check for filling in all fields.
    /// The "Save" button becomes active when this field is true.
    bool _isFieldsFilled = context.watch<AddSight>().isFieldsFilled;

    /// [_onSightCreate] takes the prepared data of the new
    /// sight from [AddSight] and writes them to
    /// array of mock data from [Sights].
    void _onSightCreate() {
      Sight _newSight = context.read<AddSight>().prepareNewSight();
      context.read<Sights>().addSight(_newSight);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            _body(),
          ],
        ),
      ),
      bottomNavigationBar: _createSightButton(
        _isFieldsFilled,
        _onSightCreate,
      ),
    );
  }

  Widget _header() {
    return AppBarCustom(
      title: AppTextStrings.addSightScreenTitle,
      cancelButtonEnabled: true,
    );
  }

  Widget _body() {
    /// Controllers for text fields
    final TextEditingController _sightTypeController =
            context.watch<AddSight>().sightTypeController,
        _sightNameController = context.watch<AddSight>().sightNameController,
        _sightLatitudeController =
            context.watch<AddSight>().sightLatitudeController,
        _sightLongitudeController =
            context.watch<AddSight>().sightLongitudeController,
        _sightDescriptionController =
            context.watch<AddSight>().sightDescriptionController;

    /// Photogallery of the place
    List _sightPhotogallery = context.watch<AddSight>().sightPhotogallery;

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          _photogallery(_sightPhotogallery),
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
                _sightType(_sightTypeController),

                const SizedBox(
                  height: 24,
                ),

                /// Sight name
                Text(
                  AppTextStrings.addSightScreenSightNameLabel.toUpperCase(),
                  style: AppTextStyles.addSightScreenLabel.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                _outlinedTextField(
                  hintText: AppTextStrings.addSightScreenTextFormFieldEmpty,
                  controller: _sightNameController,
                  focusNode: context.watch<AddSight>().nameFieldFocusNode,
                  nextFocusNode:
                      context.watch<AddSight>().latitudeFieldFocusNode,
                ),

                const SizedBox(
                  height: 24,
                ),

                _sightGeolocation(
                  _sightLatitudeController,
                  _sightLongitudeController,
                ),

                const SizedBox(
                  height: 12,
                ),

                _specifyCoordinatesOnMap(),

                const SizedBox(
                  height: 35,
                ),

                Text(
                  AppTextStrings.addSightScreenSightDescriptionLabel
                      .toUpperCase(),
                  style: AppTextStyles.addSightScreenLabel.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                _outlinedTextField(
                  hintText: AppTextStrings.addSightScreenTextFormFieldEmpty,
                  maxLines: 4,
                  focusNode: context.watch<AddSight>().detailsFieldFocusNode,
                  controller: _sightDescriptionController,
                  nextFocusNode:
                      context.watch<AddSight>().detailsFieldFocusNode,
                  isLastField: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// "Add a new sight" button
  Widget _createSightButton(bool _isFieldsFilled, _onSightCreate) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: TextButton(
        onPressed: () {
          if (_isFieldsFilled == true)
            _onSightCreate();
          else
            print("Не все поля заполнены"); // TODO Shake bar
        },
        child: Text(
          AppTextStrings.addSightScreenSightCreateButton.toUpperCase(),
          style: AppTextStyles.addSightScreenSightCreateButton,
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
      context.read<AddSight>().clearTextValue(controller);
    }

    return TextFormField(
      maxLines: maxLines ?? 1,
      controller: controller,
      keyboardType: numberKeyboardType == true
          ? TextInputType.number
          : TextInputType.text,
      onChanged: (String value) {
        context.read<AddSight>().changeTextValue(controller, value);
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
        hintStyle: AppTextStyles.addSightScreenHint.copyWith(
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

  /// Type of sight
  Widget _sightType(
    TextEditingController _sightTypeController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTextStrings.addSightScreenCategoryLabel.toUpperCase(),
          style: AppTextStyles.addSightScreenLabel.copyWith(
            color: Theme.of(context).disabledColor,
          ),
        ),
        InkWell(
          onTap: () => {},
          child: TextFormField(
            controller: _sightTypeController,
            readOnly: true,
            onTap: () => print("Выбор категории"),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 0,
              ),
              hintStyle: AppTextStyles.addSightScreenHint.copyWith(
                color: Theme.of(context).textTheme.caption.color,
              ),
              hintText: AppTextStrings.addSightScreenTextFormFieldNotSelected,
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

  /// Geolocation of the sight
  Widget _sightGeolocation(
    TextEditingController _sightLatitudeController,
    TextEditingController _sightLongitudeController,
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
                    AppTextStrings.addSightScreenSightLatitudeLabel
                        .toUpperCase(),
                    style: AppTextStyles.addSightScreenLabel.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                _outlinedTextField(
                  hintText:
                      AppTextStrings.addSightScreenTextFormFieldNotSpecified,
                  controller: _sightLatitudeController,
                  numberKeyboardType: true,
                  focusNode: context.watch<AddSight>().latitudeFieldFocusNode,
                  nextFocusNode:
                      context.watch<AddSight>().longitideFieldFocusNode,
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
                    AppTextStrings.addSightScreenSightLongitudeLabel
                        .toUpperCase(),
                    style: AppTextStyles.addSightScreenLabel.copyWith(
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                _outlinedTextField(
                  hintText:
                      AppTextStrings.addSightScreenTextFormFieldNotSpecified,
                  controller: _sightLongitudeController,
                  numberKeyboardType: true,
                  focusNode: context.watch<AddSight>().longitideFieldFocusNode,
                  nextFocusNode:
                      context.watch<AddSight>().detailsFieldFocusNode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Specify coordinates of sight on the map
  Widget _specifyCoordinatesOnMap() {
    return InkWell(
      onTap: () => print("Указать на карте"),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 3,
          bottom: 2,
        ),
        child: Text(
          AppTextStrings.addSightScreenSightSpecifyCoordinates,
          style: AppTextStyles.addSightScreenSightSpecifyCoordinatesButton
              .copyWith(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }

  Widget _photogallery(List _sightPhotogallery) {
    /// Add a photo to the gallery
    void _addSightPhoto() {
      context.read<AddSight>().addSightPhoto();
    }

    ///  Delete a photo from the gallery
    void _deleteSightPhoto(index) {
      context.read<AddSight>().deleteSightPhoto(index);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 72,
            height: 72,
            margin: EdgeInsets.only(left: 16),
            child: Ink(
              decoration:
                  AppDecorations.addSightScreenGalleryPrimaryElement.copyWith(
                border: Border.all(
                  color: Theme.of(context).accentColor.withOpacity(0.48),
                ),
              ),
              child: GestureDetector(
                onTap: () => _addSightPhoto(),
                child: SvgPicture.asset(
                  AppIcons.union,
                  color: Theme.of(context).accentColor,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          for (int i = 0; i < _sightPhotogallery.length; i++)
            Row(
              children: [
                const SizedBox(width: 16),
                Dismissible(
                  direction: DismissDirection.vertical,
                  onDismissed: (direction) => _deleteSightPhoto(i),
                  key: UniqueKey(),
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
                          .addSightScreenGallerySecondaryElement
                          .copyWith(
                        color: Theme.of(context).accentColor.withOpacity(.70),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 6,
                            right: 6,
                            child: InkWell(
                              onTap: () => _deleteSightPhoto(i),
                              child: SvgPicture.asset(
                                AppIcons.subtract,
                                color: Theme.of(context)
                                    .colorScheme
                                    .addSightScreenPhotoDeleteButton,
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
      ),
    );
  }
}
