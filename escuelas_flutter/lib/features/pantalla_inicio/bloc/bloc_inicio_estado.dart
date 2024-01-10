part of 'bloc_inicio.dart';

/// {@template BlocInicioEstado}
/// Maneja los estados de procesos que se ejecutan a lo largo del Inicio
/// {@endtemplate}
class BlocInicioEstado {
  /// {@macro BlocInicioEstado}
  const BlocInicioEstado._({this.listaRoles = const []});

  BlocInicioEstado.desde(
    BlocInicioEstado otro, {
    List<RolDeUsuario>? listaRoles,
  }) : this._(
          listaRoles: listaRoles ?? otro.listaRoles,
        );

  final List<RolDeUsuario> listaRoles;

// TODO(SAM): VERIFICAR logica para roles
  /// Obtiene la lista de permisos del usuario y devuelve la lista iterable
  /// de [InfoDeRol] para poder mapearla en la UI.
  List<InfoDeRol> get listaEtiquetas => InfoDeRol.values
      .where(
        (etiqueta) => listaRoles.any(
          (rol) => etiqueta.rolesAsignados.contains(rol.id),
        ),
      )
      .toList();
}

/// {@template BlocInicioEstadoInicial}
/// Estado inicial de [BlocInicioEstado].
/// {@endtemplate}
class BlocInicioEstadoInicial extends BlocInicioEstado {
  /// {@macro BlocInicioEstadoInicial}
  const BlocInicioEstadoInicial() : super._();
}

/// {@template BlocInicioEstadoCargando}
/// Estado de espera/carga de [BlocInicioEstado].
/// {@endtemplate}
class BlocInicioEstadoCargando extends BlocInicioEstado {
  /// {@macro BlocInicioEstadoCargando}
  BlocInicioEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocInicioEstadoExitoso}
/// Estado de éxito de [BlocInicioEstado].
/// {@endtemplate}
class BlocInicioEstadoExitoso extends BlocInicioEstado {
  /// {@macro BlocInicioEstadoExitoso}
  BlocInicioEstadoExitoso.desde(super.otro, {super.listaRoles}) : super.desde();
}

/// {@template BlocInicioEstadoFallido}
/// Estado de fallo de [BlocInicioEstado].
/// {@endtemplate}
class BlocInicioEstadoFallido extends BlocInicioEstado {
  /// {@macro BlocInicioEstadoFallido}
  BlocInicioEstadoFallido.desde(super.otro) : super.desde();
}
