// ignore_for_file: public_member_api_docs

enum ValorDeCalificacionConceptualAlfabetica {
  aMas('A+'),
  a('A'),
  bMas('B+'),
  b('B'),
  bMenos('B-'),
  cMas('C+'),
  c('C'),
  cMenos('C-'),
  dMas('D+'),
  d('D'),
  dMenos('D-'),
  f('F');

  const ValorDeCalificacionConceptualAlfabetica(this.valor);

  /// Representación textual del valor de la calificación.
  final String valor;
}
