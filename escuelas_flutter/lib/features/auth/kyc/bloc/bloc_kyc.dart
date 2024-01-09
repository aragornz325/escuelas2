import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/utilidades/cliente_serverpod.dart';
import 'package:escuelas_flutter/widgets/escuelas_dropdown_popup.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// TODO(anyone): Revisar si esto sirve, tenia un problema de importaciones con el userInfo y el protocol
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
    on<BlocKycEventoSeleccionarCursoYMateria>(_seleccionarCursoYMateria);
    on<BlocKycEventoAgregarOpcion>(_agregarOpcion);
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

        // final cursos = await client.curso.obtenerCursos();

        final roles = await client.rol.obtenerRoles();
        // TODO(anyone): Ver como manejar los roles que se muestran
        // final rolesAMostrar = roles
        //     .where((rol) => rol.nombre == 'Mati' || rol.nombre == 'Chepibe')
        //     .toList();
        emit(
          BlocKycEstadoExitoso.desde(
            state,
            listaAsignaturas: asignaturas,
            listaCursos: [
              Curso(
                id: 0,
                nombre: 'Primero A',
                ultimaModificacion: DateTime.now(),
                fechaCreacion: DateTime.now(),
              ),
              Curso(
                id: 1,
                nombre: 'Primero b',
                ultimaModificacion: DateTime.now(),
                fechaCreacion: DateTime.now(),
              ),
              Curso(
                id: 2,
                nombre: 'Primero c',
                ultimaModificacion: DateTime.now(),
                fechaCreacion: DateTime.now(),
              ),
            ],
            listaRoles: roles,
          ),
        );
      },
      onError: (e, st) {
        emit(
          BlocKycEstadoError.desde(state),
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
        eliminarRolSeleccionado: event.eliminarRolSeleccionado,
      ),
    );
  }

  /// Se selecciona el curso y la materia de la opcion de kyc
  void _seleccionarCursoYMateria(
    BlocKycEventoSeleccionarCursoYMateria event,
    Emitter<BlocKycEstado> emit,
  ) {
    // final nuevaListaOpciones =
    //     List<OpcionFormulario>.from(state.opcionesFormulario);

    // final opcionAModificar = nuevaListaOpciones
    //     .firstWhere((opcionKyc) => opcionKyc.idOpcion == event.idOpcion);

    // if (event.idCurso != null) {
    //   opcionAModificar.curso =
    //       state.listaCursos.firstWhere((curso) => curso.id == event.idCurso);
    // }

    // if (event.idMateria != null) {
    //   opcionAModificar.asignatura = state.listaAsignaturas
    //       .firstWhere((materia) => materia.id == event.idMateria);
    // }

    emit(
      BlocKycEstadoExitoso.desde(
        state,
        // opcionesFormulario: nuevaListaOpciones,
      ),
    );
  }

  /// Agrega una nueva opcion a la lista de kyc
  void _agregarOpcion(
    BlocKycEventoAgregarOpcion event,
    Emitter<BlocKycEstado> emit,
  ) {
    final nuevaListaOpciones = List<OpcionFormulario>.from(
      state.opcionesFormulario,
    )..add(
        OpcionFormulario(
          idOpcion: state.opcionesFormulario.length + 1,
          nombreCursoSeleccionado: state.listaCursos
              .firstWhere((element) => element.id == event.idCursoSeleccionado)
              .nombre,
          nombreAsignaturaSeleccionado: state.listaAsignaturas
              .firstWhere(
                (element) => element.id == event.idAsignaturaSeleccionada,
              )
              .nombre,
        ),
      );
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
            BlocKycEstadoError.desde(state),
          );
        }
      },
      onError: (e, st) {
        emit(
          BlocKycEstadoError.desde(state),
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
        final usuarioPendiente = UsuarioPendiente(
          idUserInfo: sessionManager.signedInUser?.id ?? 0,
          nombre: sessionManager.signedInUser?.fullName ?? '',
          apellido: sessionManager.signedInUser?.userName ?? '',
          urlFotoDePerfil: sessionManager.signedInUser?.imageUrl ?? '',
          dni: '123',
          rolSolicitado: state.rolElegido?.id ?? 0,
          estadoDeSolicitud: EstadoDeSolicitud.pendiente,
        );
        if (state.rolElegido?.nombre == 'docente') {
          await client.usuario.enviarSolicitudRegistroDocente(
            asignaturasASolicitar: state.listaAsignaturas,
            usuarioPendiente: usuarioPendiente,
          );
        }
        if (state.rolElegido?.nombre == 'Admin') {
          await client.usuario.enviarSolicitudRegistroAlumno(
            comisionDeCurso: ComisionDeCurso(
              nombre: state.listaCursos
                  .firstWhere(
                    (element) =>
                        element.nombre ==
                        state.opcionesFormulario.first.nombreCursoSeleccionado,
                  )
                  .nombre,
              idCurso: state.listaCursos
                      .firstWhere(
                        (element) =>
                            element.nombre ==
                            state.opcionesFormulario.first
                                .nombreCursoSeleccionado,
                      )
                      .id ??
                  0,
              anioLectivo: 2021,
              estudiantes: [],
              ultimaModificacion: DateTime.now(),
              fechaCreacion: DateTime.now(),
            ),
            usuarioPendiente: usuarioPendiente,
          );
        }
        emit(
          BlocKycEstadoExitoAlSolicitarRegistro.desde(state),
        );
      },
      onError: (e, st) {
        emit(
          BlocKycEstadoError.desde(state),
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
    required this.nombreCursoSeleccionado,
    required this.nombreAsignaturaSeleccionado,
    required this.idOpcion,
  });

  factory OpcionFormulario.fromJson(Map<String, dynamic> json) {
    return OpcionFormulario(
      nombreCursoSeleccionado: json['nombreCursoSeleccionado'] as String,
      nombreAsignaturaSeleccionado:
          json['nombreAsignaturaSeleccionado'] as String,
      idOpcion: json['idOpcion'] as int,
    );
  }

  String nombreCursoSeleccionado;
  String nombreAsignaturaSeleccionado;
  final int idOpcion;

  Map<String, dynamic> toJson() {
    return {
      'nombreCursoSeleccionado': nombreCursoSeleccionado,
      'nombreAsignaturaSeleccionado': nombreAsignaturaSeleccionado,
      'idOpcion': idOpcion,
    };
  }
}

