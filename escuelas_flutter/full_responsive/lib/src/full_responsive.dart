import 'package:flutter/material.dart';

import 'widgets/full_responsive_resolution.dart';

/// A helper class for creating a responsive layout with the currently used
/// resolution
class FullResponsive {
  FullResponsive._();
  factory FullResponsive() {
    _singleton ??= FullResponsive._();
    return _singleton!;
  }

  static FullResponsive? _singleton;

  // ignore: unused_field
  Orientation _orientation = Orientation.portrait;
  double _height = 1;
  double _width = 1;
  FullResponsiveResolution _resolution = FullResponsiveResolution('null', 1, 1);

  void reset(Orientation orientation, double height, double width, FullResponsiveResolution resolution) {
    _orientation = orientation;
    _height = height;
    _width = width;
    _resolution = resolution;
  }

  double proportionalHeight(num num) => num / _resolution.height * _height;

  double proportionalWidth(num num) => num / _resolution.width * _width;

  double percentageHeight(num num) {
    assert(num >= 0 && num <= 100,
        'The percentage for .ph/.percentageHeight must be between 0 and 100 ($num.ph provided)');
    return (num * _height) / 100;
  }

  double percentageWidth(num num) {
    assert(
        num >= 0 && num <= 100, 'The percentage for .pw/.percentageWidth must be between 0 and 100 ($num.pw provided)');
    return (num * _width) / 100;
  }
}
