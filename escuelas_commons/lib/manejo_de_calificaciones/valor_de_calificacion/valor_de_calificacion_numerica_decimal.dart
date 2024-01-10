// ignore_for_file: public_member_api_docs

enum ValorDeCalificacionNumericaDecimal {
  diez('10'),
  nueve('9'),
  ocho('8'),
  siete('7'),
  seis('6'),
  cinco('5'),
  cuatro('4'),
  tres('3'),
  dos('2'),
  uno('1');

  const ValorDeCalificacionNumericaDecimal(this.valor);

  /// Representación textual del valor de la calificación.
  final String valor;
}
