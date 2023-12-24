import 'package:escuelas_flutter/extensiones/extension_bloc.dart';
import 'package:escuelas_flutter/widgets/escuelas_dropdown_popup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bloc_kyc_estado.dart';
part 'bloc_kyc_evento.dart';

/// {@template BlocKyc}
/// Bloc que maneja los estados y lógica de la pagina de 'Inicio'
/// {@endtemplate}
class BlocKyc extends Bloc<BlocKycEvento, BlocKycEstado> {
  /// {@macro BlocInicio}
  BlocKyc(this.rolElegido) : super(const BlocKycEstadoInicial()) {
    on<BlocKycEventoInicializar>(_inicializar);
    on<BlocKycEventoSeleccionarCursoYMateria>(_seleccionarCursoYMateria);
    on<BlocKycEventoAgregarOpcion>(_agregarOpcion);
    add(const BlocKycEventoInicializar());
  }
  final Rol rolElegido;

  /// Evento inicial donde trae todos los cursos del usuario.
  Future<void> _inicializar(
    BlocKycEventoInicializar event,
    Emitter<BlocKycEstado> emit,
  ) async {
    emit(BlocKycEstadoCargando.desde(state));
    await operacionBloc(
      callback: (
          // client
          ) async {
        // TODO(Gon): Eliminar hardcodeo y usar endpoint

        // final materias =await client.;
        // final cursos =await client.;

        final cursos = [
          Curso(nombre: 'PRIMERO', id: 0),
          Curso(nombre: 'SEGUNDO', id: 1),
          Curso(nombre: 'TERCERO', id: 2),
          Curso(nombre: 'CUARTO', id: 3),
        ];
        final materias = [
          Materia(nombre: 'MATEMATICA', id: 0),
          Materia(nombre: 'LENGUA', id: 1),
          Materia(nombre: 'SOCIALES', id: 2),
          Materia(nombre: 'NATURALES', id: 3),
        ];
        emit(
          BlocKycEstadoExitoso.desde(
            state,
            listaCursos: cursos,
            listaMaterias: materias,
            opcionesKyc: [
              // TODO(Gon): Ver manera de cambiar esto
              OpcionKyc(
                id: 0,
                curso: Curso(nombre: '', id: 0),
                materia: Materia(nombre: '', id: 0),
              ),
            ],
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

  /// Se selecciona el curso y la materia de la opcion de kyc
  Future<void> _seleccionarCursoYMateria(
    BlocKycEventoSeleccionarCursoYMateria event,
    Emitter<BlocKycEstado> emit,
  ) async {
    emit(BlocKycEstadoCargando.desde(state));
    await operacionBloc(
      callback: (
          // client
          ) async {
        final nuevaListaOpciones = List<OpcionKyc>.from(state.opcionesKyc);

        final opcionAModificar = nuevaListaOpciones
            .firstWhere((opcionKyc) => opcionKyc.id == event.idOpcion);

        if (event.idCurso != null) {
          opcionAModificar.curso = state.listaCursos
              .firstWhere((curso) => curso.id == event.idCurso);
        }

        if (event.idMateria != null) {
          opcionAModificar.materia = state.listaMaterias
              .firstWhere((materia) => materia.id == event.idMateria);
        }

        emit(
          BlocKycEstadoExitoso.desde(
            state,
            opcionesKyc: nuevaListaOpciones,
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

  /// Agrega una nueva opcion a la lista de kyc
  Future<void> _agregarOpcion(
    BlocKycEventoAgregarOpcion event,
    Emitter<BlocKycEstado> emit,
  ) async {
    emit(BlocKycEstadoCargando.desde(state));
    await operacionBloc(
      callback: (
          // client
          ) async {
        state.opcionesKyc.add(
          OpcionKyc(
            id: state.opcionesKyc.length + 1,
            curso: Curso(
              nombre: '',
              id: 0,
            ),
            materia: Materia(
              nombre: '',
              id: 0,
            ),
          ),
        );
        emit(
          BlocKycEstadoExitoso.desde(
            state,
            opcionesKyc: state.opcionesKyc,
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

// TODO(Gon): Eliminar modelo cuando se usen los del back
class OpcionKyc {
  OpcionKyc({required this.curso, required this.materia, required this.id});
  Curso curso;
  Materia materia;
  final int id;
}

// TODO(Gon): Eliminar modelo cuando se usen los del back
class Curso {
  Curso({
    required this.nombre,
    required this.id,
  });
  final String nombre;
  final int id;
}

// TODO(Gon): Eliminar modelo cuando se usen los del back
class Materia {
  Materia({
    required this.nombre,
    required this.id,
  });
  final String nombre;
  final int id;
}

class Rol {
  Rol({
    required this.nombre,
  });
  final String nombre;
}
