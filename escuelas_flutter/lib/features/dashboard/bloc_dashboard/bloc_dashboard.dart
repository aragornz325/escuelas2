import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/features/pantalla_inicio/bloc/bloc_inicio.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_dashboard_estado.dart';
part 'bloc_dashboard_evento.dart';

/// {@template BlocDashboard}
/// Se encarga de manejar los procesos compartidos
/// por más de una página que ocurren dentro de dashboard.
/// {@endtemplate}
class BlocDashboard extends Bloc<BlocDashboardEvento, BlocDashboardEstado> {
  /// {@macro BlocDashboard}
  BlocDashboard(
    InfoUsuario infoUsuario,
  ) : super(BlocDashboardEstadoInicial(infoUsuario)) {
    on<BlocDashboardEventoTraerInformacion>(_verificarUsuarioLogueado);
  }

  /// Se encarga de verificar si el usuario está logueado
  Future<void> _verificarUsuarioLogueado(
    BlocDashboardEventoTraerInformacion event,
    Emitter<BlocDashboardEstado> emit,
  ) async {
    emit(BlocDashboardEstadoCargando.desde(super.state));
    await operacionBloc(
      callback: (client) async {
        // TODO(ANYONE): Descomentar luego
        //(client) async {
        // final respuesta = await client.cliente.comprobarKyc(
        //   sessionManager.signedInUser?.id ?? 0,
        // );

        // if (!respuesta) {
        //   emit(BlocDashboardEstadoFaltaCompletarKyc.desde(super.state));
        // } else {
        //   emit(BlocDashboardEstadoLogueoExitoso.desde(super.state));
        // }
        emit(BlocDashboardEstadoLogueoExitoso.desde(super.state));
      },
      onError: (e, st) {
        emit(BlocDashboardEstadoLogueoFallido.desde(super.state));
      },
    );
  }
}
