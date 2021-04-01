import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/res/decorations.dart';
import 'package:places/res/text_strings.dart';
import 'package:places/res/text_styles.dart';

/// Выводит пикер даты в зависимости от плафтомы
Future<DateTime> showPlatformDatePicker(
  BuildContext context, {
  bool isIos = false,
}) async {
  DateTime currentDate = DateTime.now();
  return isIos
      ? showDialog(
          context: context,
          builder: (context) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: _cupertinoDatePicker(context, currentDate),
              ),
            );
          })
      : showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: currentDate,
          lastDate: currentDate.add(
            Duration(days: 365 * 10),
          ),
          helpText: AppTextStrings.datePickerHelpText,
          confirmText: AppTextStrings.datePickerConfrimText,
          cancelText: AppTextStrings.datePickerCancelText,
          builder: (_, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                dialogBackgroundColor: Theme.of(context).backgroundColor,
              ),
              child: child,
            );
          },
        );
}

/// Modal window for date picker in Cupertino style
Widget _cupertinoDatePicker(
  BuildContext context,
  DateTime currentDate,
) {
  DateTime scheduledDate;

  // Function for closing the window
  void onDateTimeSubmitted() {
    Navigator.of(context).pop(scheduledDate);
  }

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      LimitedBox(
        maxHeight: 300,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: AppDecorations.addPhotoDialog.copyWith(
            color: Theme.of(context).backgroundColor,
          ),
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: currentDate,
            maximumDate: currentDate.add(Duration(days: 365 * 10)),
            minimumDate: currentDate,
            onDateTimeChanged: (date) => scheduledDate = date,
          ),
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      TextButton(
        onPressed: () => onDateTimeSubmitted(),
        child: Text(
          AppTextStrings.datePickerConfrimText.toUpperCase(),
          style: AppTextStyles.favoritesScreenDatePickerConfrimButton.copyWith(
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
