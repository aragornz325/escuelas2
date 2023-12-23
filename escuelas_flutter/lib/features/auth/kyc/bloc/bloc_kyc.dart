import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_kyc_estado.dart';
part 'bloc_kyc_evento.dart';

/// {@template BlocKyc}
/// Bloc que maneja los estados y lógica de la pagina de 'Inicio'
/// {@endtemplate}
class BlocKyc extends Bloc<BlocKycEvento, BlocKycEstado> {
  /// {@macro BlocInicio}
  BlocKyc() : super(const BlocKycEstadoInicial()) {
    on<BlocKycEventoInicializar>(_inicializar);
    add(const BlocKycEventoInicializar());
  }

  /// Evento inicial donde trae todos los articulos/Entregable del usuario.
  Future<void> _inicializar(
    BlocKycEventoInicializar event,
    Emitter<BlocKycEstado> emit,
  ) async {
    emit(BlocKycEstadoCargando.desde(state));
    await operacionBloc(
      callback: (client) async {
        // final materias =await client.;
        // final cursos =await client.;

        final cursos = [Curso(nombre: 'PRIMERO')];
        final materias = [Materia(nombre: 'MATEMATICA')];
        emit(
          BlocKycEstadoExitoso.desde(
            state,
            listaCursos: cursos,
            listaMaterias: materias,
          ),
        );
      },
      onError: (e, st) {
        emit(
          BlocKycEstadoError.desde(
            state,
          ),
        );
      },
    );
  }
}

class OpcionKyc {
  OpcionKyc(this.curso, this.materia);
  Curso curso;
  Materia materia;
}

class Curso {
  Curso({required this.nombre});
  String nombre;
}

class Materia {
  Materia({required this.nombre});
  String nombre;
}
