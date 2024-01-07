import 'package:escuelas_client/escuelas_client.dart';
import 'package:escuelas_flutter/extensiones/bloc.dart';
import 'package:escuelas_flutter/widgets/escuelas_dropdown_popup.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

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
        final rolesAMostrar = roles
            .where((rol) => rol.nombre == 'Mati' || rol.nombre == 'Chepibe')
            .toList();
        emit(
          BlocKycEstadoExitoso.desde(
            state,
            listaAsignaturas: asignaturas,
            listaCursos: [],
            listaRoles: rolesAMostrar,
            opcionesFormulario: [
              // TODO(Gon): Ver manera de cambiar esto
              OpcionFormulario(
                id: 0,
                curso: Curso(
                  nombre: '',
                  asignaturas: [],
                  ultimaModificacion: DateTime.now(),
                  fechaCreacion: DateTime.now(),
                ),
                materia: Asignatura(
                  nombre: '',
                  idCurso: 0,
                  docentes: [],
                  ultimaModificacion: DateTime.now(),
                  fechaCreacion: DateTime.now(),
                ),
              ),
            ],
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
    final nuevaListaOpciones =
        List<OpcionFormulario>.from(state.opcionesFormulario);

    final opcionAModificar = nuevaListaOpciones
        .firstWhere((opcionKyc) => opcionKyc.id == event.idOpcion);

    if (event.idCurso != null) {
      opcionAModificar.curso =
          state.listaCursos.firstWhere((curso) => curso.id == event.idCurso);
    }

    if (event.idMateria != null) {
      opcionAModificar.materia = state.listaAsignaturas
          .firstWhere((materia) => materia.id == event.idMateria);
    }

    emit(
      BlocKycEstadoExitoso.desde(
        state,
        opcionesFormulario: nuevaListaOpciones,
      ),
    );
  }

  /// Agrega una nueva opcion a la lista de kyc
  void _agregarOpcion(
    BlocKycEventoAgregarOpcion event,
    Emitter<BlocKycEstado> emit,
  ) {
    final nuevaListaOpciones =
        List<OpcionFormulario>.from(state.opcionesFormulario)
          ..add(
            OpcionFormulario(
              id: state.opcionesFormulario.length + 1,
              curso: Curso(
                nombre: '',
                asignaturas: [],
                ultimaModificacion: DateTime.now(),
                fechaCreacion: DateTime.now(),
              ),
              materia: Asignatura(
                nombre: '',
                idCurso: 0,
                docentes: [],
                ultimaModificacion: DateTime.now(),
                fechaCreacion: DateTime.now(),
              ),
            ),
          );
    emit(
      BlocKycEstadoExitoso.desde(
        state,
        opcionesFormulario: nuevaListaOpciones,
      ),
    );
  }

// TODO(Gon): Al eliminar no se actualizan los dropdowns
  /// Elimina una opcion de la lista de kyc
  void _eliminarOpcion(
    BlocKycEventoEliminarOpcion event,
    Emitter<BlocKycEstado> emit,
  ) {
    final nuevaListaOpciones =
        List<OpcionFormulario>.from(state.opcionesFormulario)
          ..remove(
            state.opcionesFormulario
                .where((element) => element.id == event.idOpcion)
                .first,
          );

    emit(
      BlocKycEstadoExitoso.desde(
        state,
        opcionesFormulario: nuevaListaOpciones,
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
    required this.curso,
    required this.materia,
    required this.id,
  });

  factory OpcionFormulario.fromJson(Map<String, dynamic> json) {
    return OpcionFormulario(
      curso: Curso.fromJson(
        json['curso'] as Map<String, dynamic>,
        Protocol(),
      ),
      materia: Asignatura.fromJson(
        json['asignatura'] as Map<String, dynamic>,
        Protocol(),
      ),
      id: json['id'] as int,
    );
  }

  Curso curso;
  Asignatura materia;
  final int id;

  Map<String, dynamic> toJson() {
    return {
      'curso': curso,
      'materia': materia,
      'id': id,
    };
  }
}
