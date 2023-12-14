String fullResponsiveScreenWidgetMustachexTemplate = '''
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
      {{#resolutions}}
      {{#hasNullable}}{{^nullable}}required {{/nullable}}{{/hasNullable}}{{^hasNullable}}required {{/hasNullable}}this.{{name}},
      {{/resolutions}}
      super.orientationsOverrides,
      super.resolutionsOverrides,
      super.key});

  {{#resolutions}}
  /// The widget to render when the screen size is suitable for {{width}}x{{height}}
  final Widget{{#hasNullable}}{{#nullable}}?{{/nullable}}{{/hasNullable}} {{name}};
  {{/resolutions}}

  @override
  Widget? resolutionToWidgetMapper(FullResponsiveResolution resolution) {
    switch (resolution.name) {
      {{#resolutions}}
      case '{{name}}':
        return {{name}};
      {{/resolutions}}
    }
    return null;
  }
}

''';
