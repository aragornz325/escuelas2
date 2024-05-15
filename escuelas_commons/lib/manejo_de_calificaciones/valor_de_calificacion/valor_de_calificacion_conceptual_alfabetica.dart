// ignore_for_file: public_member_api_docs

enum ValorDeCalificacionConceptualAlfabetica {
  sinCalificar(null, 'S/C'),
  fMenos(0, 'F-'),
  f(1, 'F'),
  dMenos(2, 'D-'),
  d(3, 'D'),
  dMas(4, 'D+'),
  cMenos(5, 'C-'),
  c(6, 'C'),
  cMas(6, 'C+'),
  bMenos(7, 'B-'),
  b(8, 'B'),
  bMas(9, 'B+'),
  aMenos(10, 'A-'),
  a(11, 'A'),
  aMas(12, 'A+');

  const ValorDeCalificacionConceptualAlfabetica(
    this.valor,
    this.representacion,
  );

  /// Reprersentacion numero del valor de la calificacion.
  final int? valor;

  /// Representación textual del valor de la calificación.
  final String representacion;
}
