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

    on<BlocDashboardEventoObtenerAsignaturaYComision>(
      _onObtenerAsignaturaYComision,
    );
    on<BlocDashboardEventoCambiarContrasenia>(_onCambiarContrasenia);
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
  Future<void> _onObtenerAsignaturaYComision(
    BlocDashboardEventoObtenerAsignaturaYComision event,
    Emitter<BlocDashboardEstado> emit,
  ) async {
    emit(BlocDashboardEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        final asignatura = await client.asignatura
            .obtenerAsignaturaPorId(id: event.idAsignatura);

        final comision = await client.comision.obtenerComisionesDeCursoPorId(
          idComision: event.idComision,
        );
        emit(
          BlocDashboardEstadoExitoso.desde(
            state,
            usuario: state.usuario,
            asignatura: asignatura,
            comision: comision,
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

  /// Cambia la contrasenia del usuario
  Future<void> _onCambiarContrasenia(
    BlocDashboardEventoCambiarContrasenia event,
    Emitter<BlocDashboardEstado> emit,
  ) async {
    emit(BlocDashboardEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        await client.userInfo.cambiarPasswordDelUsuario(
          nuevaPassword: event.nuevaContrasenia,
        );

        final usuario = state.usuario..necesitaCambiarPassword = false;

        emit(
          BlocDashboardEstadoExitosoAlCambiarLaContrasenia.desde(
            state,
            usuario: usuario,
          ),
        );
      },
      onError: (e, st) => emit(BlocDashboardEstadoFallido.desde(state)),
    );
  }
}
