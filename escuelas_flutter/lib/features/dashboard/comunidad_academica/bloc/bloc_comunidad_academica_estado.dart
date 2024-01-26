part of 'bloc_comunidad_academica.dart';

/// {@template BlocComunidadAcademicaEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocComunidadAcademicaEstado {
  /// {@macro BlocComunidadAcademicaEstado}
  const BlocComunidadAcademicaEstado._({
    this.ordenarPor = OrdenarPor.apellido,
    this.idRol = -1,
    this.listaRoles = const [],
    this.listaUsuarios,
    this.rolElegido,
  });

  BlocComunidadAcademicaEstado.desde(
    BlocComunidadAcademicaEstado otro, {
    List<Role>? listaRoles,
    UsuariosOrdenados? listaUsuarios,
    int idRol = -1,
    OrdenarPor? ordenarPor,
    Role? rolElegido,
  }) : this._(
          listaRoles: listaRoles ?? otro.listaRoles,
          listaUsuarios: listaUsuarios ?? otro.listaUsuarios,
          idRol: idRol != -1 ? idRol : otro.idRol,
          ordenarPor: ordenarPor ?? otro.ordenarPor,
          rolElegido: rolElegido ?? otro.rolElegido,
        );

  /// Lista de roles de la institucion
  final List<Role> listaRoles;

  /// Lista de usuarios de la institucion con el rol seleccionado
  final UsuariosOrdenados? listaUsuarios;

  /// Id del rol
  final int idRol;

  /// Orden en base al enum
  final OrdenarPor ordenarPor;

  /// Rol elegido a mostrar en la lista
  final Role? rolElegido;

  bool get estaVacio =>
      listaUsuarios?.usuariosListados.every((e) => e.usuarios.isEmpty) ?? false;
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
  BlocComunidadAcademicaEstadoExitosoAlOrdenar.desde(super.otro)
      : super.desde();
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
    super.idRol,
    super.ordenarPor,
    super.rolElegido,
  }) : super.desde();
}

/// {@template BlocComunidadAcademicaEstadoFallido}
/// Estado de error de los componentes de la '[PaginaComunidadAcademica]'
/// {@endtemplate}
class BlocComunidadAcademicaEstadoError extends BlocComunidadAcademicaEstado {
  /// {@macro BlocComunidadAcademicaEstadoError}
  BlocComunidadAcademicaEstadoError.desde(super.otro) : super.desde();
}
