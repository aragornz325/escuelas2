import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/utilidades/funciones/expresion_regular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:serverpod_auth_client/module.dart';
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
    // TODO(Manu): descomentar cuando este el endpoint
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
    if (ExpresionesRegulares.numerosUnicamente.hasMatch(event.dni) &&
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
      callback: (client) async {
        //? Aca tira error en Unicamente en debug mode, no sucede en produccion.
        //? https://stackoverflow.com/questions/51914691/flutter-platform-exception-upon-cancelling-google-sign-in-flow
        final userInfo = await signInWithGoogle(
          client.modules.auth,
          clientId: dotenv.env['CLIENT_ID_GOOGLE_SIGNIN'],
          serverClientId: dotenv.env['SERVER_CLIENT_ID_GOOGLE_SIGNIN'],
          redirectUri: Uri.parse(dotenv.env['REDIRECT_URI_GOOGLE_SIGNIN']!),
        );

        if (userInfo == null) {
          return emit(BlocLoginEstadoErrorAlIniciarSesion.desde(state));
        }

        final usuarioPendiente =
            await client.usuario.obtenerDatosDeSolicitudDelUsuario();

        if (usuarioPendiente == null) {
          return emit(
            BlocLoginEstadoFaltaCompletarKyc.desde(state),
          );
        }

        switch (usuarioPendiente.estadoDeSolicitud) {
          case EstadoDeSolicitud.rechazado:
            emit(
              BlocLoginEstadoSolicitudRechazada.desde(
                state,
              ),
            );
          case EstadoDeSolicitud.pendiente:
            emit(
              BlocLoginEstadoSolicitudPendiente.desde(
                state,
                usuarioPendiente: usuarioPendiente,
              ),
            );
          case EstadoDeSolicitud.aprobado:
            final usuario = await client.usuario.obtenerDatosDelUsuario();
            emit(
              BlocLoginEstadoSolicitudAceptada.desde(
                state,
                usuario: usuario,
                userInfo: userInfo,
              ),
            );
        }
      },
      onError: (e, st) {
        emit(BlocLoginEstadoErrorAlIniciarSesion.desde(state));
      },
    );
  }

// TODO(manu): Hablar con back para ver como soportar credenciales en auth
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
