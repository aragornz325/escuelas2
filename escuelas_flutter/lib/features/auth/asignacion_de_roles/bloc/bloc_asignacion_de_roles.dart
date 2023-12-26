import 'package:escuelas_flutter/extensiones/extension_bloc.dart';
import 'package:escuelas_flutter/features/auth/modelos_temporales.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_asignacion_de_roles_estado.dart';
part 'bloc_asignacion_de_roles_evento.dart';

/// {@template BlocAsignacionDeRoles}
/// Bloc que maneja los estados y lógica de la pagina de 'Inicio'
/// {@endtemplate}
class BlocAsignacionDeRoles
    extends Bloc<BlocAsignacionDeRolesEvento, BlocAsignacionDeRolesEstado> {
  /// {@macro BlocInicio}
  BlocAsignacionDeRoles() : super(const BlocAsignacionDeRolesEstadoInicial()) {
    on<BlocAsignacionDeRolesEventoInicializar>(_inicializar);

    add(const BlocAsignacionDeRolesEventoInicializar());
  }

  /// Evento inicial donde trae todos los cursos del usuario.
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
        final listaUsuariosPendientes = [
          InfoUsuario(nombre: 'alumnoo', permiso: [Permiso.alumno]),
          InfoUsuario(nombre: 'alumnoo', permiso: [Permiso.alumno]),
          InfoUsuario(nombre: 'alumnoo', permiso: [Permiso.alumno]),
          InfoUsuario(nombre: 'docentee', permiso: [Permiso.profesor]),
          InfoUsuario(nombre: 'docentee', permiso: [Permiso.profesor]),
        ];

        final listaDocentes = listaUsuariosPendientes
            .where(
              (usuario) => usuario.permiso.contains(Permiso.profesor),
            )
            .toList();

        final listaAlumnos = listaUsuariosPendientes
            .where(
              (usuario) => usuario.permiso.contains(Permiso.alumno),
            )
            .toList();

        emit(
          BlocAsignacionDeRolesEstadoExitoso.desde(
            state,
            listaAlumnos: listaAlumnos,
            listaDocentes: listaDocentes,
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
