import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:flutter/material.dart';

part 'bloc_inasistencias_evento.dart';
part 'bloc_inasistencias_estado.dart';

/// {@template BlocInasistencias}
/// BLoC que maneja el estado y la lógica general de la pagina 'Inasistencias'
/// {@endtemplate}
class BlocInasistencias
    extends Bloc<BlocInasistenciasEvento, BlocInasistenciasEstado> {
  /// {@macro BlocInasistencias}
  BlocInasistencias() : super(const BlocInasistenciasEstadoInicial()) {
    on<BlocInasistenciasEventoInicializar>(_onInicializar);
    on<BlocAsistenciaEventoCambiarInasistenciaEstudiante>(
      _onCambiarInasistenciaEstudiante,
    );

    on<BlocInasistenciasEventoFinalizarInasistencias>(_onFinalizarAsistencia);
  }

  /// Al inicializar trae los cursos para tomar inasistencias.
  Future<void> _onInicializar(
    BlocInasistenciasEventoInicializar event,
    Emitter<BlocInasistenciasEstado> emit,
  ) async {
    emit(BlocInasistenciasEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final comisiones = await client.comision.obtenerComisiones();

        final inasistencias = await client.asistencia.traerAsistenciaPorDia(
          fecha: event.fecha,
        );

        if (inasistencias.isNotEmpty) {
          final listaDeInasistencias = _obtenerInasistenciasPorComision(
            comisiones,
            inasistencias,
            event.fecha,
          );

          return emit(
            BlocInasistenciasEstadoExitoso.desde(
              state,
              comisiones: comisiones,
              fechaActual: event.fecha,
              inasistencias: listaDeInasistencias,
              todasInasistencias: inasistencias,
            ),
          );
        }

        final listasDeAsistencia = <List<AsistenciaDiaria>>[];

        for (final comision in comisiones) {
          final listaAsistenciaDiaria = comision.estudiantes?.map(
            (relacionComisionUsuario) {
              return AsistenciaDiaria(
                estudianteId: relacionComisionUsuario.usuario?.id ?? 0,
                estudiante: relacionComisionUsuario.usuario,
                comisionId: comision.id ?? 0,
                comision: comision,
                estadoDeAsistencia: EstadoDeAsistencia.sinEstado,
                fecha: state.fechaActual ?? DateTime.now(),
              );
            },
          ).toList();

          listasDeAsistencia.add(listaAsistenciaDiaria!);
        }

        emit(
          BlocInasistenciasEstadoExitoso.desde(
            state,
            comisiones: comisiones,
            fechaActual: event.fecha,
            inasistencias: listasDeAsistencia,
            todasInasistencias: inasistencias,
          ),
        );
      },
      onError: (e, st) => emit(BlocInasistenciasEstadoFallido.desde(state)),
    );
  }

  /// Cuando se pasa inasistencia en dicho curso cambia el estado si se paso
  /// asistencia
  Future<void> _onFinalizarAsistencia(
    BlocInasistenciasEventoFinalizarInasistencias event,
    Emitter<BlocInasistenciasEstado> emit,
  ) async {
    emit(BlocInasistenciasEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        // TODO(anyone): hacer una validacion que dependa del rol pueda o no
        // actualizar la lista
        final asistenciasDiarias = List<AsistenciaDiaria>.from(
          state.asistenciaAModificar,
        );

        final listaAModificar = <AsistenciaDiaria>[];
        final listaACrear = <AsistenciaDiaria>[];

        _agregaListaInasistencia(
          asistenciasDiarias,
          listaAModificar,
          listaACrear,
        );

        if (listaAModificar.isNotEmpty) {
          // TODO(anyone): HOT FIX, EL ENDPOINT ROMPE SI LE PASAS COMISION O ESTUDIANTE(O AMBAS), POR ESO SE HACE ESTO
          asistenciasDiarias
              .map(
                (e) => e
                  ..comision = null
                  ..estudiante = null,
              )
              .toList();
          await client.asistencia
              .actualizarAsistenciasEnLote(asistencias: listaAModificar);
        }

        if (listaACrear.isNotEmpty) {
          // TODO(anyone): HOT FIX, EL ENDPOINT ROMPE SI LE PASAS COMISION O ESTUDIANTE(O AMBAS), POR ESO SE HACE ESTO
          final lista = asistenciasDiarias
              .map(
                (e) => e
                  ..comision = null
                  ..estudiante = null,
              )
              .toList();
          final nuevasInasistencias = await client.asistencia
              .crearAsistenciasEnLote(asistencias: lista);
          for (final asistencia
              in state.inasistencias.expand((element) => element).toList()) {
            final inasistencia = nuevasInasistencias.firstWhere(
              (inasistencia) =>
                  inasistencia.estudiante?.id == asistencia.estudiante?.id,
            );
            asistencia.id = inasistencia.id;
          }
        }

        for (final asistencia
            in state.inasistencias.expand((element) => element).toList()) {
          asistencia.ultimaModificacion = state.fechaActual;
        }

        for (final asistencia in asistenciasDiarias) {
          asistencia.ultimaModificacion = state.fechaActual;
        }

        final comisiones = List<ComisionDeCurso>.from(state.comisiones);

        comisiones
            .firstWhere(
              (comision) => comision.curso?.id == event.idCurso,
            )
            .ultimaModificacion = state.fechaActual ?? DateTime.now();

        emit(
          BlocInasistenciasEstadoExitosoEnvioDeInasistencias.desde(
            state,
            comisiones: comisiones,
            inasistencias: state.inasistencias,
            asistenciaAModificar: asistenciasDiarias,
          ),
        );
      },
      onError: (e, st) => emit(BlocInasistenciasEstadoFallido.desde(state)),
    );
  }

  /// Cambia la inasistencia de un estudiante
  void _onCambiarInasistenciaEstudiante(
    BlocAsistenciaEventoCambiarInasistenciaEstudiante event,
    Emitter<BlocInasistenciasEstado> emit,
  ) {
    final comisiones = List<ComisionDeCurso>.from(state.comisiones);
    final asistenciasAModificar =
        List<AsistenciaDiaria>.from(state.asistenciaAModificar);

    //actualiza el estado de un estudiante de un curso
    final asistencias = state.inasistencias
        .expand(
          (lista) => lista.where(
            (asistenciaDiaria) =>
                asistenciaDiaria.comisionId == event.idComision,
          ),
        )
        .toList();
    asistencias
        .firstWhere(
          (asistencia) => asistencia.estudiante?.id == event.idEstudiante,
        )
        .estadoDeAsistencia = event.estadoInasistencia.cambiarEstado();

    if (event.estadoInasistencia.existeMismoEstudiante(
      asistenciasAModificar,
      event.idEstudiante,
    )) {
      // si ya existe en la lista modifica el estado
      asistenciasAModificar
          .firstWhere(
            (asistencia) => asistencia.estudiante?.id == event.idEstudiante,
          )
          .estadoDeAsistencia = event.estadoInasistencia.cambiarEstado();
    } else {
      // agrega la inasistencia a una lista a crear
      asistenciasAModificar.add(
        asistencias.firstWhere(
          (asistencia) => asistencia.estudiante?.id == event.idEstudiante,
        ),
      );
    }

    emit(
      BlocInasistenciasEstadoExitoso.desde(
        state,
        comisiones: comisiones,
        inasistencias: state.inasistencias,
        asistenciaAModificar: asistenciasAModificar,
      ),
    );
  }

  /// agrega un estudiante a una lista de inasistencia
  ///
  /// si ya existe la inasistencia la agrega a una lista a modificar
  /// si no existe la inasistencia la agrega a una lista a crear
  void _agregaListaInasistencia(
    List<AsistenciaDiaria> asistenciasDiarias,
    List<AsistenciaDiaria> listaAModificar,
    List<AsistenciaDiaria> listaACrear,
  ) {
    for (final asistenciaDiaria in asistenciasDiarias) {
      final existeAsistencia =
          asistenciaDiaria.estadoDeAsistencia.existeInasistencia(
        asistenciasDiarias: asistenciasDiarias,
        idEstudiante: asistenciaDiaria.estudiante?.id ?? 0,
        fecha: state.fechaActual ?? DateTime.now(),
      );

      // Verificar si ya existe una asistencia exactamente igual
      final tieneLaMismaAsistencia =
          asistenciaDiaria.estadoDeAsistencia.tieneLaMismaInasistencia(
        asistenciasDiarias: asistenciasDiarias,
        idEstudiante: asistenciaDiaria.estudiante?.id ?? 0,
        fecha: state.fechaActual ?? DateTime.now(),
        estado: asistenciaDiaria.estadoDeAsistencia,
      );
      if (existeAsistencia && tieneLaMismaAsistencia) {
        listaAModificar.add(asistenciaDiaria);
      } else if (!existeAsistencia) {
        listaACrear.add(asistenciaDiaria);
      }
    }
  }
}

