String fullResponsiveAppWidgetMustachexTemplate = '''
// +------------------------------------------+
// |  GENERATED CODE - DO NOT MODIFY BY HAND  |
// +------------------------------------------+

// ignore_for_file: implementation_imports
import 'package:full_responsive/src/widgets/full_responsive_app_base.dart';
import 'package:full_responsive/src/widgets/full_responsive_resolution.dart';

class FullResponsiveApp extends FullResponsiveAppBase {
  FullResponsiveApp({required super.child, super.key});

  @override
  List<FullResponsiveResolution> get resolutions => const [
    {{#resolutions}}
    FullResponsiveResolution('{{name}}', {{width}}, {{height}}{{#hasNullable}}, nullable: {{nullable}}{{/hasNullable}}{{#hasBreakpoint}}, breakpoint: {{breakpoint}}{{/hasBreakpoint}}),
    {{/resolutions}}
      ];
}
''';
