import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/features/dashboard/supervision_comisiones/pagina_supervision_comisiones.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_supervision_comisiones_estado.dart';
part 'bloc_supervision_comisiones_evento.dart';

/// {@template BlocSupervisionComisiones}
/// Bloc que maneja los estados y lógica de la [PaginaSupervisionComisiones]
/// {@endtemplate}
class BlocSupervisionComisiones extends Bloc<BlocSupervisionComisionesEvento,
    BlocSupervisionComisionesEstado> {
  /// {@macro BlocSupervisionComisiones}
  BlocSupervisionComisiones()
      : super(const BlocSupervisionComisionEstadoInicial()) {
    on<BlocSupervisionComisionesEventoInicializar>(_inicializar);
  }

  Future<void> _inicializar(
    BlocSupervisionComisionesEventoInicializar event,
    Emitter<BlocSupervisionComisionesEstado> emit,
  ) async {
    emit(BlocSupervisionComisionEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        final listaComisiones = await client.comision
            .obtenerComisionesConSolicitudesCalificacionMensual(
          anio: event.fecha.year,
          mes: event.fecha.month,
        );

        emit(
          BlocSupervisionComisionEstadoExitoso.desde(
            state,
            fecha: event.fecha,
            listaSupervisionComisiones: listaComisiones,
          ),
        );
      },
      onError: (e, st) => emit(
        BlocSupervisionComisionEstadoError.desde(state),
      ),
    );
  }
}