/// Obtiene las inasistencias de cada comision para la fecha dada
List<List<AsistenciaDiaria>> _obtenerInasistenciasPorComision(
  List<ComisionDeCurso> comisiones,
  List<AsistenciaDiaria> inasistencias,
  DateTime fecha,
) {
  // Crear una lista para almacenar las asistencias por comisión
  final asistenciasPorComision = <List<AsistenciaDiaria>>[];

  // Iterar a través de cada comisión
  for (final comision in comisiones) {
    // Obtener las asistencias de esa comisión para la fecha dada
    final estudiantes = comision.estudiantes;
    if (estudiantes != null) {
      final asistenciasComision = <AsistenciaDiaria>[];

      for (final relacionComisionUsuario in estudiantes) {
        final asistenciaEnFecha = inasistencias.firstWhere(
          (asistencia) =>
              asistencia.fecha.year == fecha.year &&
              asistencia.fecha.month == fecha.month &&
              asistencia.fecha.day == fecha.day &&
              asistencia.estudiante?.id == relacionComisionUsuario.usuario?.id,
          orElse: () {
            // Crear una asistencia predeterminada si no se encuentra una
            // asistencia
            return AsistenciaDiaria(
              estudianteId: relacionComisionUsuario.usuario?.id ?? 0,
              estudiante: relacionComisionUsuario.usuario,
              comisionId: comision.id ?? 0,
              comision: comision,
              estadoDeAsistencia: EstadoDeAsistencia.sinEstado,
              fecha: fecha,
            );
          },
        );

        // Agregar la asistencia al resultado
        asistenciasComision.add(asistenciaEnFecha);
      }

      // Agregar las asistencias a la lista
      asistenciasPorComision.add(asistenciasComision);
    }
  }

  return asistenciasPorComision;
}
