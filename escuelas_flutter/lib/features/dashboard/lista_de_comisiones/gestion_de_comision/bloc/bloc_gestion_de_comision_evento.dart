part of 'bloc_gestion_de_comision.dart';

/// {@template BlocGestionDeComisionEvento}
/// Maneja los eventos generales de la pantalla 'Gestion de comisiones'
/// {@endtemplate}
@immutable
class BlocGestionDeComisionEvento {
  /// {@macro BlocGestionDeComisionEvento}
  const BlocGestionDeComisionEvento();

  List<Object> get props => [];
}

/// {@template BlocGestionDeComisionEventoInicializar}
/// Evento para inicializar la pantalla de 'Gestion de comision'.
/// {@endtemplate}
class BlocGestionDeComisionEventoInicializar
    extends BlocGestionDeComisionEvento {
  /// {@macro BlocGestionDeComisionEventoInicializar}
  const BlocGestionDeComisionEventoInicializar();
}

/// {@template BlocGestionDeComisionEventoFiltrarPorNombre}
/// Evento que filtra por nombre.ya sea para un docente o para los alumnos
/// {@endtemplate}
class BlocGestionDeComisionEventoFiltrarPorNombre
    extends BlocGestionDeComisionEvento {
  /// {@macro BlocGestionDeComisionEventoFiltrarPorNombre}
  const BlocGestionDeComisionEventoFiltrarPorNombre({
    required this.idRol,
    this.nombre,
  });

  /// Id del rol a filtrar
  final int idRol;

  /// nombre con el que se va a filtrar
  final String? nombre;
}

/// {@template BlocGestionDeComisionEventoAsignarDocente}
/// Evento para asignar un docente a la asignatura.
/// {@endtemplate}
class BlocGestionDeComisionEventoAsignarDocente
    extends BlocGestionDeComisionEvento {
  /// {@macro BlocGestionDeComisionEventoAsignarDocente}
  const BlocGestionDeComisionEventoAsignarDocente({
    required this.docente,
  });

  /// Id del docente a asignar
  final Usuario? docente;
}

/// {@template BlocGestionDeComisionEventoAgregarAlumno}
/// Evento para agregar un alumno a la comision.
/// {@endtemplate}
class BlocGestionDeComisionEventoAgregarAlumno
    extends BlocGestionDeComisionEvento {
  /// {@macro BlocGestionDeComisionEventoAgregarAlumno}
  const BlocGestionDeComisionEventoAgregarAlumno({
    required this.alumno,
  });

  /// Alumno a asignar a esta comision
  final Usuario alumno;
}
