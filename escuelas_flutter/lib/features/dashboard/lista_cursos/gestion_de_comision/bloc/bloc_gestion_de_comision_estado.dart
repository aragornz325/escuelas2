// ignore_for_file: overridden_fields

part of 'bloc_gestion_de_comision.dart';

/// {@template BlocGestionDeComisionEstado}
/// Maneja los estados y variables generales de la pantalla
/// 'Gestion de comisiones'
/// {@endtemplate}
class BlocGestionDeComisionEstado {
  /// {@macro BlocGestionDeComisionEstado}
  const BlocGestionDeComisionEstado._({
    required this.idAsignatura,
    required this.idComision,
    this.usuarios = const [],
    this.listaAlumnos,
    this.asignatura,
    this.comision,
  });
  BlocGestionDeComisionEstado.desde(
    BlocGestionDeComisionEstado otro, {
    UsuariosOrdenados? listaAlumnos,
    ComisionDeCurso? comision,
    List<Usuario>? usuarios,
    Asignatura? asignatura,
    int? idAsignatura,
    int? idComision,
  }) : this._(
          listaAlumnos: listaAlumnos ?? otro.listaAlumnos,
          idAsignatura: idAsignatura ?? otro.idAsignatura,
          idComision: idComision ?? otro.idComision,
          asignatura: asignatura ?? otro.asignatura,
          usuarios: usuarios ?? otro.usuarios,
          comision: comision ?? otro.comision,
        );

  /// Id de la asignatura
  final int idAsignatura;

  /// Id de la comision a obtener
  final int idComision;

  /// Lista de alumnos de la comision.
  final UsuariosOrdenados? listaAlumnos;

  /// Lista de alumnos de la comision.
  final List<Usuario> usuarios;

  /// Comision actual.
  final ComisionDeCurso? comision;

  /// Asignatura actual.
  final Asignatura? asignatura;

  /// Estado en caso de que se asigne un docente correctamente.
  bool get exitoAlAsignarDocente =>
      this is BlocGestionDeComisionEstadoExitosoAlAsignarDocente;

  /// Estado en caso de que se agregue un nuevo alumno correctamente.
  bool get exitoAlAgregarAlumnoAComision =>
      this is BlocGestionDeComisionEstadoExitosoAlAgregarAlumnoAComision;

  List<Object?> get props => [
        listaAlumnos,
        usuarios,
        asignatura,
        idAsignatura,
        idComision,
      ];
}

/// {@template BlocGestionDeComisionEstadoInicial}
/// Estado `inicial` de los componentes de la pantalla 'Gestion de comision'
/// {@endtemplate}
class BlocGestionDeComisionEstadoInicial extends BlocGestionDeComisionEstado {
  /// {@macro BlocGestionDeComisionEstadoInicial}
  const BlocGestionDeComisionEstadoInicial({
    required super.idAsignatura,
    required super.idComision,
  }) : super._();
}

/// {@template BlocGestionDeComisionEstadoCargando}
/// Estado `cargando` de los componentes en la pantalla de
/// 'Gestion de comision'
/// {@endtemplate}
class BlocGestionDeComisionEstadoCargando extends BlocGestionDeComisionEstado {
  /// {@macro BlocGestionDeComisionEstadoCargando}
  BlocGestionDeComisionEstadoCargando.desde(super.otro) : super.desde();
}

/// {@template BlocGestionDeComisionEstadoExitoso}
/// Estado `exitoso` general de los componentes de la pantalla
/// 'Gestion de comision'
/// {@endtemplate}
class BlocGestionDeComisionEstadoExitoso extends BlocGestionDeComisionEstado {
  /// {@macro BlocGestionDeComisionEstadoExitoso}
  BlocGestionDeComisionEstadoExitoso.desde(
    super.otro, {
    super.listaAlumnos,
    super.asignatura,
    super.usuarios,
    super.comision,
  }) : super.desde();
}

/// {@template BlocGestionDeComisionEstadoFallido}
/// Estado de `error general` de los componentes de la pantalla
/// 'Gestion de comision'
/// {@endtemplate}
class BlocGestionDeComisionEstadoFallido extends BlocGestionDeComisionEstado {
  /// {@macro BlocGestionDeComisionEstadoFallido}
  BlocGestionDeComisionEstadoFallido.desde(super.otro) : super.desde();
}

/// {@template BlocGestionDeComisionEstadoExitosoAlAsignarDocente}
/// Estado `exitoso` al asignar docente a la asignatura mostrara un popup/alert
/// dialog.
/// {@endtemplate}
class BlocGestionDeComisionEstadoExitosoAlAsignarDocente
    extends BlocGestionDeComisionEstado {
  /// {@macro BlocGestionDeComisionEstadoExitosoAlAsignarDocente}
  BlocGestionDeComisionEstadoExitosoAlAsignarDocente.desde(
    super.otro, {
    super.asignatura,
  }) : super.desde();
}

/// {@template BlocGestionDeComisionEstadoExitosoAlAgregarAlumnoAComision}
/// Estado `exitoso` al agregar un nuevo alumno a esa comision mostrara un
/// popup/alert dialog.
/// {@endtemplate}
class BlocGestionDeComisionEstadoExitosoAlAgregarAlumnoAComision
    extends BlocGestionDeComisionEstado {
  /// {@macro BlocGestionDeComisionEstadoExitosoAlAgregarAlumnoAComision}
  BlocGestionDeComisionEstadoExitosoAlAgregarAlumnoAComision.desde(
    super.otro, {
    super.listaAlumnos,
  }) : super.desde();
}
