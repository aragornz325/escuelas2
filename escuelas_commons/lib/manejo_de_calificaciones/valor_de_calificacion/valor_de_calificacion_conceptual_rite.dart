// ignore_for_file: public_member_api_docs

enum ValorDeCalificacionConceptualRite {
  tea(8, 'TEA'),
  tep(5, 'TEP'),
  ted(3, 'TED');

  const ValorDeCalificacionConceptualRite(this.valor, this.representacion);

  /// Representación textual del valor de la calificación.
  final int valor;
  final String representacion;
}
