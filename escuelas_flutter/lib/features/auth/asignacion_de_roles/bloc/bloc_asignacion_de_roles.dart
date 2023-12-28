import 'package:escuelas_flutter/extensiones/extension_bloc.dart';
import 'package:escuelas_flutter/features/auth/modelos_temporales.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_asignacion_de_roles_estado.dart';
part 'bloc_asignacion_de_roles_evento.dart';

/// {@template BlocAsignacionDeRoles}
/// Bloc que maneja los estados y lógica de la pagina de 'Asignacion de Rol'
/// {@endtemplate}
class BlocAsignacionDeRoles
    extends Bloc<BlocAsignacionDeRolesEvento, BlocAsignacionDeRolesEstado> {
  /// {@macro BlocAsignacionDeRoles}
  BlocAsignacionDeRoles() : super(const BlocAsignacionDeRolesEstadoInicial()) {
    on<BlocAsignacionDeRolesEventoInicializar>(_inicializar);

    add(const BlocAsignacionDeRolesEventoInicializar());
  }

  /// Evento inicial donde trae todos usuarios pendientes de asignar un rol
  Future<void> _inicializar(
    BlocAsignacionDeRolesEventoInicializar event,
    Emitter<BlocAsignacionDeRolesEstado> emit,
  ) async {
    emit(BlocAsignacionDeRolesEstadoCargando.desde(state));
    await operacionBloc(
      callback: (
          // client
          ) async {
        // TODO(Gon): Eliminar hardcodeo y usar endpoint

        // final listaUsuariosPendientes =await client.;

        // TODO(Gon): Eliminar hardcodeo y usar endpoint
        // final InfoUsuario usuarioATraerDatos;

        if (event.idUsuario != null) {
          // usuarioATraerDatos =  sessionManager.signedInUser?.id ;
        } else {
          // usuarioATraerDatos =  await client.traerusuario;
        }

        emit(
          BlocAsignacionDeRolesEstadoExitoso.desde(
            state,
            listaUsuariosPendientes: listaUsuariosPendientes,
          ),
        );
      },
      onError: (e, st) {
        emit(
          BlocAsignacionDeRolesEstadoError.desde(
            state,
          ),
        );
      },
    );
  }
}
