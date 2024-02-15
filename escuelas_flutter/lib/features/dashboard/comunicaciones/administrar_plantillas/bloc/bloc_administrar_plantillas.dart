import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_administrar_plantillas.estado.dart';
part 'bloc_administrar_plantillas_evento.dart';

/// {@template BlocAdministrarPlantillas}
/// Bloc para administrar las plantillas de comunicaciones
/// {@endtemplate}
class BlocAdministrarPlantillas extends Bloc<BlocAdministrarPlantillasEvento,
    BlocAdministrarPlantillasEstado> {
  /// {@macro BlocAdministrarPlantillas}
  BlocAdministrarPlantillas()
      : super(const BlocAdministrarPlantillasEstadoInicial()) {
    on<BlocAdministrarPlantillasEventoInicializar>(_onInicializar);
    on<BlocAdministrarPlantillasEventoAgregarPlantilla>(_onAgregarPlantilla);
    on<BlocAdministrarPlantillasEventoEliminarPlantillas>(
      _onEliminarPlantillas,
    );
    on<BlocAdministrarPlantillasEventoEditarPlantilla>(_onEditarPlantilla);
  }

  /// Accion inicial de la pagina, trae todas las plantillas disponibles
  Future<void> _onInicializar(
    BlocAdministrarPlantillasEventoInicializar event,
    Emitter<BlocAdministrarPlantillasEstado> emit,
  ) async {
    emit(BlocAdministrarPlantillasEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {},
      onError: (e, st) {
        emit(BlocAdministrarPlantillasEstadoError.desde(state));
      },
    );
  }

  /// Accion para agregar una nueva plantilla a la lista
  Future<void> _onAgregarPlantilla(
    BlocAdministrarPlantillasEventoAgregarPlantilla event,
    Emitter<BlocAdministrarPlantillasEstado> emit,
  ) async {
    emit(BlocAdministrarPlantillasEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {},
      onError: (e, st) {
        emit(BlocAdministrarPlantillasEstadoError.desde(state));
      },
    );
  }

  /// Accion para eliminar una o varias plantillas de la lista
  Future<void> _onEliminarPlantillas(
    BlocAdministrarPlantillasEventoEliminarPlantillas event,
    Emitter<BlocAdministrarPlantillasEstado> emit,
  ) async {
    emit(BlocAdministrarPlantillasEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {},
      onError: (e, st) {
        emit(BlocAdministrarPlantillasEstadoError.desde(state));
      },
    );
  }

  /// Accion para editar una plantilla ya creada
  Future<void> _onEditarPlantilla(
    BlocAdministrarPlantillasEventoEditarPlantilla event,
    Emitter<BlocAdministrarPlantillasEstado> emit,
  ) async {
    emit(BlocAdministrarPlantillasEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {},
      onError: (e, st) {
        emit(BlocAdministrarPlantillasEstadoError.desde(state));
      },
    );
  }
}
