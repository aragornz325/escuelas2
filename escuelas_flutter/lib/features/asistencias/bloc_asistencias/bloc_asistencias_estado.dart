part of 'bloc_asistencias.dart';

/// {@template BlocAsistenciasEstado}
/// Bloc que maneja el estado de las asistencias
/// {@endtemplate}
@immutable
class BlocAsistenciasEstado {
  /// {@macro BlocAsistenciasEstado}
  const BlocAsistenciasEstado._({
    this.cursos = const [],
    this.index = -1,
  });

  BlocAsistenciasEstado.desde(
    BlocAsistenciasEstado otro, {
    List<ModeloCurso>? cursos,
    int? index,
  }) : this._(
          cursos: cursos ?? otro.cursos,
          index: index ?? otro.index,
        );

  /// Lista de los cursos
  final List<ModeloCurso> cursos;

  /// Indice del curso
  final int index;

  /// Getter para saber si el curso es visible
  bool get cursoDesplegado => index != -1 && (cursos[index].esVisible ?? true);

  /// Getter para saber si el curso es el mismo
  bool esMismoCurso(int index) =>
      this.index == index && (cursos[index].esVisible ?? true);

  List<Object> get props => [
        cursos,
        index,
      ];
}

/// {@template BlocAsistenciasEstadoInicial}
/// Estado Inicial de la pagina de 'Asistencias'
/// {@endtemplate}
class BlocAsistenciasEstadoInicial extends BlocAsistenciasEstado {
  /// {@macro BlocAsistenciasEstadoInicial}
  const BlocAsistenciasEstadoInicial() : super._();
}

/// {@template BlocAsistenciasEstadoCargando}
/// Estado Cargando de la pagina de 'Asistencias'
/// {@endtemplate}
class BlocAsistenciasEstadoCargando extends BlocAsistenciasEstado {
  /// {@macro BlocAsistenciasEstadoCargando}
  BlocAsistenciasEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocAsistenciasEstadoExitoso}
/// Estado Exitoso de la pagina de 'Asistencias'
/// {@endtemplate}
class BlocAsistenciasEstadoExitoso extends BlocAsistenciasEstado {
  /// {@macro BlocAsistenciasEstadoExitoso}
  BlocAsistenciasEstadoExitoso.desde(
    super.otro, {
    required super.cursos,
    super.index,
  }) : super.desde();
}

/// {@template BlocAsistenciasEstadoFallido}
/// Estado Fallido de la pagina de 'Asistencias'
/// {@endtemplate}
class BlocAsistenciasEstadoFallido extends BlocAsistenciasEstado {
  /// {@macro BlocAsistenciasEstadoFallido}
  BlocAsistenciasEstadoFallido.desde(super.otro) : super.desde();
}
