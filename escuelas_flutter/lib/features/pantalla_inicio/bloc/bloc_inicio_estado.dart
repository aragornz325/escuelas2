part of 'bloc_inicio.dart';

/// {@template BlocInicioEstado}
/// Maneja los estados de procesos que se ejecutan a lo largo del Inicio
/// {@endtemplate}
class BlocInicioEstado {
  /// {@macro BlocInicioEstado}
  const BlocInicioEstado._({
    required this.infoUsuario,
  });

  BlocInicioEstado.desde(
    BlocInicioEstado otro, {
    InfoUsuario? infoUsuario,
  }) : this._(
          infoUsuario: infoUsuario ?? otro.infoUsuario,
        );

  final InfoUsuario infoUsuario;

  /// Obtiene la lista de permisos del usuario y devuelve la lista iterable
  /// de [InfoDeRol] para poder mapearla en la UI.
  List<InfoDeRol> get listaEtiquetas => InfoDeRol.values
      .where(
        (etiqueta) => infoUsuario.permiso.any(
          (permiso) => etiqueta.permisosAsignados.contains(permiso),
        ),
      )
      .toList();
}

/// {@template BlocInicioEstadoInicial}
/// Estado inicial de [BlocInicioEstado].
/// {@endtemplate}
class BlocInicioEstadoInicial extends BlocInicioEstado {
  /// {@macro BlocInicioEstadoInicial}
  const BlocInicioEstadoInicial(InfoUsuario infoUsuario)
      : super._(infoUsuario: infoUsuario);
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
