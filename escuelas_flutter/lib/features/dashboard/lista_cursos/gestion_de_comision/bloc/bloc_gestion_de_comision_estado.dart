part of 'bloc_gestion_de_comision.dart';

/// {@template BlocGestionDeComisionEstado}
/// Maneja los estados y variables generales de la pantalla
/// 'Gestion de comisiones'
/// {@endtemplate}
class BlocGestionDeComisionEstado {
  /// {@macro BlocGestionDeComisionEstado}
  const BlocGestionDeComisionEstado._({
    this.listaAlumnos,
  });
  BlocGestionDeComisionEstado.desde(
    BlocGestionDeComisionEstado otro, {
    UsuariosOrdenados? listaAlumnos,
  }) : this._(
          listaAlumnos: listaAlumnos ?? otro.listaAlumnos,
        );

  // TODO(mati): esta lista por ahora esta hardcodeada cuando se implemente
  // nuevo endpoint se cambiara
  final UsuariosOrdenados? listaAlumnos;

  List<Object?> get props => [
        listaAlumnos,
      ];
}

/// {@template BlocGestionDeComisionEstadoInicial}
/// Estado `inicial` de los componentes de la pantalla 'Gestion de comision'
/// {@endtemplate}
class BlocGestionDeComisionEstadoInicial extends BlocGestionDeComisionEstado {
  /// {@macro BlocGestionDeComisionEstadoInicial}
  const BlocGestionDeComisionEstadoInicial() : super._();
}

/// {@template BlocGestionDeComisionEstadoCargando}
/// Estado `cargando` de los componentes en la pantalla de
/// 'Gestion de comision'
/// {@endtemplate}
class BlocGestionDeComisionEstadoCargando extends BlocGestionDeComisionEstado {
  /// {@macro BlocGestionDeComisionEstadoCargando}
  BlocGestionDeComisionEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocGestionDeComisionEstadoExitoso}
/// Estado `exitoso` general de los componentes de la pantalla
/// 'Gestion de comision'
/// {@endtemplate}
class BlocGestionDeComisionEstadoExitoso extends BlocGestionDeComisionEstado {
  /// {@macro BlocGestionDeComisionEstadoExitoso}
  BlocGestionDeComisionEstadoExitoso.desde(
    super.otro, {
    super.listaAlumnos,
  }) : super.desde();
}

/// {@template BlocGestionDeComisionEstadoFallido}
/// Estado de `error general` de los componentes de la pantalla
/// 'Gestion de comision'
/// {@endtemplate}
class BlocGestionDeComisionEstadoFallido extends BlocGestionDeComisionEstado {
  /// {@macro BlocGestionDeComisionEstadoFallido}
  BlocGestionDeComisionEstadoFallido.desde(super.otro) : super.desde();
}
