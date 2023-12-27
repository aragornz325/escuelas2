/// Capitaliza la primera letra de un texto
String capitalize(String texto) {
  if (texto.isEmpty) {
    return texto;
  }

  return texto[0].toUpperCase() + texto.substring(1);
}
