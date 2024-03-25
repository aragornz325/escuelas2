extension StringX on String {
  String get capitalize =>
      isEmpty ? this : this[0].toUpperCase() + substring(1);

  /// Devuelve el nombre del item spliteado desde el ';'.
  List<String>? splitNombre() {
    if (contains(';')) {
      final parts = split(';');

      return parts;
    }

    return null;
  }
}
