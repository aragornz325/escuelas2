import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/utilidades/funciones/funciones.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_supervision_envio_calificaciones_estado.dart';
part 'bloc_supervision_envio_calificaciones_evento.dart';

/// {@template BlocSupervisionEnvioCalificaciones}
/// Bloc que maneja los estados y lógica de la pagina de
/// 'Supervision de envio de Calificaciones'
/// {@endtemplate}
class BlocSupervisionEnvioCalificaciones extends Bloc<
    BlocSupervisionEnvioCalificacionesEvento,
    BlocSupervisionEnvioCalificacionesEstado> {
  /// {@macro BlocSupervision de envio de Calificaciones}
  BlocSupervisionEnvioCalificaciones()
      : super(const BlocSupervisionEnvioCalificacionesEstadoInicial()) {
    on<BlocSupervisionEnvioCalificacionesEventoInicializar>(_onInicializar);
  }

  /// Trae las asignaturas del curso a supervisar y las guarda en el estado asi
  /// tambien la fecha del periodo a supervisar
  Future<void> _onInicializar(
    BlocSupervisionEnvioCalificacionesEventoInicializar event,
    Emitter<BlocSupervisionEnvioCalificacionesEstado> emit,
  ) async {
    emit(BlocSupervisionEnvioCalificacionesEstadoCargando.desde(state));
    await operacionBloc(
      callback: () async {
        // TODO(anyone): Descomentar cuando haya endpoint
        // final listaAsignaturas =
        //awaitclient.obtenerAsignaturasDeCurso(event.idCurso,event.idPeriodo);
        emit(
          BlocSupervisionEnvioCalificacionesEstadoExitoso.desde(
            state,
            fecha: event.fecha,
            // TODO(anyone): Cambiar por la lista de asignaturas que vienen del back
            listaAsignaturas: [
              Asignatura(
                id: 1,
                nombre: 'Matematicas',
                idCurso: 1,
                docentes: [],
                ultimaModificacion: DateTime.now(),
                fechaCreacion: DateTime.now(),
              ),
              Asignatura(
                id: 1,
                nombre: 'Matematicas',
                idCurso: 1,
                docentes: [],
                ultimaModificacion: DateTime.now(),
                fechaCreacion: DateTime.now().add(const Duration(days: 6)),
              ),
              Asignatura(
                id: 1,
                nombre: 'Matematicas',
                idCurso: 1,
                docentes: [],
                ultimaModificacion: DateTime.now().add(const Duration(days: 3)),
                fechaCreacion: DateTime.now().add(const Duration(days: 3)),
              ),
              Asignatura(
                id: 1,
                nombre: 'Matematicas',
                idCurso: 1,
                docentes: [],
                ultimaModificacion: DateTime.now(),
                fechaCreacion: DateTime.now().add(const Duration(days: 10)),
              ),
            ],
          ),
        );
      },
      onError: (e, st) {
        emit(
          BlocSupervisionEnvioCalificacionesEstadoError.desde(state),
        );
      },
    );
  }
}
