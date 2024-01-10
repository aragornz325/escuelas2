import 'package:collection/collection.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/asignatura.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/extensiones/comision_de_curso.dart';
import 'package:escuelas_flutter/extensiones/rol_de_usuario.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';
import 'package:escuelas_flutter/widgets/escuelas_dropdown_popup.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// TODO(anyone): Revisar si esto sirve, tenia un problema de importaciones con
// el userInfo y el protocol
import 'package:serverpod_auth_client/module.dart' as auth;

part 'bloc_kyc_estado.dart';
part 'bloc_kyc_evento.dart';

/// {@template BlocKyc}
/// Bloc que maneja los estados y lógica de las paginas de 'Kyc'
/// {@endtemplate}
class BlocKyc extends HydratedBloc<BlocKycEvento, BlocKycEstado> {
  /// {@macro BlocKyc}
  BlocKyc() : super(const BlocKycEstadoInicial()) {
    on<BlocKycEventoInicializar>(_onInicializar);
    on<BlocKycEventoAgregarOpcionDocente>(_agregarOpcionDocente);
    on<BlocKycEventoAgregarOpcionAlumno>(_agregarOpcionAlumno);
    on<BlocKycEventoEliminarOpcion>(_eliminarOpcion);
    on<BlocKycEventoSeleccionarRol>(_seleccionarRol);
    on<BlocKycEventoCerrarSesion>(_cerrarSesion);
    on<BlocKycEventoSolicitarRegistro>(_onSolicitarRegistro);
  }

