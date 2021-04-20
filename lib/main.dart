import 'package:flutter/material.dart';
import 'package:places/app.dart';
import 'package:places/environment/build_config.dart';
import 'package:places/environment/build_type.dart';
import 'package:places/environment/environment.dart';

void main() {
  _defineEnvironment(
    buildConfig: _setupConfig(),
  );

  runApp(App());
}

void _defineEnvironment({BuildConfig buildConfig}) {
  Environment.init(
    buildConfig: buildConfig,
    buildType: BuildType.dev,
  );
}

BuildConfig _setupConfig() {
  return BuildConfig(
    envString: "Launched in debug mode ",
  );
}
