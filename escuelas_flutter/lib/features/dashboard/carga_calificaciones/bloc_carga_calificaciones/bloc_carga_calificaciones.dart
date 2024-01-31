import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:escuelas_flutter/features/dashboard/carga_calificaciones/modelos/modelos.dart';

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
    on<BlocCargaCalificacionesEventoVaciarCalificaciones>(
      _onVaciarCalificaciones,
    );
    on<BlocCargaCalificacionesEventoEnviarCalificaciones>(
      _onEnviarCalificaciones,
    );
    on<BlocCargaCalificacionesEventoGuardarFecha>(_onGuardarFecha);
    on<BlocCargaCalificacionesEventoAgregarCalificacion>(
      _onAgregarCalificacion,
    );
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
            .obtenerCalificacionesPorAsignaturaPorPeriodoPorComision(
          idAsignatura: event.idAsignatura,
          idComision: event.idComision,
          numeroDeAnio: DateTime.now().year,
          numeroDeMes: DateTime.now().month,
        );

        final asignatura = await client.asignatura
            .obtenerAsignaturaPorId(id: event.idAsignatura);

        final comision = await client.comision
            .obtenerComisionesDeCursoPorId(idComision: event.idComision);

        //  confirmo solicitud si esta aprobada y con calificaciones.
        // si la soli no aprobada o pendiente,
        // Solicitud null
        // si fecha realizacion no es nula, ya completo la solicitud
        emit(
          BlocCargaCalificacionesEstadoExitoso.desde(
            state,
            asignatura: asignatura,
            comision: comision,
            fecha: event.fecha,
            calificacionesMensuales: calificacionesMensuales,
          ),
        );
      },
      onError: (e, st) => BlocCargaCalificacionesEstadoFallido.desde(state),
    );
  }

  /// Limpia las calificaciones de todos los alumnos
  Future<void> _onVaciarCalificaciones(
    BlocCargaCalificacionesEventoVaciarCalificaciones event,
    Emitter<BlocCargaCalificacionesEstado> emit,
  ) async {
    emit(BlocCargaCalificacionesEstadoCargando.desde(state));

    emit(
      BlocCargaCalificacionesEstadoExitosoAlBorrarCalificacionesCargadas.desde(
        state,
        listaCalificaciones: [],
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
        // TODO(ANYONE): Front asegurarse de q la lista de calificaciones fueron modificadas por el profesor
        // TODO(ANYONE): el valor index etc de CADA UNA.
        await client.calificacion.cargarCalificacionesMensualesPorSolicitud(
          calificacionesMensuales:
              state.calificacionesMensuales?.calificacionesMensuales ?? [],
          idSolicitud: state
                  .calificacionesMensuales?.solicitudNotaMensual?.solicitudId ??
              0,
        );
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

  /// Guarda el periodo seleccionado del calendario
  void _onAgregarCalificacion(
    BlocCargaCalificacionesEventoAgregarCalificacion event,
    Emitter<BlocCargaCalificacionesEstado> emit,
  ) {
    final lista = List<CalificacionDeAlumno>.from(state.listaCalificaciones);

    final estaCargada = state.listaCalificaciones.any(
      (calificacion) => calificacion.idAlumno == event.idAlumno,
    );

    if (estaCargada) {
      lista
        ..removeWhere(
          (calificacion) => calificacion.idAlumno == event.idAlumno,
        )
        ..add(
          CalificacionDeAlumno(
            idAlumno: event.idAlumno,
            calificacion: event.calificacion,
          ),
        );
    } else {
      lista.add(
        CalificacionDeAlumno(
          idAlumno: event.idAlumno,
          calificacion: event.calificacion,
        ),
      );
    }
    emit(
      BlocCargaCalificacionesEstadoExitoso.desde(
        state,
        listaCalificaciones: lista,
      ),
    );
  }
}
