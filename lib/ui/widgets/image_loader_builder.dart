import 'package:flutter/material.dart';

Widget imageLoaderBuilder(
    BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
  if (loadingProgress == null) return child;
  return Align(
    alignment: AlignmentDirectional.bottomCenter,
    child: LinearProgressIndicator(
      minHeight: 8.0,
    ),
  );
}

Widget imageErrorBuilder(context, error, stackTrace) => Container(
      color: Colors.grey,
    );
