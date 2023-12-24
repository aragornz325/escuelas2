part of 'bloc_kyc.dart';

/// {@template BlocKycEvento}
/// AGREGAR DOCUMENTACION GENERADA
/// {@endtemplate}
abstract class BlocKycEvento {
  /// {@macro BlocKycEvento}
  const BlocKycEvento();
}

/// {@template BlocInicioEventoInicializar}
/// {@endtemplate}
class BlocKycEventoInicializar extends BlocKycEvento {
  /// {@macro BlocInicioEventoInicializar}
  const BlocKycEventoInicializar();
}

/// {@template BlocKycEventoSeleccionarCursoYMateria}
/// {@endtemplate}
class BlocKycEventoSeleccionarCursoYMateria extends BlocKycEvento {
  /// {@macro BlocKycEventoSeleccionarCursoYMateria}
  const BlocKycEventoSeleccionarCursoYMateria({
    required this.idOpcion,
    this.idCurso,
    this.idMateria,
  });
  final int idOpcion;
  final int? idCurso;
  final int? idMateria;
}

/// {@template BlocKycEventoAgregarOpcion}
/// {@endtemplate}
class BlocKycEventoAgregarOpcion extends BlocKycEvento {
  /// {@macro BlocKycEventoAgregarOpcion}
  const BlocKycEventoAgregarOpcion();
}