/// Posee un toJson mas adecuado para la clase [Curso]
/// ya que Serverpod no deserealiza correctamente.
extension CursoX on Curso {
  //! TODO(anyone): Remover esto cuando se arregle el toJson() de Serverpod
  /// toJson para evitar usar el del modelo Serverpod porque no deserializa
  /// correctamente [DateTime] para eso agregamos un  .toIso8601String().
  Map<String, dynamic> toJsonBloc() {
    return {
      'id': id,
      'nombre': nombre,
      'asignaturas':
          asignaturas?.map((asignatura) => asignatura.toJsonBloc()).toList(),
      'ultimaModificacion': ultimaModificacion.toIso8601String(),
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'fechaEliminacion': fechaEliminacion?.toIso8601String(),
    };
  }
}

/// Posee un toJson mas adecuado para la clase [Asignatura]
/// ya que Serverpod no deserealiza correctamente.
extension AsignaturaX on Asignatura {
  Map<String, dynamic> toJsonBloc() {
    return {
      'id': id,
      'nombre': nombre,
      'idCurso': idCurso,
      'ultimaModificacion': ultimaModificacion.toIso8601String(),
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'fechaEliminacion': fechaEliminacion?.toIso8601String(),
    };
  }
}

/// Posee un toJson mas adecuado para la clase [RolDeUsuario]
/// ya que Serverpod no deserealiza correctamente.
extension RolDeUsuarioX on RolDeUsuario {
  Map<String, dynamic> toJsonBloc() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
    };
  }
}
// TODO(SAM): Agregar logout event y tmb clear de localstorage de datos del user
