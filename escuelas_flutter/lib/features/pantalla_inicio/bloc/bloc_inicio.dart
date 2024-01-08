import 'package:bloc/bloc.dart';
import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';

import 'package:escuelas_flutter/features/pantalla_inicio/utilidades/enum_info_rol.dart';

part 'bloc_inicio_estado.dart';
part 'bloc_inicio_evento.dart';

/// {@template BlocInicio}
/// Administra la logica de la página que muestra la información general
/// de la pagina Inicio.
/// {@endtemplate}
class BlocInicio extends Bloc<BlocInicioEvento, BlocInicioEstado> {
  /// {@macro BlocInicio}
  BlocInicio() : super(const BlocInicioEstadoInicial()) {
    on<BlocInicioEventoInicializar>(_onInicializar);
  }

  /// Trae los roles de la institucion que luego se filtraran para mostrar
  Future<void> _onInicializar(
    BlocInicioEventoInicializar event,
    Emitter<BlocInicioEstado> emit,
  ) async {
    emit(BlocInicioEstadoCargando.desde(state));
// TODO(SAM): En algun momento si se requiere info inicial agregar func
    await operacionBloc(
      callback: (client) async {
        final listaRoles = await client.rol.obtenerRoles();

        emit(
          BlocInicioEstadoExitoso.desde(
            state,
            listaRoles: listaRoles,
          ),
        );
      },
      onError: (e, st) {
        emit(
          BlocInicioEstadoFallido.desde(
            state,
          ),
        );
      },
    );
  }
}

// TODO(SAM): Eliminar luego cuando venga del back
enum Permiso { directivo, alumno, docente }
