part of 'bloc_login.dart';

/// {@template BlocLoginEstado}
/// Maneja los distintos estados y variables guardadas en los mismos
/// {@endtemplate}
class BlocLoginEstado {
  /// {@macro BlocLoginEstado}
  const BlocLoginEstado._({
    this.dni = '',
    this.password = '',
    this.botonIngresarHabilitado = false,
    this.estaIniciandoSesion = false,
    this.estaIniciandoSesionConGoogle = false,
  });

  BlocLoginEstado.desde(
    BlocLoginEstado otro, {
    String? dni,
    String? password,
    bool? botonIngresarHabilitado,
    bool estaIniciandoSesion = false,
    bool estaIniciandoSesionConGoogle = false,
  }) : this._(
          dni: dni ?? otro.dni,
          password: password ?? otro.password,
          botonIngresarHabilitado:
              botonIngresarHabilitado ?? otro.botonIngresarHabilitado,
          estaIniciandoSesion: estaIniciandoSesion,
          estaIniciandoSesionConGoogle: estaIniciandoSesionConGoogle,
        );

  /// DNI del usuario a guardar
  final String dni;

  /// Password del usuario a guardar
  final String password;

  /// Bool para habilitar el boton o no dependiendo del contenido
  /// de los textfields
  final bool botonIngresarHabilitado;

  /// Bool para el estado de iniciando sesión
  final bool estaIniciandoSesion;

  /// Bool para el estado de iniciando sesión con google
  final bool estaIniciandoSesionConGoogle;

  /// Getter que verifica si el estado actual es el estado cargando
  /// y apreto el boton de iniciar sesion o login con google
  bool get estaCargandoInicioDeSesion =>
      estaIniciandoSesion ||
      estaIniciandoSesionConGoogle && this is BlocLoginEstadoCargando;

  /// Getter que verifica si el estado actual es de error y el error es
  /// desconocido.
  bool get esEstadoErroneo => this is BlocLoginEstadoErrorGeneral;

  /// Getter que verifica si el estado de inicio de sesion es erroneo.
  bool get esErrorAlIniciarSesion =>
      this is BlocLoginEstadoErrorAlIniciarSesion;

  List<Object> get props => [
        dni,
        password,
        botonIngresarHabilitado,
        estaIniciandoSesion,
        estaIniciandoSesionConGoogle,
      ];
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
  BlocLoginEstadoCargando.desde(
    super.otro, {
    super.estaIniciandoSesion,
  }) : super.desde();
}

/// {@template BlocLoginEstadoExitosoGeneral}
/// Estado exitoso general de los componentes de la pantalla 'Login'
/// {@endtemplate}
class BlocLoginEstadoExitosoGeneral extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoExitosoGeneral}
  BlocLoginEstadoExitosoGeneral.desde(
    super.otro, {
    super.dni,
    super.password,
    super.botonIngresarHabilitado,
  }) : super.desde();
}

/// {@template BlocLoginEstadoErrorAlIniciarSesion}
/// Estado de error de al iniciar sesion
/// {@endtemplate}
class BlocLoginEstadoErrorAlIniciarSesion extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoErrorAlIniciarSesion}
  BlocLoginEstadoErrorAlIniciarSesion.desde(super.otro) : super.desde();
}

/// {@template BlocLoginEstadoErrorGeneral}
/// Estado de error de los componentes de la pantalla 'Login'
/// {@endtemplate}
class BlocLoginEstadoErrorGeneral extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoErrorGeneral}
  BlocLoginEstadoErrorGeneral.desde(
    super.otro, {
    required this.mensajeDeError,
  }) : super.desde();

  /// Mensaje de error que se muestra al usuario
  final String mensajeDeError;
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
  BlocLoginEstadoFaltaCompletarKyc.desde(super.otro) : super.desde();
}

/// {@template BlocLoginEstadoSolicitudRechazada}
/// Este estado ocurre cuando el usuario hizo el login con google,
/// en el caso de ser rechazado de acuerdo a su [EstadoDeSolicitud]
/// {@endtemplate}
class BlocLoginEstadoSolicitudRechazada extends BlocLoginEstado {
  /// {@macro  BlocLoginEstadoSolicitudRechazada}
  BlocLoginEstadoSolicitudRechazada.desde(super.otro) : super.desde();
}

/// {@template BlocLoginEstadoSolicitudPendiente}
/// Estado exitoso emitido luego de que se llame al endpoint
/// obtenerUsuariosPendientes y que devuelva null, significando que
/// el usuario debe ser redirigido al KYC para completarlo.
/// {@endtemplate}
class BlocLoginEstadoSolicitudPendiente extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoSolicitudPendiente}
  BlocLoginEstadoSolicitudPendiente.desde(
    super.otro, {
    required this.usuarioPendiente,
  }) : super.desde();
  final UsuarioPendiente usuarioPendiente;
}

/// {@template BlocLoginEstadoSolicitudAceptada}
/// Estado exitoso emitido al iniciar sesión
/// {@endtemplate}
class BlocLoginEstadoSolicitudAceptada extends BlocLoginEstado {
  /// {@macro BlocLoginEstadoSolicitudAceptada}
  BlocLoginEstadoSolicitudAceptada.desde(
    super.otro, {
    required this.usuario,
    required this.userInfo,
  }) : super.desde();

  /// Modelo de usuario de la base de datos que contiene info de los roles y
  /// demas datos importantes del usuario.
  final Usuario usuario;

  /// Modelo de usuario logueado por google que contiene info del cliente.
  final UserInfo userInfo;
}
