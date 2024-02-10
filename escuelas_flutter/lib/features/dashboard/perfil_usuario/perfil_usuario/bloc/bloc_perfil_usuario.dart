import 'package:collection/collection.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/features/auth/kyc/bloc/bloc_kyc.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/pagina_perfil_usuario.dart';
import 'package:escuelas_flutter/features/dashboard/perfil_usuario/widgets/seccion_cursos.dart';
import 'package:escuelas_flutter/widgets/escuelas_dropdown.dart';
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
    on<BlocPerfilUsuarioEventoInsertarInformacionDeKyc>(_onInsertarDataKyC);
    on<BlocPerfilUsuarioEventoEliminarDocente>(_onEliminarDocente);
    on<BlocPerfilUsuarioEventoTraerAsignaturasComisiones>(_onTraerAsignaturas);
    on<BlocPerfilUsuarioEventoAgregarAsignatura>(_onAgregarAsignatura);
    on<BlocPerfilUsuarioEventoQuitarAsignatura>(_onQuitarAsignatura);
    add(const BlocPerfilUsuarioEventoTraerAsignaturasComisiones());
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

  /// Edita los datos personales del docente
  Future<void> _onInsertarDataKyC(
    BlocPerfilUsuarioEventoInsertarInformacionDeKyc event,
    Emitter<BlocPerfilUsuarioEstado> emit,
  ) async {
    emit(BlocPerfilUsuarioEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        await client.usuario.actualizarUsuario(usuario: state.usuario!);

        emit(BlocPerfilUsuarioEstadoExitoso.desde(state));
      },
      onError: (e, st) {
        emit(BlocPerfilUsuarioEstadoError.desde(state));
      },
    );
  }

  /// Elimina al docente seleccionado
  Future<void> _onEliminarDocente(
    BlocPerfilUsuarioEventoEliminarDocente event,
    Emitter<BlocPerfilUsuarioEstado> emit,
  ) async {
    emit(BlocPerfilUsuarioEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        await client.usuario.softDeleteUsuario(idUsuario: event.idUsuario);
        emit(BlocPerfilUsuarioEstadoExitosoAlEliminarUsuario.desde(state));
      },
      onError: (e, st) {
        emit(BlocPerfilUsuarioEstadoError.desde(state));
      },
    );
  }

  /// Trae asignaturas y comisiones para asignarselas a un docente
  Future<void> _onTraerAsignaturas(
    BlocPerfilUsuarioEventoTraerAsignaturasComisiones event,
    Emitter<BlocPerfilUsuarioEstado> emit,
  ) async {
    emit(BlocPerfilUsuarioEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        // Crea una lista de objetos y espera a que todas las llamadas
        // que se hacen el mismo tiempo y cuando se terminan todas continua.
        final listaObjetos = await Future.wait([
          client.asignatura.obtenerAsignaturas(),
          client.comision.obtenerComisiones(),
        ]);

        // Luego para acceder a cada item de la lista como ya se que me va a
        // devolver el endpoint lo casteo.
        final asignaturas = List<Asignatura>.from(listaObjetos[0]);

        final comisiones = List<ComisionDeCurso>.from(listaObjetos[1]);

        emit(
          BlocPerfilUsuarioEstadoExitosoALTraerAsignaturas.desde(
            state,
            listaAsignaturas: asignaturas,
            listaComisiones: comisiones,
          ),
        );
      },
      onError: (e, st) {
        emit(BlocPerfilUsuarioEstadoError.desde(state));
      },
    );
  }

  /// Agrega asignatura seleccionada al docente
  Future<void> _onAgregarAsignatura(
    BlocPerfilUsuarioEventoAgregarAsignatura event,
    Emitter<BlocPerfilUsuarioEstado> emit,
  ) async {
    emit(BlocPerfilUsuarioEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        await client.asignatura.asignarDocenteAAsignatura(
          idsAsignaturas: [event.idAsignaturaSeleccionada],
          idDocente: state.usuario?.id ?? 0,
          idComision: event.idComisionSeleccionada,
        );

        state.usuario?.asignaturas?.add(
          RelacionAsignaturaUsuario(
            asignaturaId: event.idAsignaturaSeleccionada,
            usuarioId: state.usuario?.id ?? 0,
            id: event.idAsignaturaSeleccionada,
            comisionId: event.idComisionSeleccionada,
            ultimaModificacion: DateTime.now(),
            fechaCreacion: DateTime.now(),
          ),
        );
        emit(BlocPerfilUsuarioEstadoExitoso.desde(state));
      },
      onError: (e, st) {
        emit(BlocPerfilUsuarioEstadoError.desde(state));
      },
    );
  }

  /// Quita una asignatura existente de un docente
  Future<void> _onQuitarAsignatura(
    BlocPerfilUsuarioEventoQuitarAsignatura event,
    Emitter<BlocPerfilUsuarioEstado> emit,
  ) async {
    emit(BlocPerfilUsuarioEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        await client.asignatura.desasignarUsuarioAAsignatura(
          idDocente: event.idUsuario,
          comisionId: event.idComision,
          asignaturaId: event.idAsignatura,
        );
        emit(BlocPerfilUsuarioEstadoExitoso.desde(state));
      },
      onError: (e, st) {
        emit(BlocPerfilUsuarioEstadoError.desde(state));
      },
    );
  }
}
