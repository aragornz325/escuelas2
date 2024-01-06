part of 'bloc_comunidad_academica.dart';

/// {@template BlocComunidadAcademicaEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocComunidadAcademicaEstado {
  /// {@macro BlocComunidadAcademicaEstado}
  const BlocComunidadAcademicaEstado._({
    this.listaRoles = const [],
    this.listaUsuarios = const [],
    this.listaOrdenada = const [],
  });

  BlocComunidadAcademicaEstado.desde(
    BlocComunidadAcademicaEstado otro, {
    List<RolDeUsuario>? listaRoles,
    List<Usuario2>? listaUsuarios,
    List<Categoria>? listaOrdenada,
  }) : this._(
          listaRoles: listaRoles ?? otro.listaRoles,
          listaUsuarios: listaUsuarios ?? otro.listaUsuarios,
          listaOrdenada: listaOrdenada ?? otro.listaOrdenada,
        );

  /// Lista de roles de la institucion
  final List<RolDeUsuario> listaRoles;

  /// Lista de usuarios de la institucion con el rol seleccionado
  final List<Usuario2> listaUsuarios;

  /// Lista de usuarios de la institucion con el rol seleccionado ordenados
  final List<Categoria> listaOrdenada;
}

/// {@template BlocComunidadAcademicaEstadoInicial}
/// Estado inicial de los componentes de la '[PaginaComunidadAcademica]'
/// {@endtemplate}
class BlocComunidadAcademicaEstadoInicial extends BlocComunidadAcademicaEstado {
  /// {@macro BlocComunidadAcademicaEstadoInicial}
  const BlocComunidadAcademicaEstadoInicial() : super._();
}

/// {@template BlocComunidadAcademicaEstadoCargando}
/// Estado de cargando de los componentes de la '[PaginaComunidadAcademica]'
/// {@endtemplate}
class BlocComunidadAcademicaEstadoCargando
    extends BlocComunidadAcademicaEstado {
  /// {@macro BlocComunidadAcademicaEstadoCargando}
  BlocComunidadAcademicaEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocComunidadAcademicaEstadoExitoso}
/// Estado exitoso general de los componentes de la '[PaginaComunidadAcademica]'
/// {@endtemplate}
class BlocComunidadAcademicaEstadoExitoso extends BlocComunidadAcademicaEstado {
  /// {@macro BlocComunidadAcademicaEstadoExitoso}
  BlocComunidadAcademicaEstadoExitoso.desde(
    super.otro, {
    super.listaRoles,
  }) : super.desde();
}

class BlocComunidadAcademicaEstadoExitosoAlOrdenar
    extends BlocComunidadAcademicaEstado {
  /// {@macro BlocComunidadAcademicaEstadoExitoso}
  BlocComunidadAcademicaEstadoExitosoAlOrdenar.desde(
    super.otro, {
    super.listaOrdenada,
  }) : super.desde();
}

/// {@template BlocComunidadAcademicaEstadoExitosoAlTraerUsuarios}
/// Estado exitoso general de los componentes de la '[PaginaComunidadAcademica]'
/// {@endtemplate}
class BlocComunidadAcademicaEstadoExitosoAlTraerUsuarios
    extends BlocComunidadAcademicaEstado {
  /// {@macro BlocComunidadAcademicaEstadoExitosoAlTraerUsuarios}
  BlocComunidadAcademicaEstadoExitosoAlTraerUsuarios.desde(
    super.otro, {
    super.listaUsuarios,
  }) : super.desde();
}

/// {@template BlocComunidadAcademicaEstadoFallido}
/// Estado de error de los componentes de la '[PaginaComunidadAcademica]'
/// {@endtemplate}
class BlocComunidadAcademicaEstadoError extends BlocComunidadAcademicaEstado {
  /// {@macro BlocComunidadAcademicaEstadoError}
  BlocComunidadAcademicaEstadoError.desde(super.otro) : super.desde();
}
