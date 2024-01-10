import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_mis_cursos_estado.dart';
part 'bloc_mis_cursos_evento.dart';

/// {@template BlocMisCursos}
/// Bloc que maneja los estados y lógica de la pagina de 'Mis Cursos'
/// {@endtemplate}
class BlocMisCursos extends Bloc<BlocMisCursosEvento, BlocMisCursosEstado> {
  /// {@macro BlocMisCursos}
  BlocMisCursos() : super(const BlocMisCursosEstadoInicial()) {
    on<BlocMisCursosEventoInicializar>(_inicializar);
    on<BlocMisCursosEventoCambiarMes>(_cambiarMes);
  }

  /// Trae las materias asignadas al usuario y las ordena por curso
  Future<void> _inicializar(
    BlocMisCursosEventoInicializar event,
    Emitter<BlocMisCursosEstado> emit,
  ) async {
    emit(BlocMisCursosEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        // TODO(Gon): usar endpoint
        // final comisiones = await client.comision.getMisCursos(mes, anio);

        emit(
          BlocMisCursosEstadoExitoso.desde(
            state,
            comisiones: [
              const ComisionAsignaturaOverview(
                nombreComision: 'Primero A',
                asignaturas: [
                  AsignaturaOverview(
                    nombre: 'Matematica',
                    tienePendientes: true,
                  ),
                  AsignaturaOverview(
                    nombre: 'Lengua',
                    tienePendientes: false,
                  ),
                ],
              ),
              const ComisionAsignaturaOverview(
                nombreComision: 'Segundo B',
                asignaturas: [
                  AsignaturaOverview(
                    nombre: 'Matematica',
                    tienePendientes: false,
                  ),
                  AsignaturaOverview(
                    nombre: 'Lengua',
                    tienePendientes: true,
                  ),
                ],
              ),
            ],
          ),
        );
      },
      onError: (e, st) {
        emit(BlocMisCursosEstadoError.desde(state));
      },
    );
  }

  /// Trae las materias asignadas al usuario y las ordena por curso
  Future<void> _cambiarMes(
    BlocMisCursosEventoCambiarMes event,
    Emitter<BlocMisCursosEstado> emit,
  ) async {
    emit(BlocMisCursosEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        // final comisiones = await client.comision.getMisCursos
        // (event.periodoSeleccionada.month, event.periodoSeleccionada.year);

        emit(
          BlocMisCursosEstadoExitoso.desde(
            state,
            comisiones: [
              const ComisionAsignaturaOverview(
                nombreComision: 'Primero A',
                asignaturas: [
                  AsignaturaOverview(
                    nombre: 'Matematica',
                    tienePendientes: false,
                  ),
                  AsignaturaOverview(
                    nombre: 'Lengua',
                    tienePendientes: false,
                  ),
                ],
              ),
              const ComisionAsignaturaOverview(
                nombreComision: 'Segundo B',
                asignaturas: [
                  AsignaturaOverview(
                    nombre: 'Matematica',
                    tienePendientes: false,
                  ),
                  AsignaturaOverview(
                    nombre: 'Lengua',
                    tienePendientes: false,
                  ),
                ],
              ),
            ],
          ),
        );
      },
      onError: (e, st) {
        emit(BlocMisCursosEstadoError.desde(state));
      },
    );
  }
}
