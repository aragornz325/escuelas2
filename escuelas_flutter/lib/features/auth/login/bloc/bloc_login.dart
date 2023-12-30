import 'package:escuelas_flutter/extensiones/extension_bloc.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';
import 'package:escuelas_flutter/utilidades/funciones/expresion_regular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_login_estado.dart';
part 'bloc_login_evento.dart';

/// {@template BlocLogin}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocLogin extends Bloc<BlocLoginEvento, BlocLoginEstado> {
  /// {@macro BlocLogin}
  BlocLogin() : super(const BlocLoginEstadoInicial()) {
    on<BlocLoginEventoHabilitarBotonIngresar>(_habilitarBotonIngresar);
    on<BlocLoginEventoIniciarSesionConCredenciales>(
      _iniciarSesionConCredenciales,
    );
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

  Future<void> _iniciarSesionConCredenciales(
    BlocLoginEventoIniciarSesionConCredenciales event,
    Emitter<BlocLoginEstado> emit,
  ) async {
    emit(BlocLoginEstadoCargando.desde(state, estaIniciandoSesion: true));
    await operacionBloc(
        callback: (client) async {
          final userInfo = await emailaut;
        },
        onError: onError);
  }
}
