/// {@template ExpresionesRegulares}
/// Esta clase es utilizada para agregar las [RegExp] que
/// admitiran o restringiran utilizacion de tipos de caracteres.
/// {@endtemplate}
class ExpresionesRegulares {
  /// {@macro ExpresionesRegulares}

  /// [RegExp] que solo admite formato email.
  static RegExp get email => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/-=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+",
      );

  /// [RegExp] que solo admite formato letras.
  static RegExp get letrasUnicamente => RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');

  /// [RegExp] que solo admite formato letras y números.
  static RegExp get letrasYNumeros => RegExp(r'^[a-zA-ZÀ-ÿ\s\d]*$');

  /// [RegExp] que solo admite formato datetime.
  static RegExp get dateTime => RegExp(r'^[0-9/-]+$');

  /// [RegExp] que solo admite numeros.
  static RegExp get numerosUnicamente => RegExp(r'^[0-9]+$');
}
