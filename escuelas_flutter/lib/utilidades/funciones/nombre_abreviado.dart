String obtenerNombreAbreviado(String nombreCompleto) {
  final partes = nombreCompleto.split(' ');

  if (partes.length >= 2) {
    final inicialPrimerNombre = partes.first.substring(0, 1);
    final apellido = partes.last;

    return '$inicialPrimerNombre. $apellido';
  } else {
    // TODO(anyone): Manejar el caso en el que el nombre no tenga un formato esperado
    return nombreCompleto;
  }
}
