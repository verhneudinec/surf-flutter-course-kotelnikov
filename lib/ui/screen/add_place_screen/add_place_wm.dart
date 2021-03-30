import 'package:flutter/material.dart' hide Action;
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
  final EntityStreamedState<List<String>> placePhotogallery =
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

    subscribe(addPlacePhotoAction.stream, (_) => _addPlacePhoto());

    subscribe(deletePlacePhotoAction.stream,
        (placePhotoIndex) => _deletePlacePhoto(placePhotoIndex));
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

  /// Function to add a new location
  Future<void> _addPlace() async {
    final Place newPlace = _prepareNewPlace();
    await placesInteractor.addNewPlace(newPlace);
  }

  /// A function for preparing the data of the new [Place] object.
  Place _prepareNewPlace() {
    final Place newPlace = Place(
      name: placeNameAction.controller.text,
      lat: double.tryParse(placeLatitudeAction.controller.text),
      lng: double.tryParse(placeLongitudeAction.controller.text),
      urls: ["https://i.ytimg.com/vi/OCQFglqRqJo/maxresdefault.jpg"],
      description: placeDescriptionAction.controller.text,
      placeType: placeTypeAction.controller.text,
    );
    return newPlace;
  }

  /// Add a photo to the gallery
  void _addPlacePhoto() {
    placePhotogallery.content(
      List<String>.from(placePhotogallery.stateSubject.value.data)..add(' '),
    );
  }

  /// Delete a photo from the gallery
  void _deletePlacePhoto(int placePhotoIndex) {
    placePhotogallery.content(
      List<String>.from(placePhotogallery.stateSubject.value.data)
        ..removeAt(placePhotoIndex),
    );
  }
}
