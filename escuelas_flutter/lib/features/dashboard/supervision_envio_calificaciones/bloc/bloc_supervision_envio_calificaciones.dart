import 'package:escuelas_client/escuelas_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_supervision_envio_calificaciones_estado.dart';
part 'bloc_supervision_envio_calificaciones_evento.dart';

/// {@template BlocSupervisionEnvioCalificaciones}
/// Bloc que maneja los estados y lógica de la pagina de 'Inicio'
/// {@endtemplate}
class BlocSupervisionEnvioCalificaciones extends Bloc<
    BlocSupervisionEnvioCalificacionesEvento,
    BlocSupervisionEnvioCalificacionesEstado> {
  /// {@macro BlocInicio}
  BlocSupervisionEnvioCalificaciones()
      : super(const BlocSupervisionEnvioCalificacionesEstadoInicial()) {
    on<BlocSupervisionEnvioCalificacionesEventoInicializar>(_onInicializar);
  }
  Future<void> _onInicializar(
    BlocSupervisionEnvioCalificacionesEventoInicializar event,
    Emitter<BlocSupervisionEnvioCalificacionesEstado> emit,
  ) async {
    emit(BlocSupervisionEnvioCalificacionesEstadoCargando.desde(state));
    try {
      // final listaAsignaturas = await client.obtenerAsignaturasDeCurso(evento.idCurso, evento.idPeriodo);
      emit(
        BlocSupervisionEnvioCalificacionesEstadoExitoso.desde(
          state,
          fecha: event.fecha,
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
              fechaCreacion: DateTime.now().add(Duration(days: 6)),
            ),
            Asignatura(
              id: 1,
              nombre: 'Matematicas',
              idCurso: 1,
              docentes: [],
              ultimaModificacion: DateTime.now().add(Duration(days: 3)),
              fechaCreacion: DateTime.now().add(Duration(days: 3)),
            ),
            Asignatura(
              id: 1,
              nombre: 'Matematicas',
              idCurso: 1,
              docentes: [],
              ultimaModificacion: DateTime.now(),
              fechaCreacion: DateTime.now().add(Duration(days: 10)),
            ),
          ],
        ),
      );
    } catch (e) {
      emit(
        BlocSupervisionEnvioCalificacionesEstadoError.desde(
          state,
        ),
      );
    }
  }
}
