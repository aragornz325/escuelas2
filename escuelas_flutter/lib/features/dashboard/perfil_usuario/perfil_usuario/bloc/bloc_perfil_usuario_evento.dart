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

/// {@template BlocPerfilUsuarioEventoRecolectarDatosKyC}
/// Evento que recolecta los datos KYC del usuario
/// {@endtemplate}
class BlocPerfilUsuarioEventoRecolectarDatosKyC
    extends BlocPerfilUsuarioEvento {
  BlocPerfilUsuarioEventoRecolectarDatosKyC({
    this.telefono,
    this.mail,
    this.factorSanguineo,
    this.edad,
    this.contactoEmergenciaNombre,
    this.contactoEmergenciaVinculo,
    this.contactoEmergenciaTelefono,
    this.contactoEmergenciaMail,
    this.observaciones,
  });

  /// telefono del usuario
  final String? telefono;

  /// mail del usuario
  final String? mail;

  /// grupo sanguineo del usuario
  final String? factorSanguineo;

  /// edad del usuario
  final String? edad;

  /// nombre del contacto de emergencia
  final String? contactoEmergenciaNombre;

  /// vinculo del contacto de emergencia
  final String? contactoEmergenciaVinculo;

  /// telefono del contacto de emergencia
  final String? contactoEmergenciaTelefono;

  /// mail del contacto de emergencia
  final String? contactoEmergenciaMail;

  /// observaciones
  final String? observaciones;
}

/// {@template BlocPerfilUsuarioEventoInsertarInformacionDeKyc}
/// Inserta los valores que se completaron en el formulario,
/// guardados dentro del estado dentro de la informacion
/// del usuario en la base de datos.
/// {@endtemplate}
class BlocPerfilUsuarioEventoInsertarInformacionDeKyc
    extends BlocPerfilUsuarioEvento {
  /// {@macro BlocPerfilUsuarioEventoInsertarInformacionDeKyc}
  BlocPerfilUsuarioEventoInsertarInformacionDeKyc();
}
