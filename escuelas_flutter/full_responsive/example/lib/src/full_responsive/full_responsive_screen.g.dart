// +------------------------------------------+
// |  GENERATED CODE - DO NOT MODIFY BY HAND  |
// +------------------------------------------+

// ignore_for_file: implementation_imports
import 'package:flutter/material.dart';
import 'package:full_responsive/src/widgets/full_responsive_resolution.dart';
import 'package:full_responsive/src/widgets/full_responsive_screen_base.dart';

import 'full_responsive_app.g.dart';

class FullResponsiveScreen extends FullResponsiveScreenBase<FullResponsiveApp> {
  const FullResponsiveScreen(
      {required this.mobile,
      required this.mobileLandscape,
      this.tablet,
      this.tabletLandscape,
      this.desktop,
      super.orientationsOverrides,
      super.resolutionsOverrides,
      super.key});

  /// The widget to render when the screen size is suitable for 390x844
  final Widget mobile;

  /// The widget to render when the screen size is suitable for 844x390
  final Widget mobileLandscape;

  /// The widget to render when the screen size is suitable for 1024x1350
  final Widget? tablet;

  /// The widget to render when the screen size is suitable for 1350x1024
  final Widget? tabletLandscape;

  /// The widget to render when the screen size is suitable for 1620x740
  final Widget? desktop;

  @override
  Widget? resolutionToWidgetMapper(FullResponsiveResolution resolution) {
    switch (resolution.name) {
      case 'mobile':
        return mobile;
      case 'mobileLandscape':
        return mobileLandscape;
      case 'tablet':
        return tablet;
      case 'tabletLandscape':
        return tabletLandscape;
      case 'desktop':
        return desktop;
    }
    return null;
  }
}
