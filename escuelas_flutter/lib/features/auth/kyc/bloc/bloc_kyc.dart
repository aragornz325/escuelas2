import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/asignatura.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/extensiones/comision_de_curso.dart';
import 'package:escuelas_flutter/extensiones/user_info.dart';
import 'package:escuelas_flutter/isar/isar_servicio.dart';
import 'package:escuelas_flutter/utilidades/funciones/cerrar_sesion_usuario.dart';
import 'package:escuelas_flutter/widgets/escuelas_dropdown.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rolemissions/rolemissions.dart';
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
    on<BlocKycEventoVaciarLista>(_onVaciarLista);
  }

  /// Evento inicial donde trae todos los cursos del usuario.
  Future<void> _onInicializar(
    BlocKycEventoInicializar event,
    Emitter<BlocKycEstado> emit,
  ) async {
    emit(BlocKycEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final usuarioPendiente = await client.usuario.obtenerUsuarioPendiente();

        if (usuarioPendiente?.estadoDeSolicitud == EstadoDeSolicitud.aprobado) {
          await IsarServicio.eliminarUsuariosPendientes();

          final usuario = await client.usuario.obtenerDatosDelUsuario();

          await IsarServicio.guardarUsuario(usuario);

          return emit(
            BlocKycEstadoExitoSolicitudAprobada.desde(
              state,
              usuario: usuario,
            ),
          );
        }

        // Crea una lista de objetos y espera a que todas las llamadas
        // que se hacen el mismo tiempo y cuando se terminan todas continua.
        final listaObjetos = await Future.wait([
          client.asignatura.obtenerAsignaturas(),
          client.comision.obtenerComisiones(),
          client.rol.obtenerRoles(),
        ]);

        // Luego para acceder a cada item de la lista como ya se que me va a
        // devolver el endpoint lo casteo.
        final asignaturas = List<Asignatura>.from(listaObjetos[0]);

        final comisiones = List<ComisionDeCurso>.from(listaObjetos[1]);

        final roles = List<Role>.from(listaObjetos[2]);

        // TODO(anyone): Ver como manejar los roles que se muestran

        final rolesAMostrar = roles
            .where((rol) => rol.name == 'alumno' || rol.name == 'docente')
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

    final existeOpcionConEsaId = nuevaListaOpciones.any(
      (element) =>
          element.comisionSeleccionada?.id == event.idComisionSeleccionada &&
          element.asignaturaSeleccionada?.id == event.idAsignaturaSeleccionada,
    );
    if (!existeOpcionConEsaId) {
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
      return emit(
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

    final opcion = nuevaListaOpciones.any(
      (element) =>
          element.comisionSeleccionada?.id == event.idComisionSeleccionada,
    );

    if (!opcion) {
      nuevaListaOpciones.add(
        OpcionFormulario(
          idOpcion: state.opcionesFormulario.length + 1,
          comisionSeleccionada: state.listaComisiones.firstWhere(
            (element) => element.id == event.idComisionSeleccionada,
          ),
        ),
      );
    } else {
      return emit(
        BlocKycEstadoErrorOpcionYaElegida.desde(
          state,
        ),
      );
    }

    emit(
      BlocKycEstadoExitoso.desde(
        state,
        opcionesFormulario: nuevaListaOpciones,
      ),
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

  /// Solicita el registro del usuario con las opciones del formulario
  Future<void> _onSolicitarRegistro(
    BlocKycEventoSolicitarRegistro event,
    Emitter<BlocKycEstado> emit,
  ) async {
    emit(BlocKycEstadoCargando.desde(state));

    await operacionBloc(
      callback: (client) async {
        final usuario = event.userInfo;

        final usuarioPendiente = UsuarioPendiente(
          idUserInfo: usuario?.id ?? 0,
          nombre: usuario?.fullName ?? '',
          apellido: usuario?.apellido ?? '',
          urlFotoDePerfil: usuario?.imageUrl ?? '',
          idRolSolicitado: state.rolElegido?.id ?? 0,
          estadoDeSolicitud: EstadoDeSolicitud.pendiente,
        );

        if (state.rolElegido?.name == 'docente') {
          final solicitudAsignaturas = state.opcionesFormulario.map((opcion) {
            final asignatura = opcion.asignaturaSeleccionada!;
            final comision = opcion.comisionSeleccionada!;

            // Creacion del objeto a partir de las opciones de formulario
            return AsignaturaSolicitada(
              asignaturaId: asignatura.id ?? 0,
              asignatura: asignatura,
              comisionId: comision.id ?? 0,
              comision: comision,
              idUsuarioPendiente: usuarioPendiente.id ?? 0,
              ultimaModificacion: DateTime.now(),
              fechaCreacion: DateTime.now(),
            );
          }).toList();

          final usuarioPendienteDocente =
              await client.usuario.enviarSolicitudRegistroDocente(
            usuarioPendiente: usuarioPendiente,
            asignaturasSolicitadas: solicitudAsignaturas,
          );
          await IsarServicio.guardarUsuarioPendiente(usuarioPendienteDocente);
        }

        if (state.rolElegido?.name == 'alumno') {
          final usuarioPendienteAlumno =
              await client.usuario.enviarSolicitudRegistroAlumno(
            idComisionDeCursoSolicitada:
                state.opcionesFormulario.first.comisionSeleccionada?.id ?? 0,
            usuarioPendiente: usuarioPendiente,
          );
          await IsarServicio.guardarUsuarioPendiente(usuarioPendienteAlumno);
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
        await cerrarSesionUsuario();
        emit(BlocKycEstadoCerrarSesionExitoso.desde(state));
      },
      onError: (e, st) {
        emit(
          BlocKycEstadoFallido.desde(state),
        );
      },
    );
  }

  void _onVaciarLista(
    BlocKycEventoVaciarLista event,
    Emitter<BlocKycEstado> emit,
  ) {
    emit(
      BlocKycEstadoExitoso.desde(
        state,
        opcionesFormulario: [],
      ),
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

  final ComisionDeCurso? comisionSeleccionada;

  final Asignatura? asignaturaSeleccionada;

  final int idOpcion;
}
