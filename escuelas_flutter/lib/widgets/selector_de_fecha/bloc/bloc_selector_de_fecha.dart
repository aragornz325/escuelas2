import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_selector_de_fecha_estado.dart';
part 'bloc_selector_de_fecha_evento.dart';

/// {@template BlocSelectorDeFecha}
/// Bloc que maneja los estados y lógica de la pagina de 'Selector de Fecha'
/// {@endtemplate}
class BlocSelectorDeFecha
    extends Bloc<BlocSelectorDeFechaEvento, BlocSelectorDeFechaEstado> {
  /// {@macro BlocSelectorDeFecha}
  BlocSelectorDeFecha() : super(BlocSelectorDeFechaEstadoInicial()) {
    on<BlocSelectorDeFechaEventoRetroceder>(_onRetroceder);
    on<BlocSelectorDeFechaEventoAvanzar>(_onAvanzar);
  }

  /// Retrocede un mes en el selector de fecha
  void _onRetroceder(
    BlocSelectorDeFechaEventoRetroceder event,
    Emitter<BlocSelectorDeFechaEstado> emit,
  ) {
    emit(
      BlocSelectorDeFechaEstadoExitoso.desde(
        state,
        fecha: state.fecha.copyWith(month: state.fecha.month - 1),
      ),
    );
  }

  /// Avanza un mes en el selector de fecha
  void _onAvanzar(
    BlocSelectorDeFechaEventoAvanzar event,
    Emitter<BlocSelectorDeFechaEstado> emit,
  ) {
    emit(
      BlocSelectorDeFechaEstadoExitoso.desde(
        state,
        fecha: state.fecha.copyWith(month: state.fecha.month + 1),
      ),
    );
  }
}
