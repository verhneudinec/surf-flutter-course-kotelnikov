import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';

/// State for screen [AddPlaceScreen].
class AddPlace with ChangeNotifier {
  /// Controllers for text fields.
  final TextEditingController _placeTypeController = TextEditingController(),
      _placeNameController = TextEditingController(),
      _placeLatitudeController = TextEditingController(),
      _placeLongitudeController = TextEditingController(),
      _placeDescriptionController = TextEditingController();

  /// Photogallery of the place
  List<String> _placePhotogallery = [];

  /// Fullness of text fields.
  bool _isFieldsFilled = false;

  /// FocusNodes for the corresponding text fields.
  final FocusNode _nameFieldFocusNode = FocusNode(),
      _latitudeFieldFocusNode = FocusNode(),
      _longitideFieldFocusNode = FocusNode(),
      _detailsFieldFocusNode = FocusNode();

  /// Getters for text field controllers.
  TextEditingController get placeTypeController => _placeTypeController;
  TextEditingController get placeNameController => _placeNameController;
  TextEditingController get placeLatitudeController => _placeLatitudeController;
  TextEditingController get placeLongitudeController =>
      _placeLongitudeController;
  TextEditingController get placeDescriptionController =>
      _placeDescriptionController;

  /// Photogallery of the place
  List<String> get placePhotogallery => _placePhotogallery;

  /// Fullness of text fields.
  bool get isFieldsFilled => _isFieldsFilled;

  /// FocusNodes for the corresponding text field nodes.
  FocusNode get nameFieldFocusNode => _nameFieldFocusNode;
  FocusNode get latitudeFieldFocusNode => _latitudeFieldFocusNode;
  FocusNode get longitideFieldFocusNode => _longitideFieldFocusNode;
  FocusNode get detailsFieldFocusNode => _detailsFieldFocusNode;

  /// The function is called whenever the text field changes.
  /// Checks if all fields are filled and writes the value to [_isFieldsFilled].
  void changeTextValue(controller, value) {
    if (_placeNameController.text.isNotEmpty &&
        _placeLongitudeController.text.isNotEmpty &&
        _placeLatitudeController.text.isNotEmpty &&
        _placeDescriptionController.text.isNotEmpty) {
      _isFieldsFilled = true;
    }

    notifyListeners();
  }

  /// Function to clear the text field.
  void clearTextValue(TextEditingController controller) {
    controller.clear();
    notifyListeners();
  }

  /// Add a photo to the gallery
  void addPlacePhoto() {
    // We don't know how to work with photos yet,
    // so just add a new number to the array.
    _placePhotogallery.add(_placePhotogallery.length.toString());
    notifyListeners();
  }

  /// Delete a photo from the gallery
  void deletePlacePhoto(int placePhotoIndex) {
    _placePhotogallery.removeAt(placePhotoIndex);
    notifyListeners();
  }

  /// A function for preparing the data of the new [Place] object.
  Place prepareNewPlace() {
    final Place _newPlace = Place(
      name: _placeNameController.text,
      lat: double.tryParse(_placeLatitudeController.text),
      lng: double.tryParse(_placeLongitudeController.text),
      urls: ["https://i.ytimg.com/vi/OCQFglqRqJo/maxresdefault.jpg"],
      description: _placeDescriptionController.text,
      placeType: _placeTypeController.text,
    );
    return _newPlace;
  }
}
