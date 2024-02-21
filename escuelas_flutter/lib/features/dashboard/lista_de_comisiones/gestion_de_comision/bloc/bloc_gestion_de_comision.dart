import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/extensiones.dart';
import 'package:meta/meta.dart';

part 'bloc_gestion_de_comision_evento.dart';
part 'bloc_gestion_de_comision_estado.dart';

/// {@template BlocGestionDeComision}
/// Bloc que maneja los estados y lógica de la '[PaginaGestionDeComision]'
/// {@endtemplate}
class BlocGestionDeComision
    extends Bloc<BlocGestionDeComisionEvento, BlocGestionDeComisionEstado> {
  /// {@macro BlocGestionDeComision}

  BlocGestionDeComision({
    required int idAsignatura,
    required int idComision,
  }) : super(
          BlocGestionDeComisionEstadoInicial(
            idAsignatura: idAsignatura,
            idComision: idComision,
          ),
        ) {
    on<BlocGestionDeComisionEventoInicializar>(_onInicializar);
    on<BlocGestionDeComisionEventoFiltrarPorNombre>(_onFiltrarPorNombre);

    on<BlocGestionDeComisionEventoAsignarDocente>(_onAsignarDocente);
    on<BlocGestionDeComisionEventoAgregarAlumno>(_onAgregarAlumno);
  }

  /// Evento inicial para obtener el docente de la asignatura
  /// y los alumnos de una comision
  Future<void> _onInicializar(
    BlocGestionDeComisionEventoInicializar event,
    Emitter<BlocGestionDeComisionEstado> emit,
  ) async {
    emit(BlocGestionDeComisionEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        /// TODO(mati): decirle a chivo que siempre va a ver 1 solo docente.

        final listaObjetos = await Future.wait([
          client.asignatura.obtenerAsignaturaPorId(id: state.idAsignatura),
          client.usuario.obtenerListaDeEstudiantesDeComision(
            idComision: state.idComision,
          ),
          client.comision
              .obtenerComisionesDeCursoPorId(idComision: state.idComision),
        ]);
        final asignatura = listaObjetos[0] as Asignatura;

        final alumnos =
            List<RelacionComisionUsuario>.from(listaObjetos[1] as List);

        final comision = listaObjetos[2] as ComisionDeCurso;

        final listaAlumnos =
            _devolverUsuariosOrdenadosDependiendoDelNombre(alumnos);

        emit(
          BlocGestionDeComisionEstadoExitoso.desde(
            state,
            asignatura: asignatura,
            listaAlumnos: listaAlumnos,
            comision: comision,
          ),
        );
      },
      onError: (e, st) => BlocGestionDeComisionEstadoFallido.desde(state),
    );
  }

  /// Filtra por nombre dependiendo del rol
  Future<void> _onFiltrarPorNombre(
    BlocGestionDeComisionEventoFiltrarPorNombre event,
    Emitter<BlocGestionDeComisionEstado> emit,
  ) async {
    await operacionBloc(
      callback: (client) async {
        /// TODO(mati): hablado con chivo para que me modifique el endpoint por
        ///  que no le tengo que pasar el id rol
        final usuarios = await client.usuario.obtenerUsuariosSegunRol(
          idRol: event.idRol,
          nombre: event.nombre,
        );

        emit(
          BlocGestionDeComisionEstadoExitoso.desde(
            state,
            usuarios: usuarios,
          ),
        );
      },
      onError: (e, st) => BlocGestionDeComisionEstadoFallido.desde(state),
    );
  }

  /// Asigna un docente a una asignatura
  Future<void> _onAsignarDocente(
    BlocGestionDeComisionEventoAsignarDocente event,
    Emitter<BlocGestionDeComisionEstado> emit,
  ) async {
    emit(BlocGestionDeComisionEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        if ((state.asignatura?.usuarios ?? []).isNotEmpty) {
          await client.asignatura.desasignarUsuarioAAsignatura(
            idDocente: state.asignatura?.usuarios?.last.usuarioId ?? 0,
            comisionId: state.idComision,
            asignaturaId: state.idAsignatura,
          );
        }

        await client.asignatura.asignarDocenteAAsignatura(
          idsAsignaturas: [state.idAsignatura],
          idDocente: event.docente?.id ?? 0,
          idComision: state.idComision,
        );

        final asignatura = state.asignatura;

        if (event.docente != null) {
          asignatura?.usuarios?.add(
            RelacionAsignaturaUsuario(
              usuarioId: event.docente?.idUserInfo ?? 0,
              asignaturaId: state.idAsignatura,
              comisionId: state.idComision,
              ultimaModificacion: DateTime.now(),
              fechaCreacion: DateTime.now(),
              usuario: Usuario(
                idUserInfo: event.docente?.idUserInfo ?? 0,
                nombre: event.docente?.nombre ?? '',
                apellido: event.docente?.apellido ?? '',
                urlFotoDePerfil: event.docente?.urlFotoDePerfil ?? '',
              ),
            ),
          );
        }
        emit(
          BlocGestionDeComisionEstadoExitosoAlAsignarDocente.desde(
            state,
            asignatura: asignatura,
          ),
        );
      },
      onError: (e, st) => BlocGestionDeComisionEstadoFallido.desde(state),
    );
  }

  /// Agrega un nuevo alumno a una comision
  Future<void> _onAgregarAlumno(
    BlocGestionDeComisionEventoAgregarAlumno event,
    Emitter<BlocGestionDeComisionEstado> emit,
  ) async {
    emit(BlocGestionDeComisionEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        await client.comision.cambiarUsuarioDeComision(
          state.idComision,
          event.alumno.id ?? 0,
        );

        final listaAlumno = _agregarUsuario(state.listaAlumnos, event.alumno);

        emit(
          BlocGestionDeComisionEstadoExitosoAlAgregarAlumnoAComision.desde(
            state,
            listaAlumnos: listaAlumno,
          ),
        );
      },
      onError: (e, st) => BlocGestionDeComisionEstadoFallido.desde(state),
    );
  }
}

