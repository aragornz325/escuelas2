import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:full_responsive/src/widgets/full_responsive_resolution.dart';

abstract class FullResponsiveAppBase extends InheritedWidget {
  FullResponsiveAppBase({required super.child, super.key});

  List<FullResponsiveResolution> get resolutions;

  @override
  bool updateShouldNotify(FullResponsiveAppBase oldWidget) {
    return listEquals(resolutions, oldWidget.resolutions) == false;
  }
}
