import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bloc_perfil_comunicados_evento.dart';
part 'bloc_perfil_comunicados_estado.dart';

/// {@template BlocPerfilComunicados}
/// TODO(mati) add docu
/// {@endtemplate}
class BlocPerfilComunicados
    extends Bloc<BlocPerfilComunicadosEvento, BlocPerfilComunicadosEstado> {
  /// {@macro BlocPerfilComunicados}
  BlocPerfilComunicados() : super(BlocPerfilComunicadosEstadoInicial()) {
    on<BlocPerfilComunicadosEvento>((event, emit) {
      // TODO: implement event handler
    });
  }
}
