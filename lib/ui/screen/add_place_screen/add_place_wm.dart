import 'dart:io';
import 'package:flutter/material.dart' hide Action;
import 'package:image_picker/image_picker.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:relation/relation.dart';

/// Add place screen's widget model
class AddPlaceWidgetModel extends WidgetModel {
  final PlacesInteractor placesInteractor;
  final NavigatorState navigator;

  AddPlaceWidgetModel(
    WidgetModelDependencies baseDependencies,
    this.placesInteractor,
    this.navigator,
  ) : super(baseDependencies);

  /// --------------------------- ///
  /// ------- Fields of WM ------ ///
  /// --------------------------- ///

  /// Controllers for text fields.
  final TextEditingAction placeTypeAction = TextEditingAction(),
      placeNameAction = TextEditingAction(),
      placeLatitudeAction = TextEditingAction(),
      placeLongitudeAction = TextEditingAction(),
      placeDescriptionAction = TextEditingAction();

  /// FocusNodes for the corresponding text fields.
  final FocusNode nameFieldFocusNode = FocusNode(),
      latitudeFieldFocusNode = FocusNode(),
      longitideFieldFocusNode = FocusNode(),
      detailsFieldFocusNode = FocusNode();

  /// --------------------------- ///
  /// ----- Streamed states ----- ///
  /// --------------------------- ///

  /// Are all fields filled
  final StreamedState<bool> isFieldsFilled = StreamedState(false);

  /// Photogallery of the place
  final EntityStreamedState<List<File>> placePhotogallery =
      EntityStreamedState();

  /// ------------------------- ///
  /// ----------- WM ---------- ///
  /// ------------------------- ///

  @override
  void onLoad() {
    placePhotogallery.content([]);
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();

    subscribeHandleError(addPlaceAction.stream, (t) {
      _addPlace();
      navigator.pop();
    }).onError(handleError);

    subscribe(checkFieldsFilledAction.stream, (_) => _checkFieldsFilled());

    subscribe(
      addPlacePhotoAction.stream,
      (isGetFromCamera) =>
          isGetFromCamera ? _addPhotoFromCamera() : _addPhotoFromGallery(),
    );

    subscribe(deletePlacePhotoAction.stream,
        (placePhotoIndex) => _deletePlacePhoto(placePhotoIndex));
  }

  @override
  void dispose() {
    placeNameAction.dispose();

    super.dispose();
  }

  /// --------------------------- ///
  /// --------- Actions --------- ///
  /// --------------------------- ///

  /// Add place action
  final addPlaceAction = Action<void>();

  /// Action to check if all fields are complete
  final checkFieldsFilledAction = Action<void>();

  /// Action to adding photo to gallery
  final addPlacePhotoAction = Action<void>();

  /// Action to remove photo from gallery
  final deletePlacePhotoAction = Action<void>();

  /// --------------------------- ///
  /// ---- Functions for WM ----- ///
  /// --------------------------- ///

  /// Checks if all fields are filled and writes the value to [_isFieldsFilled].
  void _checkFieldsFilled() {
    bool isAllFieldsIsNotEmpty = placeNameAction.controller.text.isNotEmpty &&
        placeLongitudeAction.controller.text.isNotEmpty &&
        placeLatitudeAction.controller.text.isNotEmpty &&
        placeDescriptionAction.controller.value.text.isNotEmpty;

    isFieldsFilled.accept(isAllFieldsIsNotEmpty);
  }

  /// Function to add a new place
  Future<void> _addPlace() async {
    final Place newPlace = await _prepareNewPlace();
    placesInteractor.addNewPlace(newPlace);
  }

  /// A function for preparing the data of the new [Place] object.
  Future<Place> _prepareNewPlace() async {
    /// List of paths to images on the server
    List<String> photoUrls = [];

    /// Upload pictures to the server and add everything to [photoUrls].
    for (final File placePhoto in placePhotogallery.value.data) {
      final String photoUrl = await placesInteractor.uploadPhoto(placePhoto);
      photoUrls.add(photoUrl);
    }

    /// Prepare a place with all fields
    final Place newPlace = Place(
      name: placeNameAction.controller.text,
      lat: double.tryParse(placeLatitudeAction.controller.text),
      lng: double.tryParse(placeLongitudeAction.controller.text),
      urls: photoUrls,
      description: placeDescriptionAction.controller.text,
      placeType: placeTypeAction.controller.text,
    );

    return newPlace;
  }

  /// Adding a photo to the gallery from the explorer
  Future<void> _addPhotoFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      placePhotogallery.content(
        placePhotogallery.value.data..add(imageFile),
      );
    }
  }

  /// Adding photos to the gallery using the camera
  Future<void> _addPhotoFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      placePhotogallery.content(
        placePhotogallery.value.data..add(imageFile),
      );
    }
  }

  /// Delete a photo from the gallery
  void _deletePlacePhoto(int placePhotoIndex) {
    placePhotogallery.content(
      List<File>.from(placePhotogallery.stateSubject.value.data)
        ..removeAt(placePhotoIndex),
    );
  }
}
