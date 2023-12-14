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
        FullResponsiveResolution('mobile', 390, 844),
        FullResponsiveResolution('mobileLandscape', 844, 390),
        FullResponsiveResolution('tablet', 1024, 1350,
            nullable: true, breakpoint: 600),
        FullResponsiveResolution('tabletLandscape', 1350, 1024,
            nullable: true, breakpoint: 500),
        FullResponsiveResolution('desktop', 1620, 740, nullable: true),
      ];
}
