// ignore_for_file: public_member_api_docs

// TODO(SAM): Crear  1 clase sealed padre y estos enums extienden d ella
// https://dart.dev/language/class-modifiers
enum ValorDeCalificacionNumericaDecimal {
  sinCalificar(0, 'S/C'),
  uno(1, '1'),
  dos(2, '2'),
  tres(3, '3'),
  cuatro(4, '4'),
  cinco(5, '5'),
  seis(6, '6'),
  siete(7, '7'),
  ocho(8, '8'),
  nueve(9, '9'),
  diez(10, '10');

  const ValorDeCalificacionNumericaDecimal(this.valor, this.representacion);

  /// Representación textual del valor de la calificación.
  final int valor;
  final String representacion;
}
