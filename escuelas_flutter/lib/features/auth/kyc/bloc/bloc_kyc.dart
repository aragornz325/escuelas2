import 'package:escuelas_flutter/extensiones/extension_bloc.dart';
import 'package:escuelas_flutter/features/modelos_temporales.dart';
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
    on<BlocKycEventoInicializar>(_inicializar);
    on<BlocKycEventoSeleccionarCursoYMateria>(_seleccionarCursoYMateria);
    on<BlocKycEventoAgregarOpcion>(_agregarOpcion);
    on<BlocKycEventoEliminarOpcion>(_eliminarOpcion);
    on<BlocKycEventoSeleccionarRol>(_seleccionarRol);

    add(const BlocKycEventoInicializar());
  }

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
        // final roles = await client.;
        final roles = [
          Rol(nombre: 'ALUMNO', permisos: ['permiso1', 'permiso2'], id: 0),
          Rol(nombre: 'DOCENTE', permisos: ['permiso1', 'permiso2'], id: 1),
        ];
        final cursos = [
          Curso(nombre: 'PRIMERO', id: 0),
          Curso(nombre: 'SEGUNDO', id: 1),
          Curso(nombre: 'TERCERO', id: 2),
          Curso(nombre: 'CUARTO', id: 3),
        ];
        final materias = [
          Materia(nombre: 'MATEMATICA', id: 0, idCurso: 0),
          Materia(nombre: 'LENGUA', id: 1, idCurso: 0),
          Materia(nombre: 'SOCIALES', id: 2, idCurso: 0),
          Materia(nombre: 'NATURALES', id: 3, idCurso: 0),
        ];
        emit(
          BlocKycEstadoExitoso.desde(
            state,
            listaCursos: cursos,
            listaMaterias: materias,
            listaRoles: roles,
            opcionesFormulario: [
              // TODO(Gon): Ver manera de cambiar esto
              OpcionFormulario(
                id: 0,
                curso: Curso(nombre: '', id: 0),
                materia: Materia(nombre: '', id: 0, idCurso: 0),
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
      opcionAModificar.materia = state.listaMaterias
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
                id: 0,
              ),
              materia: Materia(nombre: '', id: 0, idCurso: 0),
            ),
          );
    emit(
      BlocKycEstadoExitoso.desde(
        state,
        opcionesFormulario: nuevaListaOpciones,
      ),
    );
  }

  /// Agrega una nueva opcion a la lista de kyc
  void _eliminarOpcion(
    BlocKycEventoEliminarOpcion event,
    Emitter<BlocKycEstado> emit,
  ) {
    final nuevaListaOpciones =
        List<OpcionFormulario>.from(state.opcionesFormulario)
          ..remove(state.opcionesFormulario
              .where((element) => element.id == event.idOpcion)
              .first);

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
