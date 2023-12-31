import 'package:escuelas_flutter/extensiones/extension_bloc.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';
import 'package:escuelas_flutter/utilidades/funciones/expresion_regular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serverpod_auth_google_flutter/serverpod_auth_google_flutter.dart';

part 'bloc_login_estado.dart';
part 'bloc_login_evento.dart';

/// {@template BlocLogin}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocLogin extends Bloc<BlocLoginEvento, BlocLoginEstado> {
  /// {@macro BlocLogin}
  BlocLogin() : super(const BlocLoginEstadoInicial()) {
    on<BlocLoginEventoHabilitarBotonIngresar>(_habilitarBotonIngresar);
    // on<BlocLoginEventoIniciarSesionConCredenciales>(
    //   _iniciarSesionConCredenciales,
    // );
    on<BlocLoginEventoIniciarSesionConGoogle>(_iniciarSesionConGoogle);
  }

  /// Verifica si el correo dni y contraseña son válidos, y emite
  /// un estado exitoso para habilitar el botón de "Ingresar".
  void _habilitarBotonIngresar(
    BlocLoginEventoHabilitarBotonIngresar event,
    Emitter<BlocLoginEstado> emit,
  ) {
    if (ExpresionRegular.numerosRegExp.hasMatch(event.dni) &&
        event.password.length >= 8) {
      emit(
        BlocLoginEstadoExitosoGeneral.desde(
          state,
          dni: event.dni,
          password: event.password,
          botonIngresarHabilitado: true,
        ),
      );
    } else {
      emit(
        BlocLoginEstadoExitosoGeneral.desde(
          state,
          botonIngresarHabilitado: false,
        ),
      );
    }
    emit(
      BlocLoginEstadoExitosoGeneral.desde(
        state,
        dni: event.dni,
        password: event.password,
      ),
    );
  }

  /// Inicia sesión con cuenta de google, en caso de ser exitoso redirige a la
  /// pagina correspondiente, en caso de error devuelve el error correspondiente
  Future<void> _iniciarSesionConGoogle(
    BlocLoginEventoIniciarSesionConGoogle event,
    Emitter<BlocLoginEstado> emit,
  ) async {
    emit(BlocLoginEstadoCargando.desde(state, estaIniciandoSesion: true));
    await operacionBloc(
      callback: () async {
        final userInfo = await signInWithGoogle(
          client.modules.auth,
          redirectUri: Uri.parse('http://localhost:8082/googlesignin'),
        );

        if (userInfo == null) {
          return emit(
            BlocLoginEstadoErrorAlIniciarSesion.desde(state),
          );
        }

        emit(BlocLoginEstadoExitosoIniciarSesion.desde(state));
      },
      onError: (e, st) {
        emit(BlocLoginEstadoErrorAlIniciarSesion.desde(state));
      },
    );
  }

//! TODO(manu): Hablar con back para ver como soportar credenciales en auth
  // Future<void> _iniciarSesionConCredenciales(
  //   BlocLoginEventoIniciarSesionConCredenciales event,
  //   Emitter<BlocLoginEstado> emit,
  // ) async {
  //   emit(BlocLoginEstadoCargando.desde(state, estaIniciandoSesion: true));
  //   await operacionBloc(
  //       callback: (client) async {
  //         final userInfo = await emailaut;
  //       },
  //       onError: onError);
  // }
}
