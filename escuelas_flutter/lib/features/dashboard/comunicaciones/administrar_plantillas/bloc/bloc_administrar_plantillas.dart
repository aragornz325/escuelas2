import 'package:escuelas_client/escuelas_client.dart';
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
    on<BlocAdministrarPlantillasEventoCambiarModoEditar>(
      _onCambiarModoEditar,
    );
    on<BlocAdministrarPlantillasEventoCambiarModoEliminar>(
      _onCambiarModoEliminar,
    );
    on<BlocAministrarPlantillasEventoCancelarModoEliminar>(
      _onCancelarModoEliminar,
    );
    on<BlocAdministrarPlantillasEventoPlantillaSeleccionada>(
      _onSeleccionPlantilla,
    );
    on<BlocAdministrarPlantillasEventoPlantillaNoSeleccionada>(
      _onDeseleccionPlantilla,
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
      callback: (client) async {
        final plantillas =
            await client.plantillaComunicacion.listarPlantillasComunicacion();

        emit(
          BlocAdministrarPlantillasEstadoExitoso.desde(
            state,
            listaDePlantillas: plantillas,
          ),
        );
      },
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
      callback: (client) async {
        final plantilla =
            await client.plantillaComunicacion.crearPlantillaComunicacion(
          plantillaComunicacion: PlantillaComunicacion(
            titulo: event.nombrePlantilla,
            nota: event.descripcionPlantilla,
            necesitaSupervision: event.necesitaSupervicion,
            ultimaModificacion: DateTime.now(),
            fechaCreacion: DateTime.now(),
          ),
        );
        final nuevaListaDePlantillas =
            List<PlantillaComunicacion>.from(state.listaDePlantillas)
              ..add(
                PlantillaComunicacion(
                  titulo: plantilla.titulo,
                  nota: plantilla.nota,
                  necesitaSupervision: plantilla.necesitaSupervision,
                  ultimaModificacion: plantilla.ultimaModificacion,
                  fechaCreacion: plantilla.fechaCreacion,
                ),
              );
        emit(
          BlocAdministrarPlantillasEstadoExitoso.desde(
            state,
            listaDePlantillas: nuevaListaDePlantillas,
          ),
        );
        emit(
          BlocAdministrarPlantillasEstadoExitosoAlCrearPlantilla.desde(
            state,
            plantilla: plantilla,
          ),
        );
      },
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

  /// Cancela el modo eliminar, llevando la lista de plantillas a vacia
  Future<void> _onCancelarModoEliminar(
    BlocAministrarPlantillasEventoCancelarModoEliminar event,
    Emitter<BlocAdministrarPlantillasEstado> emit,
  ) async {
    final plantillasAEliminar = state.listaDePlantillasAEliminar..clear();
    emit(
      BlocAdministrarPlantillasEstadoExitosoAlCancelarModoEliminar.desde(
        state,
        listaDePlantillasAEliminar: plantillasAEliminar,
        modoEliminar: false,
        seleccionado: event.select,
      ),
    );
  }

  /// Selecciona una plantilla y la guarda en la lista de plantillas a eliminar
  Future<void> _onSeleccionPlantilla(
    BlocAdministrarPlantillasEventoPlantillaSeleccionada event,
    Emitter<BlocAdministrarPlantillasEstado> emit,
  ) async {
    final plantillasAEliminar = List.of(state.listaDePlantillasAEliminar)
      ..add(event.plantillaSeleccionada);

    emit(
      BlocAdministrarPlantillasEstadoExitoso.desde(
        state,
        listaDePlantillasAEliminar: plantillasAEliminar,
        seleccionado: event.select,
      ),
    );
  }

  /// Accion para deseleccionar una o varias plantillas de la lista
  /// removiendolas de la lista de plantillas a eliminar
  Future<void> _onDeseleccionPlantilla(
    BlocAdministrarPlantillasEventoPlantillaNoSeleccionada event,
    Emitter<BlocAdministrarPlantillasEstado> emit,
  ) async {
    final plantillasAEliminar = List.of(state.listaDePlantillasAEliminar)
      ..removeWhere(
        (e) => e.id == event.plantilla.id,
      );

    emit(
      BlocAdministrarPlantillasEstadoExitoso.desde(
        state,
        listaDePlantillasAEliminar: plantillasAEliminar,
        seleccionado: event.select,
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
      callback: (client) async {
        await client.plantillaComunicacion.eliminarPlantillasComunicacion(
          idPlantillasComunicacion:
              state.listaDePlantillasAEliminar.map((e) => e.id ?? 0).toList(),
        );
        final indexAEliminar = state.listaDePlantillasAEliminar
            .indexWhere((e) => e.id == event.idPlantilla);
        final nuevaListaDePlantillas =
            List<PlantillaComunicacion>.from(state.listaDePlantillas)
              ..removeWhere(
                (element) =>
                    element.id ==
                    state.listaDePlantillasAEliminar[indexAEliminar].id,
              );
        emit(
          BlocAdministrarPlantillasEstadoExitoso.desde(
            state,
            listaDePlantillas: nuevaListaDePlantillas,
            seleccionado: false,
            modoEliminar: false,
          ),
        );
      },
      onError: (e, st) {
        emit(BlocAdministrarPlantillasEstadoError.desde(state));
      },
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
        modoEditar: event.modoEditar,
      ),
    );
  }

  /// Accion para editar una plantilla ya creada
  Future<void> _onEditarPlantilla(
    BlocAdministrarPlantillasEventoEditarPlantilla event,
    Emitter<BlocAdministrarPlantillasEstado> emit,
  ) async {
    emit(BlocAdministrarPlantillasEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final plantillaEditada = PlantillaComunicacion(
          id: event.idPlantilla,
          titulo: event.nuevoNombre,
          nota: event.nuevaDescripcion,
          necesitaSupervision: event.nuevaNecesitaSupervision,
          ultimaModificacion: DateTime.now(),
          fechaCreacion: DateTime.now(),
        );

        final plantillaModificada =
            await client.plantillaComunicacion.actualizarPlantillaComunicacion(
          plantillaComunicacion: plantillaEditada,
        );
        final lista = List<PlantillaComunicacion>.from(state.listaDePlantillas);

        final indicePlantilla =
            lista.indexWhere((element) => element.id == event.plantilla.id);

        lista[indicePlantilla] = plantillaModificada;

        emit(
          BlocAdministrarPlantillasEstadoExitosoAlEditarPlantilla.desde(
            state,
            listaDePlantillas: lista,
            plantilla: plantillaModificada,
            modoEditar: false,
          ),
        );
      },
      onError: (e, st) {
        emit(BlocAdministrarPlantillasEstadoError.desde(state));
      },
    );
  }
}
