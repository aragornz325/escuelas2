part of 'bloc_perfil_usuario.dart';

/// {@template BlocPerfilUsuarioEvento}
/// Clase padre de los eventos de [BlocPerfilUsuario].
/// {@endtemplate}
abstract class BlocPerfilUsuarioEvento {
  /// {@macro BlocPerfilUsuarioEvento}
  const BlocPerfilUsuarioEvento();
}

/// {@template BlocPerfilUsuarioEventoTraerUsuario}
/// Trae todos los datos del usuario
/// {@endtemplate}
class BlocPerfilUsuarioEventoTraerUsuario extends BlocPerfilUsuarioEvento {
  /// {@macro BlocPerfilUsuarioEventoTraerUsuario}
  const BlocPerfilUsuarioEventoTraerUsuario({
    required this.idUsuario,
  });

  /// Id del usuario que se va a mostrar en ui
  final int? idUsuario;
}

/// {@template BlocPerfilUsuarioEventoTraerAsignaturasComisiones}
/// Trae las asignaturas de la institucion con sus comisiones
/// {@endtemplate}
class BlocPerfilUsuarioEventoTraerAsignaturasComisiones
    extends BlocPerfilUsuarioEvento {
  /// {@macro BlocPerfilUsuarioEventoTraerAsignaturasComisiones}
  const BlocPerfilUsuarioEventoTraerAsignaturasComisiones();
}

/// {@template BlocPerfilUsuarioEventoAgregarAsignatura}
/// Evento que realiza la accion de agregar asignatura a un docente
/// {@endtemplate}
class BlocPerfilUsuarioEventoAgregarAsignatura extends BlocPerfilUsuarioEvento {
  /// {@macro BlocPerfilUsuarioEventoAgregarAsignatura}
  const BlocPerfilUsuarioEventoAgregarAsignatura({
    required this.idUsuario,
    required this.idAsignaturaSeleccionada,
    required this.idComisionSeleccionada,
    this.asignatura,
    this.comision,
  });

  /// Id de la asignatura seleccionada
  final int idAsignaturaSeleccionada;

  /// Id de la comision seleccionada
  final int idComisionSeleccionada;

  final int idUsuario;

  final Asignatura? asignatura;

  final ComisionDeCurso? comision;
}

/// {@template BlocPerfilUsuarioEventoQuitarAsignatura}
/// Evento que realiza la accion de quitar asignatura de un docente
/// {@endtemplate}
class BlocPerfilUsuarioEventoQuitarAsignatura extends BlocPerfilUsuarioEvento {
  /// {@macro BlocPerfilUsuarioEventoQuitarAsignatura}
  const BlocPerfilUsuarioEventoQuitarAsignatura({
    required this.idUsuario,
    required this.idAsignatura,
    required this.idComision,
    this.asignatura,
    this.comision,
  });

  /// Id del docente al que se le quita la asignatura
  final int idUsuario;

  /// Id de la asignatura a quitar
  final int idAsignatura;

  /// Id de la comision de la asignatura a quitar
  final int idComision;

  final Asignatura? asignatura;

  final ComisionDeCurso? comision;
}

/// {@template BlocPerfilUsuarioEventoEliminarDocente}
/// Evento que realiza la accion de eliminar un docente de la institucion
/// {@endtemplate}
class BlocPerfilUsuarioEventoEliminarDocente extends BlocPerfilUsuarioEvento {
  /// {@macro BlocPerfilUsuarioEventoEliminarDocente}
  const BlocPerfilUsuarioEventoEliminarDocente({required this.idUsuario});

  /// id del usuario a eliminar
  final int idUsuario;
}
