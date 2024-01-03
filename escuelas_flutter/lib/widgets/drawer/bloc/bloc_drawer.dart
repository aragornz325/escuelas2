import 'dart:math';

import 'package:escuelas_flutter/extensiones/extension_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_drawer_estado.dart';
part 'bloc_drawer_evento.dart';

/// {@template BlocDrawer}
/// Bloc que maneja los estados y lógica del componente EscuelasDrawer de
/// [BlocDrawer]
/// {@endtemplate}
class BlocDrawer extends Bloc<BlocDrawerEvento, BlocDrawerEstado> {
  /// {@macro BlocDrawer}
  BlocDrawer()
      : super(
          const BlocDrawerEstadoInicial(),
        ) {
    on<BlocDrawerEventoCerrarSesion>(_cerrarSesion);
    on<BlocDrawerEventoCambiarDeDrawerPage>(_onCambiarPageDrawer);
  }

  /// Trata de cerrar la sesión de un usuario.
  ///
  /// En caso de error, devuelve un mensaje de fallo
  /// de cierre de sesión.
  Future<void> _cerrarSesion(
    BlocDrawerEventoCerrarSesion event,
    Emitter<BlocDrawerEstado> emit,
  ) async {
    emit(BlocDrawerEstadoCargando.desde(state));

    await operacionBloc(
      callback: () async {
        //(client) async {
        final cerroSesion = Random().nextBool();
        // await sessionManager.signOut();
// TODO(ANYONE): Descomentar luego.
        if (cerroSesion) {
          emit(
            BlocDrawerEstadoExitosoGeneral.desde(
              state,
              cerroSesion: cerroSesion,
            ),
          );
        } else {
          emit(
            BlocDrawerEstadoError.desde(state),
          );
        }
      },
      onError: (e, st) {
        emit(
          BlocDrawerEstadoError.desde(state),
        );
      },
    );
  }

  /// Cambia de Page en el Drawer seleccionado.
  Future<void> _onCambiarPageDrawer(
    BlocDrawerEventoCambiarDeDrawerPage event,
    Emitter<BlocDrawerEstado> emit,
  ) async {
    emit(
      BlocDrawerEstadoCambioDePagina.desde(
        state,

        //    pageDrawer: event.pageDrawer,
      ),
    );
  }
}
