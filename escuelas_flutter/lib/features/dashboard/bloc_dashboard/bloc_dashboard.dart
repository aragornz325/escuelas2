import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/isar/isar_servicio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serverpod_auth_client/module.dart';

part 'bloc_dashboard_estado.dart';
part 'bloc_dashboard_evento.dart';

/// {@template BlocDashboard}
/// Se encarga de manejar los procesos compartidos
/// por más de una página que ocurren dentro de dashboard.
/// {@endtemplate}
class BlocDashboard extends Bloc<BlocDashboardEvento, BlocDashboardEstado> {
  /// {@macro BlocDashboard}
  BlocDashboard({
    required UserInfo infoUsuario,
    required Usuario usuario,
  }) : super(
          BlocDashboardEstadoInicial(
            usuario: usuario,
            infoUsuario: infoUsuario,
          ),
        ) {
    on<BlocDashboardEventoInicializar>(_onInicializar);
    on<BlocDashboardEventoObtenerAsignatura>(_onObtenerAsignatura);
  }

  /// Evento inicial donde trae todos los cursos del usuario.
  Future<void> _onInicializar(
    BlocDashboardEventoInicializar event,
    Emitter<BlocDashboardEstado> emit,
  ) async {
    emit(BlocDashboardEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        final usuario = await client.usuario.obtenerDatosDelUsuario();

        await IsarServicio.guardarUsuario(usuario);

        emit(
          BlocDashboardEstadoExitoso.desde(
            state,
            usuario: usuario,
          ),
        );
      },
      onError: (e, st) {
        emit(
          BlocDashboardEstadoFallido.desde(state),
        );
      },
    );
  }

  /// Evento para obtener la asignatura y la comision.
  Future<void> _onObtenerAsignatura(
    BlocDashboardEventoObtenerAsignatura event,
    Emitter<BlocDashboardEstado> emit,
  ) async {
    emit(BlocDashboardEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        // TODO: hacer funcion par abtener la comision.
        final asignatura = await client.asignatura
            .obtenerAsignaturaPorId(id: event.idAsignatura);

        emit(
          BlocDashboardEstadoExitoso.desde(
            state,
            usuario: state.usuario,
            asignatura: asignatura,
          ),
        );
      },
      onError: (e, st) {
        emit(
          BlocDashboardEstadoFallido.desde(state),
        );
      },
    );
  }
}
