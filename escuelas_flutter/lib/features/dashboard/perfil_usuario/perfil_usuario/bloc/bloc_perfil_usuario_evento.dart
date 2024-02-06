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

/// {@template BlocPerfilUsuarioEventoEditarDocente}
/// Evento que realiza la accion de editar los datos de un docente
/// {@endtemplate}
class BlocPerfilUsuarioEventoEditarDocente extends BlocPerfilUsuarioEvento {
    /// {@macro BlocPerfilUsuarioEventoEditarDocente}
const BlocPerfilUsuarioEventoEditarDocente();
}

/// {@template BlocPerfilUsuarioEventoAgregarAsignatura}
/// Evento que realiza la accion de agregar asignatura a un docente
/// {@endtemplate}
class BlocPerfilUsuarioEventoAgregarAsignatura extends BlocPerfilUsuarioEvento {
  /// {@macro BlocPerfilUsuarioEventoAgregarAsignatura}
const BlocPerfilUsuarioEventoAgregarAsignatura();
}

/// {@template BlocPerfilUsuarioEventoQuitarAsignatura}
/// Evento que realiza la accion de quitar asignatura de un docente
/// {@endtemplate}
class BlocPerfilUsuarioEventoQuitarAsignatura extends BlocPerfilUsuarioEvento {
  /// {@macro BlocPerfilUsuarioEventoQuitarAsignatura}
   const BlocPerfilUsuarioEventoQuitarAsignatura();
}

/// {@template BlocPerfilUsuarioEventoEliminarDocente}
/// Evento que realiza la accion de eliminar un docente de la institucion
/// {@endtemplate}
class BlocPerfilUsuarioEventoEliminarDocente extends BlocPerfilUsuarioEvento {
  /// {@macro BlocPerfilUsuarioEventoEliminarDocente}
  const BlocPerfilUsuarioEventoEliminarDocente();
}