/// esto agrega uno nuevo a la lista de usuarios ordenados.
UsuariosOrdenados? _agregarUsuario(
  UsuariosOrdenados? usuariosOrdenados,
  Usuario? nuevoUsuario,
) {
  if (nuevoUsuario == null) {
    return usuariosOrdenados;
  }

  // Obtener la primera letra del nuevo usuario
  final primeraLetra = nuevoUsuario.nombre.substring(0, 1).toLowerCase();

  // Buscar si ya existe una lista de usuarios con esa primera letra
  final index = usuariosOrdenados?.usuariosListados.indexWhere(
        (element) => element.etiquetaDelIndexListado == primeraLetra,
      ) ??
      0;

  if (index != -1) {
    final existeUsuario = usuariosOrdenados?.usuariosListados[index].usuarios
            .any((usuario) => usuario.id == nuevoUsuario.id) ??
        false;

    if (!existeUsuario) {
      // Si el usuario no existe en la lista, lo agregamos
      final nuevaLista = [
        ...usuariosOrdenados!.usuariosListados[index].usuarios,
        nuevoUsuario,
      ];

      usuariosOrdenados.usuariosListados[index] = UsuariosListados(
        etiquetaDelIndexListado: primeraLetra,
        usuarios: nuevaLista,
      );
    }
  } else {
    // Si no existe una lista de usuarios con esa primera letra,
    // creamos una nueva lista con el nuevo usuario
    final nuevaLista = [nuevoUsuario];
    usuariosOrdenados?.usuariosListados.add(
      UsuariosListados(
        etiquetaDelIndexListado: primeraLetra,
        usuarios: nuevaLista,
      ),
    );
  }

  return usuariosOrdenados;
}

/// Devuelve la lista de usuarios ordenados dependiendo del nombre del alumno.
UsuariosOrdenados _devolverUsuariosOrdenadosDependiendoDelNombre(
  List<RelacionComisionUsuario> alumnos,
) {
  /// agrupar por primera letra
  final usuariosAgrupados = <String, List<Usuario>>{};

  /// hago un formato de lista para poder ordenar
  for (final usuario in alumnos) {
    /// saco la primera letra del nombre
    final primeraLetra =
        (usuario.usuario?.nombre ?? '').substring(0, 1).toLowerCase();

    /// los agrupo segun la primera letra
    if (!usuariosAgrupados.containsKey(primeraLetra)) {
      usuariosAgrupados[primeraLetra] = [];
    }

    /// agrego el usuario a esa lista
    usuariosAgrupados[primeraLetra]!.add(usuario.usuario!);
  }

  /// armo la lista de listas de usuarios
  final alumnosListado = <UsuariosListados>[];

  /// agrego las listas de usuarios a la lista de usuariosListado
  usuariosAgrupados.forEach((letra, usuarios) {
    alumnosListado.add(
      UsuariosListados(
        etiquetaDelIndexListado: letra,
        usuarios: usuarios,
      ),
    );
  });

  /// Devuelvo la lista de usuarios ordenados EJ:
  /// R
  /// usuarios(nombre: rodrigo)
  /// C
  /// usuarios (nombre: carlos)
  /// usuarios (nombre: carolina)
  return UsuariosOrdenados(
    opcionesDeOrdenamiento: [OrdenarPor.apellido],
    usuariosListados: alumnosListado,
  );
}
