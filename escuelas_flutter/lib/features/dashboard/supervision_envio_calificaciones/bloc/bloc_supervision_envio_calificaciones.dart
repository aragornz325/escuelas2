import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
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
  /// {@macro BlocSupervisionEnvioCalificaciones}
  BlocSupervisionEnvioCalificaciones(int idComision, DateTime fecha)
      : super(
          BlocSupervisionEnvioCalificacionesEstadoInicial(
            idComision,
            fecha,
          ),
        ) {
    on<BlocSupervisionEnvioCalificacionesEventoInicializar>(_onInicializar);

    on<BlocSupervisionEnvioCalificacionesEventoSolicitarCaliFaltantes>(
      _onSolicitarCalificacionesFaltantes,
    );
    on<BlocSupervisionEnvioCalificacionesEventoEnviarCalificaciones>(
      _onEnviarCalificaciones,
    );
  }

  /// Trae las asignaturas del curso a supervisar y las guarda en el estado asi
  /// tambien la fecha del periodo a supervisar
  Future<void> _onInicializar(
    BlocSupervisionEnvioCalificacionesEventoInicializar event,
    Emitter<BlocSupervisionEnvioCalificacionesEstado> emit,
  ) async {
    emit(BlocSupervisionEnvioCalificacionesEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final fecha = event.fecha ?? state.fecha;

        final listaAsignaturas = await client.comision
            .obtenerEstadoDeEnvioDeCalificacionesPorComisionPorMes(
          idComision: state.idComision,
          anio: fecha?.year ?? 0,
          mes: fecha?.month ?? 0,
        );

        emit(
          BlocSupervisionEnvioCalificacionesEstadoExitoso.desde(
            state,
            fecha: event.fecha,
            listaAsignaturas: listaAsignaturas,
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

  /// Envia las a los profesores que faltan cargar las calificaciones
  Future<void> _onSolicitarCalificacionesFaltantes(
    BlocSupervisionEnvioCalificacionesEventoSolicitarCaliFaltantes event,
    Emitter<BlocSupervisionEnvioCalificacionesEstado> emit,
  ) async {
    emit(BlocSupervisionEnvioCalificacionesEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final respuesta =
            await client.solicitudNotaMensual.enviarSolicitudADocentes();

        if (respuesta) {
          emit(
            // ignore: lines_longer_than_80_chars
            BlocSupervisionEnvioCalificacionesEstadoExitosoAlSolicitarCaliFaltantes
                .desde(state),
          );
        }
      },
      onError: (e, st) => emit(
        BlocSupervisionEnvioCalificacionesEstadoError.desde(state),
      ),
    );
  }

  /// Envia todas las calificaciones a los padres/alumnos
  Future<void> _onEnviarCalificaciones(
    BlocSupervisionEnvioCalificacionesEventoEnviarCalificaciones event,
    Emitter<BlocSupervisionEnvioCalificacionesEstado> emit,
  ) async {
    emit(BlocSupervisionEnvioCalificacionesEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final respuesta =
            await client.calificacion.enviarCalificacionesPorMesYAnio(
          anio: state.fecha?.year ?? 0,
          mes: state.fecha?.month ?? 0,
          filtroDeEnvio: EnvioCalificaciones.porComision,
          idComisiones: [
            state.idComision,
          ],
        );
        if (respuesta) {
          emit(
            BlocSupervisionEnvioCalificacionesEstadoExitosoAlEnviarCalificaciones
                .desde(state),
          );
        }
      },
      onError: (e, st) => emit(
        BlocSupervisionEnvioCalificacionesEstadoError.desde(state),
      ),
    );
  }
}
