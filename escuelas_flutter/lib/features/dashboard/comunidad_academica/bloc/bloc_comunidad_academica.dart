import 'package:collection/collection.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/pagina_comunidad_academica.dart';
import 'package:escuelas_flutter/utilidades/funciones/funciones.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_comunidad_academica_estado.dart';
part 'bloc_comunidad_academica_evento.dart';

/// {@template BlocComunidadAcademica}
/// Bloc que maneja los estados y lógica de la '[PaginaComunidadAcademica]'
/// {@endtemplate}
class BlocComunidadAcademica
    extends Bloc<BlocComunidadAcademicaEvento, BlocComunidadAcademicaEstado> {
  /// {@macro Bloc[PaginaComunidadAcademica]}
  BlocComunidadAcademica()
      : super(const BlocComunidadAcademicaEstadoInicial()) {
    on<BlocComunidadAcademicaEventoInicializar>(_onInicializar);
    on<BlocComunidadAcademicaEventoTraerUsuariosPorRol>(_onTraerUsuariosPorRol);
    on<BlocComunidadAcademicaEventoOrdenarAlfabeticamente>(
      _onOrdenarAlfabeticamente,
    );
  }

  /// Trae todos los roles de la institucion
  Future<void> _onInicializar(
    BlocComunidadAcademicaEventoInicializar evento,
    Emitter<BlocComunidadAcademicaEstado> emit,
  ) async {
    emit(BlocComunidadAcademicaEstadoCargando.desde(state));
    await operacionBloc(
      callback: () async {
        // TODO(anyone): Eliminar hardcodeo y utilizar endpoint
        // final listadoRoles = await traertodoslosroles;
        final listadoRoles = [
          RolDeUsuario(
            nombre: 'Administrador',
            descripcion: 'Administrador',
            id: 1,
          ),
          RolDeUsuario(
            nombre: 'Docente',
            descripcion: 'Docente',
            id: 2,
          ),
          RolDeUsuario(
            nombre: 'Alumno',
            descripcion: 'Alumno',
            id: 3,
          ),
        ];
        emit(
          BlocComunidadAcademicaEstadoExitoso.desde(
            state,
            listaRoles: listadoRoles,
          ),
        );
      },
      onError: (e, st) {
        emit(BlocComunidadAcademicaEstadoError.desde(state));
      },
    );
  }

  /// Trae todos los usuarios de la institucion que tengan el rol seleccionado
  Future<void> _onTraerUsuariosPorRol(
    BlocComunidadAcademicaEventoTraerUsuariosPorRol event,
    Emitter<BlocComunidadAcademicaEstado> emit,
  ) async {
    emit(BlocComunidadAcademicaEstadoCargando.desde(state));
    await operacionBloc(
      callback: () async {
        // TODO(anyone): Eliminar hardcodeo y utilizar endpoint
        // final listaUsuarios = await traerUsuarioPorRol(event.idRol));
        final listaUsuarios = [
          Usuario2(
            nombre: 'as',
            id: 1,
            fechaCreacion: DateTime.now(),
            ultimaModificacion: DateTime.now(),
            idUserInfo: 1,
            roles: [],
            dni: '14',
          ),
          Usuario2(
            nombre: 'basad',
            id: 1,
            fechaCreacion: DateTime.now(),
            ultimaModificacion: DateTime.now(),
            idUserInfo: 1,
            roles: [],
            dni: '14',
          ),
          Usuario2(
            nombre: 'casd',
            id: 1,
            fechaCreacion: DateTime.now(),
            ultimaModificacion: DateTime.now(),
            idUserInfo: 1,
            roles: [],
            dni: '14',
          ),
          Usuario2(
            nombre: 'dasd',
            id: 1,
            fechaCreacion: DateTime.now(),
            ultimaModificacion: DateTime.now(),
            idUserInfo: 1,
            roles: [],
            dni: '14',
          ),
        ];
        emit(
          BlocComunidadAcademicaEstadoExitosoAlTraerUsuarios.desde(
            state,
            listaUsuarios: listaUsuarios,
          ),
        );
      },
      onError: (e, st) {
        emit(BlocComunidadAcademicaEstadoError.desde(state));
      },
    );
  }

  /// Ordena los usuarios alfabeticamente
  void _onOrdenarAlfabeticamente(
    BlocComunidadAcademicaEventoOrdenarAlfabeticamente event,
    Emitter<BlocComunidadAcademicaEstado> emit,
  ) {
    final listaUsuarios = state.listaUsuarios
      ..sort((a, b) => a.nombre.compareTo(b.nombre));

    final ordenes = <Categoria>[];

    for (final usuario in listaUsuarios) {
      final primeraLetra = usuario.nombre.substring(0, 1).toUpperCase();

      final ordenExistente =
          ordenes.firstWhereOrNull((orden) => orden.categoria == primeraLetra);

      if (ordenExistente != null) {
        ordenExistente.lista.add(usuario);
      } else {
        ordenes.add(Categoria(categoria: primeraLetra, lista: [usuario]));
      }
    }

    emit(
      BlocComunidadAcademicaEstadoExitosoAlOrdenar.desde(
        state,
        listaOrdenada: ordenes,
      ),
    );
  }
}

// TODO(anyone): Eliminar cuando usuario tenga nombre
class Usuario2 {
  Usuario2({
    required this.id,
    required this.fechaCreacion,
    required this.ultimaModificacion,
    required this.idUserInfo,
    required this.roles,
    required this.dni,
    required this.nombre,
  });
  final String nombre;
  final int id;
  final DateTime fechaCreacion;
  final DateTime ultimaModificacion;
  final int idUserInfo;
  final List<RolDeUsuario> roles;
  final String dni;
}

/// {@template Categoria}
/// Clase que agrupa una lista de usuarios por una categoria
/// {@endtemplate}
class Categoria {
  /// {@macro Categoria}
  Categoria({
    required this.categoria,
    required this.lista,
  });

  /// Nombre de la categoria
  final String categoria;

  /// Lista de usuarios de la categoria seleccionada
  final List<Usuario2> lista;
}
