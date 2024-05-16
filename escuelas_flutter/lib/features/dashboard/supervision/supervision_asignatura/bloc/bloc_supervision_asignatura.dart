import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
part 'bloc_supervision_asignatura_estado.dart';
part 'bloc_supervision_asignatura_evento.dart';

/// {@template BlocSupervisionAsignatura}
/// Maneja la lógica principal de la pantalla 'supervision de asignatura'
///
/// Permite enviar mails a los alumnos
/// {@endtemplate}
class BlocSupervisionAsignatura extends Bloc<BlocSupervisionAsignaturaEvento,
    BlocSupervisionAsignaturaEstado> {
  /// {@macro BlocSupervisionAsignatura}
  BlocSupervisionAsignatura({required this.fecha})
      : super(BlocSupervisionAsignaturaEstadoInicial(fecha: fecha)) {
    on<BlocSupervisionAsignaturaEventoInicializar>(_onInicializar);
    on<BlocSupervisionAsignaturaEnviarEmailAEstudiante>(
      _onEnviarEmailAEstudiante,
    );
    on<BlocCargaCalificacionesEventoAgregarCalificacion>(
      _onAgregarCalificacion,
    );
    on<BlocSupervisionAsignaturaEnviarEmailsAsingatura>(
      _onEnviarEmailAsignatura,
    );
    on<BlocSupervisionAsignaturaActualizarCalificaciones>(
      _onActualizarCalificaciones,
    );
  }

  /// Fecha de la pantalla anterior
  final DateTime fecha;

  /// Al iniciar la pantalla trae todos los alumnos de una fecha.
  Future<void> _onInicializar(
    BlocSupervisionAsignaturaEventoInicializar event,
    Emitter<BlocSupervisionAsignaturaEstado> emit,
  ) async {
    emit(BlocSupervisionAsignaturaEstadoCargando.desde(state));
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
          BlocSupervisionAsignaturaEstadoExitoso.desde(
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
      onError: (e, st) => BlocSupervisionAsignaturaEstadoFallido.desde(state),
    );
  }

  /// Envia un mail al estudiante
  Future<void> _onEnviarEmailAEstudiante(
    BlocSupervisionAsignaturaEnviarEmailAEstudiante event,
    Emitter<BlocSupervisionAsignaturaEstado> emit,
  ) async {
    emit(BlocSupervisionAsignaturaEstadoEnviandoEmail.desde(state));
    await operacionBloc(
      callback: (client) async {
        await client.calificacion.enviarCalificacionesPorMesYAnio(
          anio: state.fecha?.year ?? 0,
          mes: state.fecha?.month ?? 0,
          filtroDeEnvio: EnvioCalificaciones.porEstudiante,
          idEstudiantes: [
            event.estudiante?.id ?? 0,
          ],
        );

        emit(
          BlocSupervisionAsignaturaEstadoExitosoAlEnviarEmail.desde(
            state,
            nombreEstudiante:
                '${event.estudiante?.nombre} ${event.estudiante?.apellido}',
          ),
        );
      },
      onError: (e, st) => BlocSupervisionAsignaturaEstadoFallido.desde(state),
    );
  }

  /// Envia un mail a la asignatura
  Future<void> _onEnviarEmailAsignatura(
    BlocSupervisionAsignaturaEnviarEmailsAsingatura event,
    Emitter<BlocSupervisionAsignaturaEstado> emit,
  ) async {
    emit(BlocSupervisionAsignaturaEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        await client.calificacion.enviarCalificacionesPorMesYAnio(
          anio: state.fecha?.year ?? 0,
          mes: state.fecha?.month ?? 0,
          filtroDeEnvio: EnvioCalificaciones.porAsignatura,
          idAsignaturas: [state.asignatura?.id ?? 0],
          idComisiones: [state.comision?.id ?? 0],
        );

        emit(BlocSupervisionAsignaturaEstadoExitoso.desde(state));
      },
      onError: (e, st) => BlocSupervisionAsignaturaEstadoFallido.desde(state),
    );
  }

  /// Envía todas las calificaciones de los alumnos
  Future<void> _onActualizarCalificaciones(
    BlocSupervisionAsignaturaActualizarCalificaciones event,
    Emitter<BlocSupervisionAsignaturaEstado> emit,
  ) async {
    emit(BlocSupervisionAsignaturaEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final haySolicitud =
            state.calificacionesMensuales?.solicitudNotaMensual != null;

        final solicitudEstaRealizada = state.calificacionesMensuales
                ?.solicitudNotaMensual?.solicitud?.fechaRealizacion !=
            null;
        if (haySolicitud) {
          if (solicitudEstaRealizada) {
            await client.calificacion.actualizarCalificacionesMensualesEnLote(
              calificacionesMensuales: state.listaCalificacionesMesActual,
            );
            emit(
              BlocSupervisionAsignaturaEstadoCalificacionesActualizadas.desde(
                state,
              ),
            );
          } else {
            await client.calificacion.cargarCalificacionesMensualesPorSolicitud(
              calificacionesMensuales: state.listaCalificacionesMesActual,
              idSolicitud: state.calificacionesMensuales?.solicitudNotaMensual
                      ?.solicitudId ??
                  0,
            );
            emit(
              BlocSupervisionAsignaturaEstadoCalificacionesActualizadas.desde(
                state,
              ),
            );
          }
        } else {
          // TODO(anyone): Crear una solicitud de actualización de las notas existentes
          // para q la apruebe el directivo
        }
      },
      onError: (e, st) =>
          emit(BlocSupervisionAsignaturaEstadoFallido.desde(state)),
    );
  }

  /// Guarda el periodo seleccionado del calendario
  void _onAgregarCalificacion(
    BlocCargaCalificacionesEventoAgregarCalificacion event,
    Emitter<BlocSupervisionAsignaturaEstado> emit,
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
      BlocSupervisionAsignaturaEstadoExitoso.desde(
        state,
        listaCalificacionesMesActual: lista,
      ),
    );
  }
}
