import 'package:collection/collection.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/pagina_perfil_usuario.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/widgets/seccion_cursos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolemissions/rolemissions.dart';

part 'bloc_perfil_usuario_estado.dart';
part 'bloc_perfil_usuario_evento.dart';


/// {@template BlocPerfilUsuario}
/// Bloc que maneja los estados y lógica de la pagina de [PaginaPerfilUsuario]
/// {@endtemplate}
class BlocPerfilUsuario
    extends Bloc<BlocPerfilUsuarioEvento, BlocPerfilUsuarioEstado> {
  /// {@macro BlocPerfilUsuario}
  BlocPerfilUsuario() : super(const BlocPerfilUsuarioEstadoInicial()) {
    on<BlocPerfilUsuarioEventoTraerUsuario>(_traerUsuario);
  }


  /// Trae un usuario y la lista de roles
  Future<void> _traerUsuario(
    BlocPerfilUsuarioEventoTraerUsuario event,
    Emitter<BlocPerfilUsuarioEstado> emit,
  ) async {
    emit(BlocPerfilUsuarioEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final listaRoles = await client.rol.obtenerRoles();

        final usuario = await client.usuario
            .obtenerUsuario(idUsuario: event.idUsuario ?? 0);

        emit(
          BlocPerfilUsuarioEstadoExitosoAltraerUsuario.desde(
            state,
            usuario: usuario,
            listaRoles: listaRoles,
          ),
        );
      },
      onError: (e, st) {
        emit(
          BlocPerfilUsuarioEstadoError.desde(state),
        );
      },
    );
  }

}
