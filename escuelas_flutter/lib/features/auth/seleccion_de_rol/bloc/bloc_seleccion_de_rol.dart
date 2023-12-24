import 'package:escuelas_flutter/extensiones/extension_bloc.dart';
import 'package:escuelas_flutter/features/auth/seleccion_de_rol/bloc/modelo_rol.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_seleccion_de_rol_estado.dart';
part 'bloc_seleccion_de_rol_evento.dart';

/// {@template BlocSeleccionDeRol}
/// Bloc que maneja los estados y lógica de la pagina de 'SeleccionDeRol'
/// {@endtemplate}
class BlocSeleccionDeRol
    extends Bloc<BlocSeleccionDeRolEvento, BlocSeleccionDeRolEstado> {
  /// {@macro BlocSeleccionDeRol}
  BlocSeleccionDeRol()
      : super(
          const BlocSeleccionDeRolEstadoInicial(),
        ) {
    on<BlocSeleccionDeRolEventoTraerRoles>(_traerRoles);
    add(BlocSeleccionDeRolEventoTraerRoles());
  }

  /// Evento inicial donde trae todos los roles de la aplicacion.
  Future<void> _traerRoles(
    BlocSeleccionDeRolEventoTraerRoles event,
    Emitter<BlocSeleccionDeRolEstado> emit,
  ) async {
    emit(BlocSeleccionDeRolEstadoCargando.desde(state));
    await operacionBloc(
      callback: (
          // client
          ) async {
        // final roles = await client.;
        // TODO(Gon): Eliminar hardcodeo, traer del back
        final roles = [
          Rol(nombre: 'ALUMNO', permisos: ['permiso1', 'permiso2'], id: 0),
          Rol(nombre: 'DOCENTE', permisos: ['permiso1', 'permiso2'], id: 1),
        ];

        emit(
          BlocSeleccionDeRolEstadoExitosoGeneral.desde(
            state,
            listaRoles: roles,
          ),
        );
      },
      onError: (e, st) {
        emit(
          BlocSeleccionDeRolEstadoError.desde(
            state,
          ),
        );
      },
    );
  }
}
