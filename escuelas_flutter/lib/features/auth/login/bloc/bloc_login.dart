import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/isar/isar_servicio.dart';
import 'package:escuelas_flutter/one_signal/one_signal_servicio.dart';
import 'package:escuelas_flutter/utilidades/funciones/cerrar_sesion_usuario.dart';
import 'package:escuelas_flutter/utilidades/funciones/expresion_regular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:serverpod_auth_client/module.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:serverpod_auth_google_flutter/serverpod_auth_google_flutter.dart';

part 'bloc_login_estado.dart';
part 'bloc_login_evento.dart';

/// {@template BlocLogin}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocLogin extends Bloc<BlocLoginEvento, BlocLoginEstado> {
  /// {@macro BlocLogin}
  BlocLogin({
    required this.emailAuth,
  }) : super(const BlocLoginEstadoInicial()) {
    on<BlocLoginEventoIniciarSesionConCredenciales>(
      _iniciarSesionConCredenciales,
    );
    on<BlocLoginEventoIniciarSesionConGoogle>(_iniciarSesionConGoogle);
  }

  /// Repo de los llamados a server pod
  final EmailAuthController emailAuth;

  /// Permite al usuario iniciar sesion con Email o DNI
  Future<void> _iniciarSesionConCredenciales(
    BlocLoginEventoIniciarSesionConCredenciales event,
    Emitter<BlocLoginEstado> emit,
  ) async {
    emit(BlocLoginEstadoCargando.desde());
    await operacionBloc(
      callback: (client) async {
        final UserInfo? userInfo;
        if (ExpresionesRegulares.numerosUnicamente.hasMatch(event.dniOEmail)) {
          final email =
              await client.usuario.obtenerEmailConDni(dni: event.dniOEmail);
          if (email == null) {
            return emit(BlocLoginEstadoErrorAlLogearseConCredenciales.desde());
          }
          userInfo = await emailAuth.signIn(email, event.password);
        } else {
          userInfo = await emailAuth.signIn(event.dniOEmail, event.password);
        }
        if (userInfo == null) {
          return emit(BlocLoginEstadoErrorAlLogearseConCredenciales.desde());
        }
        final usuarioPendiente =
            await client.usuario.obtenerDatosDeSolicitudDelUsuario();

        if (usuarioPendiente == null) {
          return emit(
            BlocLoginEstadoFaltaCompletarKyc.desde(),
          );
        }

        switch (usuarioPendiente.estadoDeSolicitud) {
          case EstadoDeSolicitud.rechazado:
            await IsarServicio.guardarUsuarioPendiente(usuarioPendiente);
            emit(
              BlocLoginEstadoSolicitudRechazada.desde(),
            );
          case EstadoDeSolicitud.pendiente:
            await IsarServicio.guardarUsuarioPendiente(usuarioPendiente);
            emit(
              BlocLoginEstadoSolicitudPendiente.desde(
                usuarioPendiente: usuarioPendiente,
              ),
            );
          case EstadoDeSolicitud.aprobado:
            final usuario = await client.usuario.obtenerDatosDelUsuario();

            await IsarServicio.guardarUsuario(usuario);

            await OneSignalServicio.loguearUsuario(usuario.id ?? 0);

            emit(
              BlocLoginEstadoSolicitudAceptada.desde(
                usuario: usuario,
                userInfo: userInfo,
              ),
            );
        }
      },
      onError: (e, st) {
        emit(BlocLoginEstadoErrorAlLogearseConCredenciales.desde());
      },
    );
  }

  /// Inicia sesión con cuenta de google, en caso de ser exitoso redirige a la
  /// pagina correspondiente, en caso de error devuelve el error correspondiente
  Future<void> _iniciarSesionConGoogle(
    BlocLoginEventoIniciarSesionConGoogle event,
    Emitter<BlocLoginEstado> emit,
  ) async {
    emit(BlocLoginEstadoCargando.desde());
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
          return emit(BlocLoginEstadoErrorAlIniciarSesion.desde());
        }

        final usuarioPendiente =
            await client.usuario.obtenerDatosDeSolicitudDelUsuario();

        if (usuarioPendiente == null) {
          return emit(
            BlocLoginEstadoFaltaCompletarKyc.desde(),
          );
        }

        switch (usuarioPendiente.estadoDeSolicitud) {
          case EstadoDeSolicitud.rechazado:
            await IsarServicio.guardarUsuarioPendiente(usuarioPendiente);
            emit(
              BlocLoginEstadoSolicitudRechazada.desde(),
            );
          case EstadoDeSolicitud.pendiente:
            await IsarServicio.guardarUsuarioPendiente(usuarioPendiente);
            emit(
              BlocLoginEstadoSolicitudPendiente.desde(
                usuarioPendiente: usuarioPendiente,
              ),
            );
          case EstadoDeSolicitud.aprobado:
            final usuario = await client.usuario.obtenerDatosDelUsuario();

            await IsarServicio.guardarUsuario(usuario);

            await OneSignalServicio.loguearUsuario(usuario.id ?? 0);

            emit(
              BlocLoginEstadoSolicitudAceptada.desde(
                usuario: usuario,
                userInfo: userInfo,
              ),
            );
        }
      },
      onError: (e, st) {
        cerrarSesionUsuario();
        emit(BlocLoginEstadoErrorAlIniciarSesion.desde());
      },
    );
  }
}
