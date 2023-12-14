class FullResponsiveResolution {
  const FullResponsiveResolution(this.name, this.width, this.height,
      {this.nullable = false, int? breakpoint})
      : ratio = width / height,
        isLandscape = width > height,
        // ignore: unnecessary_this
        this.breakpoint = breakpoint ?? (width > height ? height : width);

  final String name;
  final int width;
  final int height;
  final int breakpoint;
  final double ratio;
  final bool nullable;
  final bool isLandscape;

  @override
  String toString() => 'Resolution: $name ($width x $height)';

  @override
  int get hashCode => width * 10000 + height;

  @override
  bool operator ==(Object other) {
    if (other is FullResponsiveResolution) {
      return other.width == width && other.height == height;
    }
    return false;
  }
}
