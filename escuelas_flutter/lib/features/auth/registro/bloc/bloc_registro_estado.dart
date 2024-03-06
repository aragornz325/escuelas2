part of 'bloc_registro.dart';

/// {@template BlocRegistroEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocRegistroEstado {
  /// {@macro BlocRegistroEstado}
  const BlocRegistroEstado._({
    this.mensajeDeError = '',
  });

  BlocRegistroEstado.desde(
    BlocRegistroEstado otro, {
    String? mensajeDeError,
  }) : this._(
          mensajeDeError: mensajeDeError ?? otro.mensajeDeError,
        );
  final String mensajeDeError;

  List<dynamic> get props => [
        mensajeDeError,
      ];
}

/// {@template BlocRegistroEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'Registro'
/// {@endtemplate}
class BlocRegistroEstadoInicial extends BlocRegistroEstado {
  /// {@macro BlocRegistroEstadoInicial}
  const BlocRegistroEstadoInicial() : super._();
}

/// {@template BlocRegistroEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'Registro'
/// {@endtemplate}
class BlocRegistroEstadoCargando extends BlocRegistroEstado {
  /// {@macro BlocRegistroEstadoCargando}
  BlocRegistroEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocRegistroEstadoExitosoGeneral}
/// Estado exitoso general de los componentes de la pantalla 'Registro'
/// {@endtemplate}
class BlocRegistroEstadoExitosoGeneral extends BlocRegistroEstado {
  /// {@macro BlocRegistroEstadoExitosoGeneral}
  BlocRegistroEstadoExitosoGeneral.desde(super.otro) : super.desde();
}

/// {@template BlocRegistroEstadoExitosoAlRegistrar}
/// Estado exitoso al registrar un usuario
/// {@endtemplate}
class BlocRegistroEstadoExitosoAlRegistrar extends BlocRegistroEstado {
  /// {@macro BlocRegistroEstadoExitosoAlRegistrar}
  BlocRegistroEstadoExitosoAlRegistrar.desde(super.otro) : super.desde();
}

/// {@template BlocRegistroEstadoErrorGeneral}
/// Estado de error de los componentes de la pantalla 'Registro'
/// {@endtemplate}
class BlocRegistroEstadoErrorGeneral extends BlocRegistroEstado {
  /// {@macro BlocRegistroEstadoErrorGeneral}
  BlocRegistroEstadoErrorGeneral.desde(super.otro) : super.desde();
}

/// {@template BlocRegistroEstadoErrorAlRegistrarseConGoogle}
/// Estado de error al registrarse con google
/// {@endtemplate}
class BlocRegistroEstadoErrorAlRegistrarseConGoogle extends BlocRegistroEstado {
  /// {@macro BlocRegistroEstadoErrorAlRegistrarseConGoogle}
  BlocRegistroEstadoErrorAlRegistrarseConGoogle.desde(super.otro)
      : super.desde();
}

/// {@template BlocRegistroEstadoErrorAlRegistrarseConGoogle}
/// Estado de error al registrarse con google
/// {@endtemplate}
class BlocRegistroEstadoFaltaCompletarKyc extends BlocRegistroEstado {
  /// {@macro BlocRegistroEstadoErrorAlRegistrarseConGoogle}
  BlocRegistroEstadoFaltaCompletarKyc.desde(super.otro) : super.desde();
}

/// {@template BlocRegistroEstadoErrorAlRegistrarseConGoogle}
/// Estado de error al registrarse con google
/// {@endtemplate}
class BlocRegistroEstadoSolicitudRechazada extends BlocRegistroEstado {
  /// {@macro BlocRegistroEstadoErrorAlRegistrarseConGoogle}
  BlocRegistroEstadoSolicitudRechazada.desde(super.otro) : super.desde();
}

class BlocRegistroEstadoSolicitudPendiente extends BlocRegistroEstado {
  /// {@macro BlocRegistroEstadoErrorAlRegistrarseConGoogle}
  BlocRegistroEstadoSolicitudPendiente.desde(
    super.otro, {
    required this.usuarioPendiente,
  }) : super.desde();
  final UsuarioPendiente? usuarioPendiente;
}

class BlocRegistroEstadoSolicitudAceptada extends BlocRegistroEstado {
  /// {@macro BlocRegistroEstadoErrorAlRegistrarseConGoogle}
  BlocRegistroEstadoSolicitudAceptada.desde(
    super.otro, {
    required this.userInfo,
    required this.usuario,
  }) : super.desde();
  final Usuario usuario;
  final UserInfo userInfo;
}
