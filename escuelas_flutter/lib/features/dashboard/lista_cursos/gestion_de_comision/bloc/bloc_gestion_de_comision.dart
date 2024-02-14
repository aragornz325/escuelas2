import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:meta/meta.dart';

part 'bloc_gestion_de_comision_evento.dart';
part 'bloc_gestion_de_comision_estado.dart';

class BlocGestionDeComision
    extends Bloc<BlocGestionDeComisionEvento, BlocGestionDeComisionEstado> {
  BlocGestionDeComision() : super(BlocGestionDeComisionEstadoInicial()) {
    on<BlocGestionDeComisionEventoInicializar>(_onInicializar);
  }

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
          idRol: 1,
          ordenarUsuariosPor: OrdenarPor.apellido,
        );

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
