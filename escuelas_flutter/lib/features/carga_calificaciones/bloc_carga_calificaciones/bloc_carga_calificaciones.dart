import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/features/asistencias/bloc_asistencias/bloc_asistencias.dart';
import 'package:escuelas_flutter/utilidades/funciones/operacion_bloc.dart';
import 'package:escuelas_flutter/widgets/selector_de_periodo/delegates/periodo_delegate.dart';

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
    on<BlocCargaCalificacionesEventoGuardarPeriodo>(_onGuardarPeriodo);
  }

  /// Al iniciar la pantalla trae todos los alumnos de una fecha.
  Future<void> _onInicializar(
    BlocCargaCalificacionesEventoInicializar event,
    Emitter<BlocCargaCalificacionesEstado> emit,
  ) async {
    emit(BlocCargaCalificacionesEstadoCargando.desde(state));
    await operacionBloc(
      callback: () async {
        // TODO(anyone): llamar al endpoint de traer calificaciones
        // y borrar la lista hardcodeada.
        final lista = [
          ModeloCalificacion(
            id: 1,
            fecha: DateTime.now(),
            alumnos: [
              ModeloAlumno(
                id: 1,
                nombre: 'Gonzalo',
                asistencia: EstadoAsistencia.sinAsistencia,
                calificacion: 5,
              ),
              ModeloAlumno(
                id: 2,
                nombre: 'Matias',
                asistencia: EstadoAsistencia.sinAsistencia,
                calificacion: 1,
              ),
              ModeloAlumno(
                id: 3,
                nombre: 'Sebas',
                asistencia: EstadoAsistencia.sinAsistencia,
                calificacion: 11,
              ),
              ModeloAlumno(
                id: 4,
                nombre: 'Manu',
                asistencia: EstadoAsistencia.sinAsistencia,
                calificacion: 9,
              ),
            ],
          ),
          ModeloCalificacion(
            id: 1,
            fecha: DateTime(2023, 12, 31),
            alumnos: [
              ModeloAlumno(
                id: 1,
                nombre: 'Gonzalo',
                asistencia: EstadoAsistencia.sinAsistencia,
                calificacion: 10,
              ),
              ModeloAlumno(
                id: 2,
                nombre: 'Matias',
                asistencia: EstadoAsistencia.sinAsistencia,
                calificacion: 5,
              ),
              ModeloAlumno(
                id: 3,
                nombre: 'Sebas',
                asistencia: EstadoAsistencia.sinAsistencia,
                calificacion: 10,
              ),
              ModeloAlumno(
                id: 4,
                nombre: 'Manu',
                asistencia: EstadoAsistencia.sinAsistencia,
                calificacion: 8,
              ),
            ],
          ),
          ModeloCalificacion(
            id: 1,
            fecha: DateTime(2024, 2, 10),
            alumnos: [
              ModeloAlumno(
                id: 1,
                nombre: 'Gonzalo',
                asistencia: EstadoAsistencia.sinAsistencia,
                calificacion: 1,
              ),
              ModeloAlumno(
                id: 2,
                nombre: 'Matias',
                asistencia: EstadoAsistencia.sinAsistencia,
                calificacion: 1,
              ),
              ModeloAlumno(
                id: 3,
                nombre: 'Sebas',
                asistencia: EstadoAsistencia.sinAsistencia,
                calificacion: 1,
              ),
              ModeloAlumno(
                id: 4,
                nombre: 'Manu',
                asistencia: EstadoAsistencia.sinAsistencia,
                calificacion: 1,
              ),
            ],
          ),
        ];

        final calificacion = lista.firstWhere(
          (c) =>
              c.fecha.year == event.fecha.year &&
              c.fecha.month == event.fecha.month,
        );

        emit(
          BlocCargaCalificacionesEstadoExitoso.desde(
            state,
            listaCalificaciones: lista,
            calificacion: calificacion,
            rolDelUsuario: RolDeUsuario(
              id: 1,
              nombre: 'docente',
              descripcion: '',
              fechaCreacion: DateTime.now(),
              ultimaModificacion: DateTime.now(),
            ),
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

    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(microseconds: 1));

    final calificacion = state.listaCalificaciones.firstWhere(
      (c) =>
          c.fecha.month == event.fecha.month &&
          c.fecha.year == event.fecha.year,
      orElse: () => ModeloCalificacion(
        id: state.calificacion?.id ?? 1,
        fecha: event.fecha,
        alumnos: state.calificacion?.alumnos ?? [],
      ),
    );

    emit(
      BlocCargaCalificacionesEstadoExitoso.desde(
        state,
        calificacion: calificacion,
      ),
    );
  }

  /// Cambia la calificacion de un alumno.
  void _onCambiarCalificacionAlumno(
    BlocCargaCalificacionesEventoCambiarCalificacionAlumno event,
    Emitter<BlocCargaCalificacionesEstado> emit,
  ) {
    final calificacion = state.calificacion;
    final alumno =
        calificacion?.alumnos.firstWhere((e) => e.id == event.idAlumno);

    alumno?.calificacion = event.calificacion;

    state.listaCalificaciones
        .firstWhere((e) => e.id == calificacion?.id)
        .alumnos = calificacion?.alumnos ?? [];

    emit(
      BlocCargaCalificacionesEstadoExitoso.desde(
        state,
        calificacion: state.calificacion,
        listaCalificaciones: state.listaCalificaciones,
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

    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(microseconds: 00005));

    final calificacion = state.calificacion;

    if (calificacion != null) {
      for (final a in calificacion.alumnos) {
        a.calificacion = null;
      }
    }

    emit(
      BlocCargaCalificacionesEstadoExitoso.desde(
        state,
        calificacion: state.calificacion,
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
      callback: () async {
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
  void _onGuardarPeriodo(
    BlocCargaCalificacionesEventoGuardarPeriodo event,
    Emitter<BlocCargaCalificacionesEstado> emit,
  ) {
    emit(
      BlocCargaCalificacionesEstadoExitoso.desde(
        state,
        periodo: event.periodo,
      ),
    );
  }
}
