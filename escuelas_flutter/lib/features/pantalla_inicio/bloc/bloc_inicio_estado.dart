part of 'bloc_inicio.dart';

/// {@template BlocInicioEstado}
/// Maneja los estados de procesos que se ejecutan a lo largo del Inicio
/// {@endtemplate}
class BlocInicioEstado {
  /// {@macro BlocInicioEstado}
  const BlocInicioEstado._();

  BlocInicioEstado.desde(BlocInicioEstado otro) : this._();

// TODO(SAM): VERIFICAR logica para roles
  /// Obtiene la lista de permisos del usuario y devuelve la lista iterable
  /// de [InfoDeRol] para poder mapearla en la UI.
  List<InfoDeRol> get listaEtiquetas => [
        InfoDeRol.kyc,
        InfoDeRol.listaCursos,
        InfoDeRol.comunidadAcademica,
        InfoDeRol.usuariosPendientes,
      ];
  // InfoDeRol.values
  //     .where(
  //       (etiqueta) => listaRoles!.roles.any(
  //         (permiso) => etiqueta.permisosAsignados.contains(permiso.nombre),
  //       ),
  //     )
  //     .toList();
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
  BlocInicioEstadoExitoso.desde(
    super.otro,
  ) : super.desde();
}

/// {@template BlocInicioEstadoFallido}
/// Estado de fallo de [BlocInicioEstado].
/// {@endtemplate}
class BlocInicioEstadoFallido extends BlocInicioEstado {
  /// {@macro BlocInicioEstadoFallido}
  BlocInicioEstadoFallido.desde(super.otro) : super.desde();
}
