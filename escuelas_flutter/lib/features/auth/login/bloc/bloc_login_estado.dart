part of 'bloc_login.dart';

/// {@template BlocLoginEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocLoginEstado {
  /// {@macro BlocLoginEstado}
  const BlocLoginEstado._();

  BlocLoginEstado.desde() : this._();

  /// Getter que verifica si el estado actual es de error y el error es
  /// desconocido.
  bool get esEstadoErroneo => this is BlocLoginEstadoErrorGeneral;

  /// Getter que verifica si el estado de inicio de sesion es erroneo.
  bool get esErrorAlIniciarSesion =>
      this is BlocLoginEstadoErrorAlIniciarSesion;
  List<Object> get props => [];
}

/// {@template BlocLoginEstadoInicial}
/// Estado inicial de los componentes de la pantalla 'Login'
/// {@endtemplate}
class BlocLoginEstadoInicial extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoInicial}
  const BlocLoginEstadoInicial() : super._();
}

/// {@template BlocLoginEstadoCargando}
/// Estado de cargando de los componentes de la pantalla 'Login'
/// {@endtemplate}
class BlocLoginEstadoCargando extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoCargando}
  BlocLoginEstadoCargando.desde() : super.desde();
}

/// {@template BlocLoginEstadoExitosoGeneral}
/// Estado exitoso general de los componentes de la pantalla 'Login'
/// {@endtemplate}
class BlocLoginEstadoExitosoGeneral extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoExitosoGeneral}
  BlocLoginEstadoExitosoGeneral.desde() : super.desde();
}

/// {@template BlocLoginEstadoErrorAlIniciarSesion}
/// Estado de error de al iniciar sesion
/// {@endtemplate}
class BlocLoginEstadoErrorAlIniciarSesion extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoErrorAlIniciarSesion}
  BlocLoginEstadoErrorAlIniciarSesion.desde() : super.desde();
}

/// {@template BlocLoginEstadoErrorGeneral}
/// Estado de error de los componentes de la pantalla 'Login'
/// {@endtemplate}
class BlocLoginEstadoErrorGeneral extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoErrorGeneral}
  BlocLoginEstadoErrorGeneral.desde() : super.desde();
}

/// {@template BlocLoginEstadoErrorAlLogearseConCredenciales}
/// Estado de error al logearse con credenciales
/// {@endtemplate}
class BlocLoginEstadoErrorAlLogearseConCredenciales extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoErrorAlLogearseConCredenciales}
  BlocLoginEstadoErrorAlLogearseConCredenciales.desde() : super.desde();
}

/// {@template BlocLoginEstadoFaltaCompletarKyc}
/// Este estado ocurre cuando el usuario hizo el login con google,
/// se averigua si en la db el usuario actual ya completo el
/// KCY, en caso de no ser así se emite este estado.
/// Si este estado es emitido, se redirige al usuario a completar
/// el kyc.
/// {@endtemplate}
class BlocLoginEstadoFaltaCompletarKyc extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoFaltaCompletarKyc}
  BlocLoginEstadoFaltaCompletarKyc.desde() : super.desde();
}

/// {@template BlocLoginEstadoSolicitudRechazada}
/// Este estado ocurre cuando el usuario hizo el login con google,
/// en el caso de ser rechazado de acuerdo a su [EstadoDeSolicitud]
/// {@endtemplate}
class BlocLoginEstadoSolicitudRechazada extends BlocLoginEstado {
  /// {@macro  BlocLoginEstadoSolicitudRechazada}
  BlocLoginEstadoSolicitudRechazada.desde() : super.desde();
}

/// {@template BlocLoginEstadoSolicitudPendiente}
/// Estado exitoso emitido luego de que se llame al endpoint
/// obtenerUsuariosPendientes y que devuelva null, significando que
/// el usuario debe ser redirigido al KYC para completarlo.
/// {@endtemplate}
class BlocLoginEstadoSolicitudPendiente extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoSolicitudPendiente}
  BlocLoginEstadoSolicitudPendiente.desde({
    required this.usuarioPendiente,
  }) : super.desde();
  final UsuarioPendiente usuarioPendiente;
}

/// {@template BlocLoginEstadoSolicitudAceptada}
/// Estado exitoso emitido al iniciar sesión
/// {@endtemplate}
class BlocLoginEstadoSolicitudAceptada extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoSolicitudAceptada}
  BlocLoginEstadoSolicitudAceptada.desde({
    required this.usuario,
    required this.userInfo,
  }) : super.desde();

  /// Modelo de usuario de la base de datos que contiene info de los roles y
  /// demas datos importantes del usuario.
  final Usuario usuario;

  /// Modelo de usuario logueado por google que contiene info del cliente.
  final UserInfo userInfo;
}
