import 'package:equatable/equatable.dart';
import 'package:escuelas_flutter/extensiones/extension_bloc.dart';
import 'package:escuelas_flutter/features/asignacion_de_roles/bloc/modelo_rol.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_asignacion_de_roles_estado.dart';
part 'bloc_asignacion_de_roles_evento.dart';

/// {@template BlocAsignacionDeRoles}
/// Bloc que maneja los estados y lógica de la pagina de 'AsignacionDeRoles'
/// {@endtemplate}
class BlocAsignacionDeRoles
    extends Bloc<BlocAsignacionDeRolesEvento, BlocAsignacionDeRolesEstado> {
  /// {@macro BlocAsignacionDeRoles}
  BlocAsignacionDeRoles()
      : super(
          const BlocAsignacionDeRolesEstadoInicial(),
        ) {
    on<BlocAsignacionDeRolesEventoInicializar>(_traerRoles);
    add(BlocAsignacionDeRolesEventoInicializar());
  }

  /// Evento inicial donde trae todos los articulos/Entregable del usuario.
  Future<void> _traerRoles(
    BlocAsignacionDeRolesEventoInicializar event,
    Emitter<BlocAsignacionDeRolesEstado> emit,
  ) async {
    emit(BlocAsignacionDeRolesEstadoCargando.desde(state));
    await operacionBloc(
      callback: (
          // client
          ) async {
        // final roles = await client.;
        // TODO(Gon): Eliminar hardcodeo, traer del back
        final roles = [
          Rol(nombre: 'ALUMNO', permisos: ['permiso1', 'permiso2']),
          Rol(nombre: 'DOCENTE', permisos: ['permiso1', 'permiso2']),
        ];

        emit(
          BlocAsignacionDeRolesEstadoExitosoGeneral.desde(
            state,
            listaRoles: roles,
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
