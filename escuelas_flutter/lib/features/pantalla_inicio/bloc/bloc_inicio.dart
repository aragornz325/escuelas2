import 'package:bloc/bloc.dart';
import 'package:escuelas_flutter/features/pantalla_inicio/utilidades/enum_info_rol.dart';

part 'bloc_inicio_estado.dart';
part 'bloc_inicio_evento.dart';

/// {@template BlocInicio}
/// Administra la logica de la página que muestra la información general
/// de la pagina Inicio.
/// {@endtemplate}
class BlocInicio extends Bloc<BlocInicioEvento, BlocInicioEstado> {
  /// {@macro BlocInicio}
  BlocInicio(InfoUsuario infoUsuario)
      : super(BlocInicioEstadoInicial(infoUsuario)) {
    on<BlocInicioEventoTraerInfoInicial>(_onInicializar);
  }

  /// Trae la informacion de acuerdo a los permisos del usuario.
  Future<void> _onInicializar(
    BlocInicioEventoTraerInfoInicial event,
    Emitter<BlocInicioEstado> emit,
  ) async {
    emit(BlocInicioEstadoCargando.desde(state));
// TODO(SAM): Cambiar cuando este el endpoint del back.
    // await operacionBloc(
    //   callback: (client) async {
    //     final Inicio = await client.cliente.obtenerInicioDelUsuario();

    //     emit(
    //       BlocInicioEstadoExitoso.desde(
    //         state,
    //         InicioDeUsuario: Inicio,
    //       ),
    //     );
    //   },
    //   onError: (e, st) => BlocInicioEstadoFallido.desde(
    //     state,
    //     errorMessage: e.toString(),
    //   ),
    // );

    emit(
      BlocInicioEstadoExitoso.desde(
        state,
      ),
    );
  }
}

// TODO(SAM): Eliminar luego cuando venga del back
enum Permiso { directivo, alumno, profesor }

class InfoUsuario {
  InfoUsuario({required this.nombre, required this.permiso});
  String nombre;
  List<Permiso> permiso;
}
