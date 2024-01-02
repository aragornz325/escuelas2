import 'package:bloc/bloc.dart';
import 'package:escuelas_flutter/features/asistencias/bloc_asistencias/bloc_asistencias_bloc.dart';
import 'package:escuelas_flutter/features/auth/modelos_temporales.dart';
import 'package:escuelas_flutter/utilidades/funciones/operacion_bloc.dart';
import 'package:meta/meta.dart';

part 'bloc_carga_calificaciones_evento.dart';
part 'bloc_carga_calificaciones_estado.dart';

/// {@template PaginaInicio}
/// Todo agregar docu
/// {@endtemplate}
class BlocCargaCalificaciones
    extends Bloc<BlocCargaCalificacionesEvento, BlocCargaCalificacionesEstado> {
  /// {@macro PaginaInicio}
  BlocCargaCalificaciones() : super(BlocCargaCalificacionesEstadoInicial()) {
    on<BLocCargaCalificacionesEventoInicializar>(_onInicializar);

    add(BLocCargaCalificacionesEventoInicializar());
  }

  Future<void> _onInicializar(
    BLocCargaCalificacionesEventoInicializar event,
    Emitter<BlocCargaCalificacionesEstado> emit,
  ) async {
    emit(BlocCargaCalificacionesEstadoCargando.desde(state));
    await operacionBloc(
        callback: () async {
          final lista = [
            ModeloAlumno(
              id: 1,
              nombre: 'Gonzalo',
              asistencia: EstadoAsistencia.sinAsistencia,
              calificacion: [
                ModeloCalificacion(
                  id: 1,
                  calificacion: 10,
                  fecha: DateTime(2023, 12, 10),
                ),
                ModeloCalificacion(
                  id: 2,
                  calificacion: 5,
                  fecha: DateTime.now(),
                ),
              ],
            ),
            ModeloAlumno(
              id: 2,
              nombre: 'Matias',
              asistencia: EstadoAsistencia.sinAsistencia,
              calificacion: [
                ModeloCalificacion(
                  id: 1,
                  calificacion: 10,
                  fecha: DateTime(2023, 12, 10),
                ),
                ModeloCalificacion(
                  id: 2,
                  calificacion: 5,
                  fecha: DateTime.now(),
                ),
              ],
            ),
            ModeloAlumno(
              id: 3,
              nombre: 'Sebas',
              asistencia: EstadoAsistencia.sinAsistencia,
              calificacion: [
                ModeloCalificacion(
                  id: 1,
                  calificacion: 10,
                  fecha: DateTime(2023, 12, 10),
                ),
                ModeloCalificacion(
                  id: 2,
                  calificacion: 5,
                  fecha: DateTime.now(),
                ),
              ],
            ),
            ModeloAlumno(
              id: 4,
              nombre: 'Manu',
              asistencia: EstadoAsistencia.sinAsistencia,
              calificacion: [
                ModeloCalificacion(
                  id: 1,
                  calificacion: 10,
                  fecha: DateTime(2023, 12, 10),
                ),
                ModeloCalificacion(
                  id: 2,
                  calificacion: 5,
                  fecha: DateTime.now(),
                ),
              ],
            ),
          ];

          emit(
            BlocCargaCalificacionesEstadoExitoso.desde(
              state,
              alumnos: lista,
              rolDelUsuario: Rol(
                id: 1,
                nombre: 'docente',
                permisos: [],
              ),
            ),
          );
        },
        onError: (e, st) => BlocCargaCalificacionesEstadoError.desde(state));
  }
}
