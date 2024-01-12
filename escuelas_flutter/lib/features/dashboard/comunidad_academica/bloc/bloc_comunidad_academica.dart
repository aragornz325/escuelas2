import 'package:collection/collection.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/features/dashboard/comunidad_academica/pagina_comunidad_academica.dart';
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
  }

  /// Trae todos los roles de la institucion
  Future<void> _onInicializar(
    BlocComunidadAcademicaEventoInicializar evento,
    Emitter<BlocComunidadAcademicaEstado> emit,
  ) async {
    emit(BlocComunidadAcademicaEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        final listadoRoles = await client.rol.obtenerRoles();
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
      callback: (client) async {
        final listaUsuarios =
            await client.usuario.obtenerUsuariosPorRolSorteados(
          idRol: event.idRol != null ? (event.idRol ?? 0) : state.idRol,
          ordenarUsuariosPor: event.ordenarPor,
        );

        final rolElegido =
            state.listaRoles.firstWhereOrNull((rol) => rol.id == event.idRol);

        emit(
          BlocComunidadAcademicaEstadoExitosoAlTraerUsuarios.desde(
            state,
            listaUsuarios: listaUsuarios,
            idRol: event.idRol ?? state.idRol,
            ordenarPor: event.ordenarPor,
            rolElegido: rolElegido,
          ),
        );
      },
      onError: (e, st) {
        emit(BlocComunidadAcademicaEstadoError.desde(state));
      },
    );
  }
}
