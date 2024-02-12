Map<String, dynamic> extenderMap(
  Map<String, Map<String, dynamic>> mapaAnidado,
) {
  return mapaAnidado.values.fold(
      <String,dynamic>{},
      (Map<String, dynamic> acc, Map<String, dynamic> innerMap) =>
          acc..addAll(innerMap.map((key, value) => MapEntry(key, value))));
}
