/// Calcula el promedio de una lista de calificaciones con la posibilidad de
/// pasarle una nota mas
double calcularPromedio(
  List<double> listaCalificaciones, [
  double? calificacionAparte,
]) {
  // Filtrar las notas 0
  final notasFiltradas =
      listaCalificaciones.where((nota) => nota != 0).toList();

  // Si hay una nota aparte, agregarla a la lista
  if (calificacionAparte != null && calificacionAparte != 0) {
    notasFiltradas.add(calificacionAparte);
  }

  // Calcular el promedio
  if (notasFiltradas.isNotEmpty) {
    final promedio =
        notasFiltradas.reduce((a, b) => a + b) / notasFiltradas.length;
    return promedio;
  } else {
    // Retorna 0 si no hay notas válidas
    return 0;
  }
}