  /// Evento inicial donde trae todos los cursos del usuario.
  Future<void> _onInicializar(
    BlocKycEventoInicializar event,
    Emitter<BlocKycEstado> emit,
  ) async {
    emit(BlocKycEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final asignaturas = await client.asignatura.obtenerAsignaturas();

        final comisiones = await client.comision.obtenerComisiones();

        final roles = await client.rol.obtenerRoles();
        // TODO(anyone): Ver como manejar los roles que se muestran
        final rolesAMostrar = roles
            .where((rol) => rol.nombre == 'alumno' || rol.nombre == 'docente')
            .toList();
        emit(
          BlocKycEstadoExitoso.desde(
            state,
            listaAsignaturas: asignaturas,
            listaComisiones: comisiones,
            listaRoles: rolesAMostrar,
          ),
        );
      },
      onError: (e, st) {
        emit(
          BlocKycEstadoFallido.desde(state),
        );
      },
    );
  }

  /// Selecciona un rol de la lista en seleccion de roles
  void _seleccionarRol(
    BlocKycEventoSeleccionarRol event,
    Emitter<BlocKycEstado> emit,
  ) {
    emit(
      BlocKycEstadoExitoso.desde(
        state,
        rolElegido: event.rolElegido,
        eliminarRolElegido: event.eliminarRolSeleccionado,
      ),
    );
  }

  /// Agrega una nueva opcion a la lista de kyc
  void _agregarOpcionDocente(
    BlocKycEventoAgregarOpcionDocente event,
    Emitter<BlocKycEstado> emit,
  ) {
    final nuevaListaOpciones = List<OpcionFormulario>.from(
      state.opcionesFormulario,
    );

    final opcion = nuevaListaOpciones.firstWhereOrNull(
      (element) =>
          element.comisionSeleccionada?.id == event.idComisionSeleccionada &&
          element.asignaturaSeleccionada?.id == event.idAsignaturaSeleccionada,
    );
    if (opcion == null) {
      nuevaListaOpciones.add(
        OpcionFormulario(
          idOpcion: state.opcionesFormulario.length + 1,
          comisionSeleccionada: state.listaComisiones.firstWhere(
            (element) => element.id == event.idComisionSeleccionada,
          ),
          asignaturaSeleccionada: state.listaAsignaturas.firstWhere(
            (element) => element.id == event.idAsignaturaSeleccionada,
          ),
        ),
      );
    } else {
      emit(
        BlocKycEstadoErrorOpcionYaElegida.desde(state),
      );
    }
    emit(
      BlocKycEstadoExitoso.desde(
        state,
        opcionesFormulario: nuevaListaOpciones,
      ),
    );
  }

  /// Agrega una nueva opcion a la lista de kyc
  void _agregarOpcionAlumno(
    BlocKycEventoAgregarOpcionAlumno event,
    Emitter<BlocKycEstado> emit,
  ) {
    final nuevaListaOpciones = List<OpcionFormulario>.from(
      state.opcionesFormulario,
    );
    final opcion = nuevaListaOpciones.firstWhereOrNull(
      (element) =>
          element.comisionSeleccionada?.id == event.idComisionSeleccionada,
    );
    if (opcion == null) {
      nuevaListaOpciones.add(
        OpcionFormulario(
          idOpcion: state.opcionesFormulario.length + 1,
          comisionSeleccionada: state.listaComisiones.firstWhere(
            (element) => element.id == event.idComisionSeleccionada,
          ),
        ),
      );
    } else {
      emit(
        BlocKycEstadoErrorOpcionYaElegida.desde(state),
      );
    }

    emit(
      BlocKycEstadoExitoso.desde(
        state,
        opcionesFormulario: nuevaListaOpciones,
      ),
    );
  }

  /// Trata de cerrar la sesión de un usuario.
  /// En caso de error, devuelve un mensaje de fallo
  /// de cierre de sesión.
  Future<void> _cerrarSesion(
    BlocKycEventoCerrarSesion event,
    Emitter<BlocKycEstado> emit,
  ) async {
    emit(BlocKycEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        await sessionManager.signOut();

        if (!sessionManager.isSignedIn) {
          emit(BlocKycEstadoCerrarSesionExitoso.desde(state));
        } else {
          emit(
            BlocKycEstadoFallido.desde(state),
          );
        }
      },
      onError: (e, st) {
        emit(
          BlocKycEstadoFallido.desde(state),
        );
      },
    );
  }

  /// Elimina una opcion de la lista de kyc
  void _eliminarOpcion(
    BlocKycEventoEliminarOpcion event,
    Emitter<BlocKycEstado> emit,
  ) {
    final nuevaListaOpciones =
        List<OpcionFormulario>.from(state.opcionesFormulario)
          ..remove(
            state.opcionesFormulario
                .where((element) => element.idOpcion == event.idOpcion)
                .first,
          );

    emit(
      BlocKycEstadoExitoso.desde(
        state,
        opcionesFormulario: nuevaListaOpciones,
      ),
    );
  }

  /// Elimina una opcion de la lista de kyc
  Future<void> _onSolicitarRegistro(
    BlocKycEventoSolicitarRegistro event,
    Emitter<BlocKycEstado> emit,
  ) async {
    await operacionBloc(
      callback: (client) async {
        final usuario = sessionManager.signedInUser;

        final usuarioPendiente = UsuarioPendiente(
          idUserInfo: usuario?.id ?? 0,
          nombre: usuario?.fullName ?? '',
          apellido: usuario?.userName ?? '',
          urlFotoDePerfil: usuario?.imageUrl ?? '',
          rolSolicitado: state.rolElegido?.id ?? 0,
          estadoDeSolicitud: EstadoDeSolicitud.pendiente,
        );

        if (state.rolElegido?.nombre == 'docente') {
          await client.usuario.enviarSolicitudRegistroDocente(
            asignaturasASolicitar: state.opcionesFormulario
                .map((e) => e.asignaturaSeleccionada!)
                .toList(),
            usuarioPendiente: usuarioPendiente,
          );
        }

        if (state.rolElegido?.nombre == 'alumno') {
          await client.usuario.enviarSolicitudRegistroAlumno(
            comisionDeCurso:
                state.opcionesFormulario.first.comisionSeleccionada!,
            usuarioPendiente: usuarioPendiente,
          );
        }

        emit(
          BlocKycEstadoExitoAlSolicitarRegistro.desde(state),
        );
      },
      onError: (e, st) {
        emit(
          BlocKycEstadoFallido.desde(state),
        );
      },
    );
  }

  /// Factory constructor fromJson para poder ser utilizado en [HydratedBloc]
  /// transforma el objeto json guardado del local storage a la clase estado
  /// del Bloc dentro contiene lo que fue previamente guardado.
  @override
  BlocKycEstado fromJson(Map<String, dynamic> json) {
    return BlocKycEstado.fromJson(json);
  }

  /// Metodo toJson para poder ser utilizado en [HydratedBloc]
  /// transforma el objeto del estado del Bloc a un objeto json para guardarlo
  /// en el local storage y luego poder acceder a el o limpiar estos datos.
  @override
  Map<String, dynamic> toJson(BlocKycEstado state) {
    return state.toJson();
  }
}

class OpcionFormulario {
  OpcionFormulario({
    required this.idOpcion,
    this.comisionSeleccionada,
    this.asignaturaSeleccionada,
  });

  ComisionDeCurso? comisionSeleccionada;
  Asignatura? asignaturaSeleccionada;
  final int idOpcion;
}

// TODO(SAM): Agregar logout event y tmb clear de localstorage de datos del user
