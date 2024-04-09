import 'dart:developer';

import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/isar/isar_servicio.dart';
import 'package:escuelas_flutter/one_signal/one_signal_servicio.dart';
import 'package:escuelas_flutter/utilidades/funciones/cerrar_sesion_usuario.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:serverpod_auth_client/module.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:serverpod_auth_google_flutter/serverpod_auth_google_flutter.dart';

part 'bloc_registro_estado.dart';
part 'bloc_registro_evento.dart';

/// {@template BlocRegistro}
/// Bloc que maneja los estados y lógica de la pagina de 'Registro'
/// {@endtemplate}
class BlocRegistro extends Bloc<BlocRegistroEvento, BlocRegistroEstado> {
  /// {@macro BlocRegistro}
  BlocRegistro({
    required this.emailAuth,
  }) : super(const BlocRegistroEstadoInicial()) {
    on<BlocRegistroEventoRegistrarUsuario>(
      _registrarseConCredenciales,
    );
    on<BlocRegistroEventoRegistrarseConGoogle>(_registrarseConGoogle);
  }

  /// Repo de los llamados a server pod
  final EmailAuthController emailAuth;

  /// Te permite registrarte con nombre, apellido, email, contraseña y dni
  Future<void> _registrarseConCredenciales(
    BlocRegistroEventoRegistrarUsuario event,
    Emitter<BlocRegistroEstado> emit,
  ) async {
    emit(BlocRegistroEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        await client.userInfo.registrarUserInfo(
          nombre: event.nombre.trim(),
          apellido: event.apellido.trim(),
          email: event.email,
          password: event.contrasenia,
          dni: event.documento,
        );
        final userInfo = await emailAuth.signIn(event.email, event.contrasenia);

        if (userInfo == null) {
          return emit(
            BlocRegistroEstadoErrorGeneral.desde(
              state,
              ExcepcionCustom(
                tipoDeError: TipoExcepcion.desconocido,
              ),
            ),
          );
        }
        final usuarioPendiente =
            await client.usuario.obtenerDatosDeSolicitudDelUsuario();
        if (usuarioPendiente == null) {
          return emit(
            BlocRegistroEstadoFaltaCompletarKyc.desde(state),
          );
        }
      },
      onErrorCustom: (e, st) {
        emit(
          BlocRegistroEstadoErrorGeneral.desde(state, e),
        );
      },
      onError: (e, st) {
        if (kDebugMode) debugger(message: 'handlear este error nuevo');
        emit(
          BlocRegistroEstadoErrorGeneral.desde(
            state,
            ExcepcionCustom(tipoDeError: TipoExcepcion.desconocido),
          ),
        );
      },
    );
  }

  /// Te permite registrarte con google
  Future<void> _registrarseConGoogle(
    BlocRegistroEventoRegistrarseConGoogle event,
    Emitter<BlocRegistroEstado> emit,
  ) async {
    emit(BlocRegistroEstadoCargando.desde(state));
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
          return emit(
            BlocRegistroEstadoErrorAlRegistrarseConGoogle.desde(state),
          );
        }

        final usuarioPendiente =
            await client.usuario.obtenerDatosDeSolicitudDelUsuario();

        if (usuarioPendiente == null) {
          return emit(
            BlocRegistroEstadoFaltaCompletarKyc.desde(state),
          );
        }

        switch (usuarioPendiente.estadoDeSolicitud) {
          case EstadoDeSolicitud.rechazado:
            await IsarServicio.guardarUsuarioPendiente(usuarioPendiente);
            emit(
              BlocRegistroEstadoSolicitudRechazada.desde(
                state,
              ),
            );
          case EstadoDeSolicitud.pendiente:
            await IsarServicio.guardarUsuarioPendiente(usuarioPendiente);
            emit(
              BlocRegistroEstadoSolicitudPendiente.desde(
                state,
                usuarioPendiente: usuarioPendiente,
              ),
            );
          case EstadoDeSolicitud.aprobado:
            final usuario = await client.usuario.obtenerDatosDelUsuario();

            await IsarServicio.guardarUsuario(usuario);

            await OneSignalServicio.loguearUsuario(usuario.id ?? 0);

            emit(
              BlocRegistroEstadoSolicitudAceptada.desde(
                state,
                usuario: usuario,
                userInfo: userInfo,
              ),
            );
        }
      },
      onError: (e, st) {
        cerrarSesionUsuario();
        emit(BlocRegistroEstadoErrorAlRegistrarseConGoogle.desde(state));
      },
    );
  }
}
