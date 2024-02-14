import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:meta/meta.dart';

part 'bloc_gestion_de_comision_evento.dart';
part 'bloc_gestion_de_comision_estado.dart';

/// {@template BlocGestionDeComision}
/// Bloc que maneja los estados y lógica de la '[PaginaGestionDeComision]'
/// {@endtemplate}
class BlocGestionDeComision
    extends Bloc<BlocGestionDeComisionEvento, BlocGestionDeComisionEstado> {
  /// {@macro BlocGestionDeComisionEvento}
  BlocGestionDeComision() : super(const BlocGestionDeComisionEstadoInicial()) {
    on<BlocGestionDeComisionEventoInicializar>(_onInicializar);
  }

  /// Evento inicial para obtener el docente de la asignatura
  /// y los alumnos de una comision
  Future<void> _onInicializar(
    BlocGestionDeComisionEventoInicializar event,
    Emitter<BlocGestionDeComisionEstado> emit,
  ) async {
    emit(BlocGestionDeComisionEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        // TODO(mati): implementar funcion del back de traer los alumnos de
        // esa comision y el profesor asignado a esta asignatura.
        final listaAlumnos =
            await client.usuario.obtenerUsuariosPorRolSorteados(
          idRol: 1, // TODO(mati): rol alumno
          ordenarUsuariosPor: OrdenarPor.apellido,
        );

        // TODO(mati): hacer el filtrado de los usuario cual es el docente.
        // y el id de la asignatura
        // final asignatura = await client.asignatura.obtenerAsignaturaPorId(
        //   id: 1,
        // );
        emit(
          BlocGestionDeComisionEstadoExitoso.desde(
            state,
            listaAlumnos: listaAlumnos,
          ),
        );
      },
      onError: (e, st) => BlocGestionDeComisionEstadoFallido.desde(state),
    );
  }
}
