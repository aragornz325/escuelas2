import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolemissions/rolemissions.dart';

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
  }

  /// Evento inicial donde trae todos usuarios pendientes de asignar un rol
  Future<void> _inicializar(
    BlocAsignacionDeRolesEventoInicializar event,
    Emitter<BlocAsignacionDeRolesEstado> emit,
  ) async {
    emit(BlocAsignacionDeRolesEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        final listaUsuariosPendientes =
            await client.usuario.obtenerUsuariosPendientes();

        final listaRoles = await client.rol.obtenerRoles();

        emit(
          BlocAsignacionDeRolesEstadoExitoso.desde(
            state,
            listaUsuariosPendientes: listaUsuariosPendientes,
            listaRoles: listaRoles,
          ),
        );
      },
      onError: (e, st) => emit(BlocAsignacionDeRolesEstadoError.desde(state)),
    );
  }
}
