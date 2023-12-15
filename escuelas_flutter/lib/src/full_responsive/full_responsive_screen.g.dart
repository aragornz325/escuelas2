// +------------------------------------------+
// |  GENERATED CODE - DO NOT MODIFY BY HAND  |
// +------------------------------------------+

// ignore_for_file: implementation_imports
import 'package:flutter/material.dart';
import 'package:full_responsive/src/widgets/full_responsive_resolution.dart';
import 'package:full_responsive/src/widgets/full_responsive_screen_base.dart';

import 'full_responsive_app.g.dart';

class FullResponsiveScreen extends FullResponsiveScreenBase<FullResponsiveApp> {
  const FullResponsiveScreen({
    required this.celular,
    required this.escritorio,
    super.orientationsOverrides,
    super.resolutionsOverrides,
    super.key,
  });

  /// The widget to render when the screen size is suitable for 390x844
  final Widget celular;

  /// The widget to render when the screen size is suitable for 1280x832
  final Widget escritorio;

  @override
  Widget? resolutionToWidgetMapper(FullResponsiveResolution resolution) {
    switch (resolution.name) {
      case 'celular':
        return celular;
      case 'escritorio':
        return escritorio;
    }
    return null;
  }
}
