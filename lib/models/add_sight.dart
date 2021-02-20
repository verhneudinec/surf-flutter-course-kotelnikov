import 'package:flutter/material.dart';
import 'package:places/domain/geo_position.dart';
import 'package:places/domain/sight.dart';

/// State for screen [AddSightScreen].
class AddSight with ChangeNotifier {
  /// Controllers for text fields.
  final _sightTypeController = TextEditingController(),
      _sightNameController = TextEditingController(),
      _sightLatitudeController = TextEditingController(),
      _sightLongitudeController = TextEditingController(),
      _sightDescriptionController = TextEditingController();

  /// Photogallery of the place
  List _sightPhotogallery = [];

  /// Fullness of text fields.
  bool _isFieldsFilled = false;

  /// FocusNodes for the corresponding text fields.
  final _nameFieldFocusNode = FocusNode(),
      _latitudeFieldFocusNode = FocusNode(),
      _longitideFieldFocusNode = FocusNode(),
      _detailsFieldFocusNode = FocusNode();

  /// Getters for text field controllers.
  TextEditingController get sightTypeController => _sightTypeController;
  TextEditingController get sightNameController => _sightNameController;
  TextEditingController get sightLatitudeController => _sightLatitudeController;
  TextEditingController get sightLongitudeController =>
      _sightLongitudeController;
  TextEditingController get sightDescriptionController =>
      _sightDescriptionController;

  /// Photogallery of the place
  List get sightPhotogallery => _sightPhotogallery;

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
    if (_sightNameController.text.isNotEmpty &&
        _sightLongitudeController.text.isNotEmpty &&
        _sightLatitudeController.text.isNotEmpty &&
        _sightDescriptionController.text.isNotEmpty) {
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
  void addSightPhoto() {
    _sightPhotogallery.add(_sightPhotogallery.length);
    notifyListeners();
  }

  /// Delete a photo from the gallery
  void deleteSightPhoto(int sightPhotoIndex) {
    _sightPhotogallery.removeAt(sightPhotoIndex);
    notifyListeners();
  }

  /// A function for preparing the data of the new [Sight] object.
  Sight prepareNewSight() {
    final _newSight = Sight(
      _sightNameController.text,
      GeoPosition(
        double.tryParse(_sightLatitudeController.text),
        double.tryParse(_sightLongitudeController.text),
      ),
      "https://melbourneartcritic.files.wordpress.com/2018/06/fullsizeoutput_62.jpeg",
      _sightDescriptionController.text,
      _sightTypeController.text,
      "открыто до 20:00",
      false,
    );
    return _newSight;
  }
}
