part of 'bloc_comisiones.dart';

/// {@template BlocComisionesEvento}
/// Clase padre de los eventos de 'Comisiones'
/// {@endtemplate}
@immutable
class BlocComisionesEvento {
  /// {@macro BlocComisionesEvento}
  const BlocComisionesEvento();
}

/// {@template BlocMisCursosEventoInicializar}
/// inicializa la pagina trae todas las comisiones de la institucion
/// y sus asignaturas
/// {@endtemplate}
class BlocComisionesEventoInicializar extends BlocComisionesEvento {
  /// {@macro BlocMisCursosEventoInicializar}
  const BlocComisionesEventoInicializar();
}
