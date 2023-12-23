import 'package:equatable/equatable.dart';
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
    on<BlocAsignacionDeRolesEventoInicializar>(_inicializar);
  }

  /// Evento inicial donde trae todos los articulos/Entregable del usuario.
  Future<void> _inicializar(
    BlocAsignacionDeRolesEventoInicializar event,
    Emitter<BlocAsignacionDeRolesEstado> emit,
  ) async {
    emit(BlocAsignacionDeRolesEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        // final roles = await client.;
        final roles = [
          Rol(),
          Rol(),
          Rol(),
          Rol(),
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
