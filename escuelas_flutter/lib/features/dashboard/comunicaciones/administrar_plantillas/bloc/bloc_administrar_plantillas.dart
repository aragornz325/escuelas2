import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/features/dashboard/comunicaciones/administrar_plantillas/celular/vista_celular_Administrar_plantillas.dart';
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
    on<BlocAdministrarPlantillasEventoCambiarModoEliminar>(
      _onCambiarModoEliminar,
    );
    on<BlocAdministrarPlantillasEventoCambiarModoEditar>(
      _onCambiarModoEditar,
    );
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

  /// Cambia de modo, al ser true se mostrara el checkbox a la izquierda
  Future<void> _onCambiarModoEliminar(
    BlocAdministrarPlantillasEventoCambiarModoEliminar event,
    Emitter<BlocAdministrarPlantillasEstado> emit,
  ) async {
    emit(
      BlocAdministrarPlantillasEstadoExitoso.desde(
        state,
        modoEliminar: event.modoEliminar,
      ),
    );
  }

  /// Cambia de modo, al ser true se daran las herramientas de edicion
  Future<void> _onCambiarModoEditar(
    BlocAdministrarPlantillasEventoCambiarModoEditar event,
    Emitter<BlocAdministrarPlantillasEstado> emit,
  ) async {
    emit(
      BlocAdministrarPlantillasEstadoExitoso.desde(
        state,
        modoEliminar: event.modoEditar,
      ),
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
