class MalformedPubspecYaml extends Error {
  /// Thrown when the `pubspec.yaml` file contents throws parsing errors.
  MalformedPubspecYaml();

  @override
  String toString() =>
      "The parsing of pubspec.yaml file failed. Make sure it's valid YAML.";
}
