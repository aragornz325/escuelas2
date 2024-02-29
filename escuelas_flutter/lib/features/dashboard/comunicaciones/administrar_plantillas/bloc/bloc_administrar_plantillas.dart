import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_administrar_plantillas_estado.dart';
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

    on<BlocAdministrarPlantillasEventoAlternarModoEliminar>(
      _onAlternarModoEliminar,
    );
    on<BlocAdministrarPlantillasEventoAlternarSeleccionPlantilla>(
      _onAlternarSeleccionPlantilla,
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
            listaDePlantillasConCheckbox: plantillas
                .map(
                  (e) => PlantillaConCheckbox(
                    plantilla: e,
                    seleccionado: false,
                  ),
                )
                .toList(),
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
              ..add(plantilla);

        final nuevaListaDePlantillasConCheckbox =
            List<PlantillaConCheckbox>.from(state.listaDePlantillasConCheckbox)
              ..add(
                PlantillaConCheckbox(
                  plantilla: plantilla,
                  seleccionado: false,
                ),
              );
        emit(
          BlocAdministrarPlantillasEstadoExitoso.desde(
            state,
            listaDePlantillas: nuevaListaDePlantillas,
            listaDePlantillasConCheckbox: nuevaListaDePlantillasConCheckbox,
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
  Future<void> _onAlternarModoEliminar(
    BlocAdministrarPlantillasEventoAlternarModoEliminar event,
    Emitter<BlocAdministrarPlantillasEstado> emit,
  ) async {
    final nuevaListaPlantillasConCheckbox = state.listaDePlantillasConCheckbox
        .map(
          (e) => PlantillaConCheckbox(
            plantilla: e.plantilla,
            seleccionado: false,
          ),
        )
        .toList();

    emit(
      BlocAdministrarPlantillasEstadoExitoso.desde(
        state,
        modoEliminar: !state.modoEliminar,
        listaDePlantillasConCheckbox: nuevaListaPlantillasConCheckbox,
      ),
    );
  }

  /// Selecciona una plantilla y la guarda en la lista de plantillas a eliminar
  Future<void> _onAlternarSeleccionPlantilla(
    BlocAdministrarPlantillasEventoAlternarSeleccionPlantilla event,
    Emitter<BlocAdministrarPlantillasEstado> emit,
  ) async {
    final listaDePlantillasConCheckbox = state.listaDePlantillasConCheckbox
        .map(
          (e) => e.plantilla.id == event.idPlantillaSeleccionada
              ? PlantillaConCheckbox(
                  plantilla: e.plantilla,
                  seleccionado: !e.seleccionado,
                )
              : e,
        )
        .toList();

    emit(
      BlocAdministrarPlantillasEstadoExitoso.desde(
        state,
        listaDePlantillasConCheckbox: listaDePlantillasConCheckbox,
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
        final plantillasAEliminar = state.listaDePlantillasConCheckbox
            .where((element) => element.seleccionado)
            .map((e) => e.plantilla.id!)
            .toList();

        await client.plantillaComunicacion.eliminarPlantillasComunicacion(
          idPlantillasComunicacion: plantillasAEliminar,
        );

        final nuevaListaDePlantillas =
            List<PlantillaConCheckbox>.from(state.listaDePlantillasConCheckbox)
              ..removeWhere((element) => element.seleccionado);

        emit(
          BlocAdministrarPlantillasEstadoExitoso.desde(
            state,
            listaDePlantillasConCheckbox: nuevaListaDePlantillas,
            modoEliminar: false,
          ),
        );
        emit(
          BlocAdministrarPlantillasEstadoExitosoAlEliminarPlantilla.desde(
            state,
          ),
        );
      },
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
          ),
        );
      },
      onError: (e, st) {
        emit(BlocAdministrarPlantillasEstadoError.desde(state));
      },
    );
  }
}

/// {@template PlantillaConCheckbox}
/// Plantilla con checkbox utilizada para el modo eliminar
/// {@endtemplate}
class PlantillaConCheckbox {
  /// {@macro PlantillaConCheckbox}
  PlantillaConCheckbox({
    required this.plantilla,
    required this.seleccionado,
  });
  final PlantillaComunicacion plantilla;
  final bool seleccionado;
}
