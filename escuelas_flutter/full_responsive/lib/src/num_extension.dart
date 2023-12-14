import 'package:full_responsive/src/full_responsive.dart';

/// A extension to `num` that provides a method to convert a number to a
/// FullResponsive's compliant Liquid/fluid design units.
extension NumExtension on num {
  /// Proportional Height: Get a proportional value with relation to the original [FullResponsiveResolution]
  /// used and the current screen height
  double get ph => FullResponsive().proportionalHeight(this);

  /// Get a proportional value with relation to the original [FullResponsiveResolution]
  /// used and the current screen height
  double get proportionalHeight => FullResponsive().proportionalHeight(this);

  /// Proportional Width: Get a proportional value with relation to the original [FullResponsiveResolution]
  /// used and the current screen width
  double get pw => FullResponsive().proportionalWidth(this);

  /// Get a proportional value with relation to the original [FullResponsiveResolution]
  /// used and the current screen width
  double get proportionalWidth => FullResponsive().proportionalWidth(this);

  /// Static Height: Mark the current number as a static height value that don't changes
  /// on screen size changes
  double get sh => toDouble();

  /// Mark the current number as a static height value that don't changes
  /// on screen size changes
  double get staticHeight => toDouble();

  /// Static Width: Mark the current number as a static width value that don't changes
  /// on screen size changes
  double get sw => toDouble();

  /// Mark the current number as a static width value that don't changes
  /// on screen size changes
  double get staticWidth => toDouble();

  /// Proportional Font Size: The font size will adapt to the current screen size
  /// Syntactic sugar for applying the same logic of .pw but for fonts
  /// (use always this approach though: maybe in a future the algorithm changes)

  // TODO(anyone): Arreglar getter
  // double get pf => FullResponsive().proportionalWidth(this);
  double get pf => toDouble();

  /// Static Font Size: The font size won't change no matter the current screen size
  /// Syntactic sugar for applying the same logic of .sw but for fonts
  /// (use always this approach though: maybe in a future the algorithm changes)
  double get sf => toDouble();

  /// Height Percentage: Get the current screen height size equivalent to the given percentage
  double get hp => FullResponsive().percentageHeight(this);

  /// Height Percentage: Get the current screen height size equivalent to the given percentage
  double get heightPercentage => FullResponsive().percentageHeight(this);

  /// Width Percentage: Get the current screen width size equivalent to the given percentage
  double get wp => FullResponsive().percentageWidth(this);

  /// Width Percentage: Get the current screen width size equivalent to the given percentage
  double get widthPercentage => FullResponsive().percentageWidth(this);
}
