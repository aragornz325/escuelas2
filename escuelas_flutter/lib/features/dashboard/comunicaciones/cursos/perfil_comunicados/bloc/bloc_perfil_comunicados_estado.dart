part of 'bloc_perfil_comunicados.dart';

/// {@template BlocPerfilComunicadosEstado}
/// TODO(mati) add docu
/// {@endtemplate}
@immutable
sealed class BlocPerfilComunicadosEstado {
  /// {@macro BlocPerfilComunicadosEstado}
  const BlocPerfilComunicadosEstado._({required this.idUsuario});

  BlocPerfilComunicadosEstado.desde(
    BlocPerfilComunicadosEstado otro,
  ) : this._(
          idUsuario: otro.idUsuario,
        );

  /// Id del usuario a traer sus notificaciones.
  final int idUsuario;

  List<Object> get props => [
        idUsuario,
      ];
}

/// {@template BlocPerfilComunicadosEstadoInicial}
/// TODO(mati) add docu
/// {@endtemplate}
final class BlocPerfilComunicadosEstadoInicial
    extends BlocPerfilComunicadosEstado {
  /// {@macro BlocPerfilComunicadosEstadoInicial}
  const BlocPerfilComunicadosEstadoInicial(int idUsuario)
      : super._(idUsuario: idUsuario);
}

/// {@template BlocPerfilComunicadosEstadoCargando}
/// TODO(mati) add docu
/// {@endtemplate}
class BlocPerfilComunicadosEstadoCargando extends BlocPerfilComunicadosEstado {
  /// {@macro BlocPerfilComunicadosEstadoCargando}
  BlocPerfilComunicadosEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocPerfilComunicadosEstadoExitoso}
/// TODO(mati) add docu
/// {@endtemplate}
class BlocPerfilComunicadosEstadoExitoso extends BlocPerfilComunicadosEstado {
  /// {@macro BlocPerfilComunicadosEstadoExitoso}
  BlocPerfilComunicadosEstadoExitoso.desde(
    super.otro,
  ) : super.desde();
}

/// {@template BlocPerfilComunicadosEstadoFallido}
/// TODO(mati) add docu
/// {@endtemplate}
class BlocPerfilComunicadosEstadoFallido extends BlocPerfilComunicadosEstado {
  /// {@macro BlocPerfilComunicadosEstadoFallido}
  BlocPerfilComunicadosEstadoFallido.desde(super.otro) : super.desde();
}
