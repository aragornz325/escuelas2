import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:rolemissions/rolemissions.dart';

part 'bloc_carga_calificaciones_estado.dart';
part 'bloc_carga_calificaciones_evento.dart';

/// {@template BlocCargaCalificaciones}
/// Maneja la lógica principal de la pantalla 'Carga de calificaciones'
///
/// Permite cargar las calificaciones de los alumnos de un curso y
/// de una materia.
/// {@endtemplate}
class BlocCargaCalificaciones
    extends Bloc<BlocCargaCalificacionesEvento, BlocCargaCalificacionesEstado> {
  /// {@macro BlocCargaCalificaciones}
  BlocCargaCalificaciones()
      : super(const BlocCargaCalificacionesEstadoInicial()) {
    on<BlocCargaCalificacionesEventoInicializar>(_onInicializar);
    on<BlocCargaCalificacionesEventoCambiarCalificacionAlumno>(
      _onCambiarCalificacionAlumno,
    );
    on<BlocCargaCalificacionesEventoVaciarCalificaciones>(
      _onVaciarCalificaciones,
    );
    on<BlocCargaCalificacionesEventoEnviarCalificaciones>(
      _onEnviarCalificaciones,
    );

    on<BlocCargaCalificacionesEventoFiltrarListaPorFecha>(
      _onFiltrarListaPorFecha,
    );

    on<BlocCargaCalificacionesEventoGuardarFecha>(_onGuardarFecha);
  }

  /// Al iniciar la pantalla trae todos los alumnos de una fecha.
  Future<void> _onInicializar(
    BlocCargaCalificacionesEventoInicializar event,
    Emitter<BlocCargaCalificacionesEstado> emit,
  ) async {
    emit(BlocCargaCalificacionesEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final calificacionesMensuales = await client.calificacion
            .obtenerCalificacionesPorAsignaturaPorPeriodo(
          idAsignatura: event.idAsignatura,
          idComision: event.idComision,
          numeroDeAnio: DateTime.now().year,
          numeroDeMes: DateTime.now().month,
        );
// confirmo solicitud si esta aprobada y con calificaciones.
// si la soli no aprobada o pendiente, 
// Solicitud null 
// si fecha realizacion no es nula, ya completo la solicitud
        emit(
          BlocCargaCalificacionesEstadoExitoso.desde(
            state,
            comision: state.comision,
            fecha: event.fecha,
            listaCalificacionesCompensadas: [],
            calificacionesMensuales: calificacionesMensuales,
            rolDelUsuario: state.rolDelUsuario,
          ),
        );
      },
      onError: (e, st) => BlocCargaCalificacionesEstadoFallido.desde(state),
    );
  }

  /// Filtra la lista de calificaciones por fecha que le pases
  Future<void> _onFiltrarListaPorFecha(
    BlocCargaCalificacionesEventoFiltrarListaPorFecha event,
    Emitter<BlocCargaCalificacionesEstado> emit,
  ) async {
    emit(BlocCargaCalificacionesEstadoCargando.desde(state));
    // TODO(anyone): ver por que pingo no anda esto sin un delay
    // sin el delay no funciona no se rebuild-eah la screen

    await Future<void>.delayed(const Duration(microseconds: 1));

    state.listaCalificaciones.firstWhere(
      (c) => c.fechaCreacion.mismaFecha(event.fecha),
    );

    emit(
      BlocCargaCalificacionesEstadoExitoso.desde(
        state,
        calificacionesMensuales: state.calificacionesMensuales,
      ),
    );
  }

  /// Cambia la calificacion de un alumno.
  void _onCambiarCalificacionAlumno(
    BlocCargaCalificacionesEventoCambiarCalificacionAlumno event,
    Emitter<BlocCargaCalificacionesEstado> emit,
  ) {
    final alumno = state.estudiantes.firstWhere(
      (c) => c.usuarioId == event.idAlumno,
    );

    // TODO(anyone): hablar con los modelos para que la calificacion pueda ser
    // nulleable
    state.listaCalificaciones
        .firstWhere(
          (calificacion) =>
              calificacion.id ==
              state.listaCalificacionesCompensadas
                  .firstWhere(
                    (calicompensada) =>
                        calicompensada.estudianteId == alumno.usuarioId,
                  )
                  .id,
        ) // TODO(ANYONE): Cambiar por el id correspondiente
        .id = event.calificacion ?? 0;
    // TODO(ANYONE): Cambiar por el id correspondiente, cuadno este lo de back
    emit(
      BlocCargaCalificacionesEstadoExitoso.desde(
        state,
        calificacionesMensuales: state.calificacionesMensuales,
        listaCalificacionesCompensadas: state.listaCalificacionesCompensadas,
      ),
    );
  }

  /// Limpia las calificaciones de todos los alumnos
  Future<void> _onVaciarCalificaciones(
    BlocCargaCalificacionesEventoVaciarCalificaciones event,
    Emitter<BlocCargaCalificacionesEstado> emit,
  ) async {
    emit(BlocCargaCalificacionesEstadoCargando.desde(state));
    // TODO(anyone): ver por que pingo no anda esto sin un delay
    // sin el delay no funciona no se rebuild-eah la screen

    await Future<void>.delayed(const Duration(microseconds: 00001));

    final calificaciones = state.listaCalificaciones;

    for (final calificacion in calificaciones) {
      // TODO(anyone): hacer que sea nullable
      calificacion.id = 0;
      // TODO(ANYONE): Cambiar por el id correspondiente, cuadno este lo de back
    }

    emit(
      BlocCargaCalificacionesEstadoExitoso.desde(
        state,
        calificacionesMensuales: state.calificacionesMensuales,
      ),
    );
  }

  /// Envía todas las calificaciones de los alumnos
  Future<void> _onEnviarCalificaciones(
    BlocCargaCalificacionesEventoEnviarCalificaciones event,
    Emitter<BlocCargaCalificacionesEstado> emit,
  ) async {
    emit(BlocCargaCalificacionesEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        // TODO(anyone): llamar al endpoint de envio de calificacion/notas
        emit(
          BlocCargaCalificacionesEstadoCalificacionesEnviadasCorrectamente
              .desde(state),
        );
      },
      onError: (e, st) => emit(
        BlocCargaCalificacionesEstadoFallidoAlEnviarCalificaciones.desde(
          state,
        ),
      ),
    );
  }

  /// Guarda el periodo seleccionado del calendario
  void _onGuardarFecha(
    BlocCargaCalificacionesEventoGuardarFecha event,
    Emitter<BlocCargaCalificacionesEstado> emit,
  ) {
    emit(
      BlocCargaCalificacionesEstadoExitoso.desde(
        state,
        fecha: event.fecha,
      ),
    );
  }
}
