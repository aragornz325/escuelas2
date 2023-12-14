class MissingFullResponsiveApp extends Error {
  /// Thrown when a [FullResponsiveApp] is not found in the widget tree.
  /// Ensure you include a [FullResponsiveApp] in your main app declaration,
  /// normally on the same level as the [MaterialApp].
  MissingFullResponsiveApp();
}
