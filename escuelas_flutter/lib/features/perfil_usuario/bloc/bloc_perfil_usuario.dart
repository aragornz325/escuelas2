import 'package:escuelas_flutter/extensiones/extension_bloc.dart';
import 'package:escuelas_flutter/features/auth/modelos_temporales.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_perfil_usuario_estado.dart';
part 'bloc_perfil_usuario_evento.dart';

/// {@template BlocPerfilUsuario}
/// Bloc que maneja los estados y lógica de la pagina de 'Inicio'
/// {@endtemplate}
class BlocPerfilUsuario
    extends Bloc<BlocPerfilUsuarioEvento, BlocPerfilUsuarioEstado> {
  /// {@macro BlocPerfilUsuario}
  BlocPerfilUsuario(this.idUsuario)
      : super(const BlocPerfilUsuarioEstadoInicial()) {
    on<BlocPerfilUsuarioEventoInicializar>(_inicializar);

    add(BlocPerfilUsuarioEventoInicializar(idUsuario: idUsuario));
  }

  /// Id del usuario a mostrar la informacion
  final int idUsuario;

  /// Evento inicial donde trae todos usuarios pendientes de asignar un rol
  Future<void> _inicializar(
    BlocPerfilUsuarioEventoInicializar event,
    Emitter<BlocPerfilUsuarioEstado> emit,
  ) async {
    emit(BlocPerfilUsuarioEstadoCargando.desde(state));
    await operacionBloc(
      callback: (
          // client
          ) async {
        // TODO(Gon): Eliminar hardcodeo y usar endpoint
        // final InfoUsuario usuarioATraerDatos;

        // if (event.idUsuario != null) {
        // usuarioATraerDatos =  sessionManager.signedInUser?.id ;
        // } else {
        // usuarioATraerDatos =  await client.traerusuario;
        // }
        final usuario = listaUsuariosPendientes
            .where((element) => element.id == event.idUsuario)
            .first;
        emit(
          BlocPerfilUsuarioEstadoExitoso.desde(
            state,
            usuario: usuario,
          ),
        );
      },
      onError: (e, st) {
        emit(
          BlocPerfilUsuarioEstadoError.desde(
            state,
          ),
        );
      },
    );
  }
}
