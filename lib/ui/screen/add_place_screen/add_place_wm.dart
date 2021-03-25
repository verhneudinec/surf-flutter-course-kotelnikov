import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactor/places_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:relation/relation.dart';

/// Add place screen's widget model
class AddPlaceWidgetModel extends WidgetModel {
  final addPlaceState = EntityStreamedState<Place>();
  final PlacesInteractor placesInteractor;
  final NavigatorState navigator;

  AddPlaceWidgetModel(
    WidgetModelDependencies baseDependencies,
    this.placesInteractor,
    this.navigator,
  ) : super(baseDependencies);

  @override
  void onLoad() {
    addPlaceState.content(Place());
    super.onLoad();
  }

  @override
  void onBind() {
    super.onBind();

    subscribe(addPlaceAction.stream, (_) {
      addPlaceState.loading();
      doFuture<bool>(
        addPlace(),
        (data) {
          navigator.pop();
        },
        onError: handleError,
      );
    });

    subscribe(checkFieldsFilledAction.stream, (_) {
      checkFieldsFilled();
    });
  }

  /// --------------------------- ///
  /// ------- Fields of WM ------ ///
  /// --------------------------- ///

  /// Controllers for text fields.
  final TextEditingController placeTypeController = TextEditingController(),
      placeNameController = TextEditingController(),
      placeLatitudeController = TextEditingController(),
      placeLongitudeController = TextEditingController(),
      placeDescriptionController = TextEditingController();

  /// Photogallery of the place
  List<String> placePhotogallery = [];

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

  /// --------------------------- ///
  /// --------- Actions --------- ///
  /// --------------------------- ///

  /// Add place action
  final addPlaceAction = Action<void>();

  /// Action to check if all fields are complete
  final checkFieldsFilledAction = Action<void>();

  /// --------------------------- ///
  /// ---- Functions for WM ----- ///
  /// --------------------------- ///

  /// Checks if all fields are filled and writes the value to [_isFieldsFilled].
  void checkFieldsFilled() {
    if (placeNameController.text.isNotEmpty &&
        placeLongitudeController.text.isNotEmpty &&
        placeLatitudeController.text.isNotEmpty &&
        placeDescriptionController.value.text.isNotEmpty) {
      isFieldsFilled.accept(true);
    }
  }

  /// Function to add a new location
  Future<bool> addPlace() async {
    addPlaceState.loading();

    final Place place = prepareNewPlace();

    subscribeHandleError(
      placesInteractor.addNewPlace(place).asStream(),
      (_) {
        addPlaceState.content(place);
      },
    ).onData((data) {
      return data;
    });
  }

  /// A function for preparing the data of the new [Place] object.
  Place prepareNewPlace() {
    final Place newPlace = Place(
      name: placeNameController.text,
      lat: double.tryParse(placeLatitudeController.text),
      lng: double.tryParse(placeLongitudeController.text),
      urls: ["https://i.ytimg.com/vi/OCQFglqRqJo/maxresdefault.jpg"],
      description: placeDescriptionController.value.text,
      placeType: placeTypeController.text,
    );
    return newPlace;
  }

  /// Function to clear the text field.
  void clearTextValue(TextEditingController controller) {
    controller.clear();
  }

  /// Add a photo to the gallery
  void addPlacePhoto() {
    // The function is empty for now
  }

  /// Delete a photo from the gallery
  void deletePlacePhoto(int placePhotoIndex) {
    placePhotogallery.removeAt(placePhotoIndex);
  }
}
