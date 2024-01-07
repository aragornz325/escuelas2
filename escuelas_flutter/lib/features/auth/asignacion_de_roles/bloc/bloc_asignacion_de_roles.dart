import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
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
  }

  /// Evento inicial donde trae todos usuarios pendientes de asignar un rol
  Future<void> _inicializar(
    BlocAsignacionDeRolesEventoInicializar event,
    Emitter<BlocAsignacionDeRolesEstado> emit,
  ) async {
    emit(BlocAsignacionDeRolesEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        // TODO(Gon): Eliminar hardcodeo y usar endpoint

        // final listaUsuariosPendientes =await client.;

        emit(
          BlocAsignacionDeRolesEstadoExitoso.desde(
            state,
            listaUsuariosPendientes: [
              UsuarioPendiente(
                nombre: 'Gonzalo',
                apellido: 'Gonzalez',
                id: 0,
                rolSolicitado: 3,
                estadoDeSolicitud: EstadoDeSolicitud.aprobado,
                idUserInfo: 0,
                dni: '43',
                ultimaModificacion: DateTime.now(),
                fechaCreacion: DateTime.now(),
              ),
            ],
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

enum Roles {
  directivo,
  alumno,
  docente;

  RolDeUsuario get rol {
    switch (this) {
      case Roles.directivo:
        return RolDeUsuario(
          nombre: 'Directivo',
          id: 0,
          descripcion: '',
        );

      case Roles.alumno:
        return RolDeUsuario(
          nombre: 'Alumno',
          descripcion: '',
          id: 1,
        );
      case Roles.docente:
        return RolDeUsuario(
          nombre: 'Docente',
          descripcion: '',
          id: 2,
        );
    }
  }
}
