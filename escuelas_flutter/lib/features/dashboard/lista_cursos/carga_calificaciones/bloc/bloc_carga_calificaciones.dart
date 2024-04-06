import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
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
  BlocCargaCalificaciones({required this.fecha})
      : super(BlocCargaCalificacionesEstadoInicial(fecha: fecha)) {
    on<BlocCargaCalificacionesEventoInicializar>(_onInicializar);
    on<BlocCargaCalificacionesEventoAgregarCalificacion>(
      _onAgregarCalificacion,
    );
    on<BlocCargaCalificacionesEventoVaciarCalificaciones>(
      _onVaciarCalificaciones,
    );
    on<BlocCargaCalificacionesEventoEnviarCalificaciones>(
      _onEnviarCalificaciones,
    );
  }

  /// Fecha de la pantalla anterior
  final DateTime fecha;

  /// Al iniciar la pantalla trae todos los alumnos de una fecha.
  Future<void> _onInicializar(
    BlocCargaCalificacionesEventoInicializar event,
    Emitter<BlocCargaCalificacionesEstado> emit,
  ) async {
    emit(BlocCargaCalificacionesEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final asignatura = await client.asignatura
            .obtenerAsignaturaPorId(id: event.idAsignatura);

        final comision = await client.comision
            .obtenerComisionesDeCursoPorId(idComision: event.idComision);

        final calificacionesMensuales = await client.calificacion
            .obtenerCalificacionesPorAsignaturaPorPeriodoPorComision(
          idAsignatura: event.idAsignatura,
          idComision: event.idComision,
          numeroDeAnio: event.fecha?.year ?? fecha.year,
          numeroDeMes: event.fecha?.month ?? fecha.month,
        );

        var listaCalificacionesMesActual =
            calificacionesMensuales.calificacionesMensualesPorPeriodo
                    .firstWhereOrNull(
                      (listaCalificacionMensual) =>
                          listaCalificacionMensual.any(
                        (calificacionMensual) =>
                            calificacionMensual.numeroDeMes ==
                            (event.fecha?.month ?? fecha.month),
                      ),
                    )
                    ?.toList() ??
                [];

        if (listaCalificacionesMesActual.isEmpty) {
          comision.estudiantes?.sort((a, b) =>
              a.usuario?.apellido.compareTo(b.usuario?.apellido ?? '') ?? 0);
          listaCalificacionesMesActual =
              comision.estudiantes?.map((relacionComisionUsuario) {
                    return CalificacionMensual(
                      calificacion: Calificacion(
                        asignaturaId: event.idAsignatura,
                        idComision: event.idComision,
                        estudianteId: relacionComisionUsuario.usuarioId,
                        fechaCreacion: DateTime.now(),
                        ultimaModificacion: DateTime.now(),
                        idAutor: event.idAutor,
                        idInstanciaDeEvaluacion: 1,
                        tipoCalificacion: TipoCalificacion.numericoDecimal,
                        index: 0,
                        diferencial: '0',
                      ),
                      numeroDeAnio: DateTime.now().year,
                      numeroDeMes: event.fecha?.month ?? fecha.month,
                      calificacionId: 0,
                    );
                  }).toList() ??
                  [];
        }
        final listaCalificacionesMesesRestantes = calificacionesMensuales
            .calificacionesMensualesPorPeriodo
            .where(
              (element) => element.any(
                (element) =>
                    element.numeroDeMes != (event.fecha?.month ?? fecha.month),
              ),
            )
            .toList();

        emit(
          BlocCargaCalificacionesEstadoExitoso.desde(
            state,
            asignatura: asignatura,
            comision: comision,
            fecha: event.fecha,
            listaCalificacionesMesActual: listaCalificacionesMesActual,
            listaCalificacionesMesesRestantes:
                listaCalificacionesMesesRestantes,
            calificacionesMensuales: calificacionesMensuales,
          ),
        );
      },
      onError: (e, st) => BlocCargaCalificacionesEstadoFallido.desde(state),
    );
  }

  /// Guarda el periodo seleccionado del calendario
  void _onAgregarCalificacion(
    BlocCargaCalificacionesEventoAgregarCalificacion event,
    Emitter<BlocCargaCalificacionesEstado> emit,
  ) {
    final lista = List<CalificacionMensual>.from(
      state.listaCalificacionesMesActual,
    );

    final calificacionModificada = lista.firstWhere(
      (calificacionMensual) =>
          calificacionMensual.calificacion?.estudianteId == event.idAlumno,
    );

    lista
      ..removeWhere(
        (calificacionMensual) =>
            calificacionMensual.calificacion?.estudianteId == event.idAlumno,
      )
      ..add(
        calificacionModificada
          ..calificacion?.index = int.parse(event.calificacion),
      );

    emit(
      BlocCargaCalificacionesEstadoExitoso.desde(
        state,
        listaCalificacionesMesActual: lista,
      ),
    );
  }

  /// Limpia las calificaciones de todos los alumnos
  Future<void> _onVaciarCalificaciones(
    BlocCargaCalificacionesEventoVaciarCalificaciones event,
    Emitter<BlocCargaCalificacionesEstado> emit,
  ) async {
    final lista = List<CalificacionMensual>.from(
      state.listaCalificacionesMesActual,
    );
    for (final calificacionMensual in lista) {
      calificacionMensual.calificacion?.index = 0;
    }
    emit(
      BlocCargaCalificacionesEstadoExitoAlBorrarCalificacionesCargadas.desde(
        state,
        listaCalificacionesMesActual: lista,
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
        final haySolicitud =
            state.calificacionesMensuales?.solicitudNotaMensual != null;

        final estaRealizada = state.calificacionesMensuales
                ?.solicitudNotaMensual?.solicitud?.fechaRealizacion !=
            null;

        if (haySolicitud) {
          if (estaRealizada) {
            await client.calificacion.actualizarCalificacionesMensualesEnLote(
              calificacionesMensuales: state.listaCalificacionesMesActual,
            );
            emit(
              BlocCargaCalificacionesEstadoCalificacionesEnviadasCorrectamente
                  .desde(state),
            );
          } else {
            await client.calificacion.cargarCalificacionesMensualesPorSolicitud(
              calificacionesMensuales: state.listaCalificacionesMesActual,
              idSolicitud: state.calificacionesMensuales?.solicitudNotaMensual
                      ?.solicitudId ??
                  0,
            );
            emit(
              BlocCargaCalificacionesEstadoCalificacionesEnviadasCorrectamente
                  .desde(state),
            );
          }
        } else {
          // TODO(anyone): handlear el caso en que no hay solicitud
        }
      },
      onError: (e, st) => emit(
        BlocCargaCalificacionesEstadoFallidoAlEnviarCalificaciones.desde(
          state,
        ),
      ),
    );
  }
}
