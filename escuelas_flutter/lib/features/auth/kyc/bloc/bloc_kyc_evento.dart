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

  /// Id de la opcion a la cual se le va a asignar el curso/materia
  final int idOpcion;

  /// Id del curso seleccionado
  final int? idCurso;

  /// Id de la materia seleccionada
  final int? idMateria;
}

/// {@template BlocKycEventoAgregarOpcion}
/// {@endtemplate}
class BlocKycEventoAgregarOpcion extends BlocKycEvento {
  /// {@macro BlocKycEventoAgregarOpcion}
  const BlocKycEventoAgregarOpcion();
}
