part of 'bloc_kyc.dart';

/// {@template BlocKycEvento}
/// Clase padre de los eventos de 'Kyc'
/// {@endtemplate}
abstract class BlocKycEvento {
  /// {@macro BlocKycEvento}
  const BlocKycEvento();
}

/// {@template BlocKycEventoInicializar}
/// Inicializa la pagina, es decir, trae todos los cursos/materias necesarios para que el usuario pueda elegir
/// {@endtemplate}
class BlocKycEventoInicializar extends BlocKycEvento {
  /// {@macro BlocKycEventoInicializar}
  const BlocKycEventoInicializar();
}

/// {@template BlocKycEventoSeleccionarRol}
/// Selecciona uno de los roles en la pantalla de seleccion de roles
/// {@endtemplate}
class BlocKycEventoSeleccionarRol extends BlocKycEvento {
  /// {@macro BlocKycEventoSeleccionarRol}
  const BlocKycEventoSeleccionarRol({
    required this.eliminarRolSeleccionado,
    required this.rolElegido,
  });

  /// Rol elegido por el usuario en la pantalla de seleccion de rol
  final Role? rolElegido;

  /// Indica si se debe eliminar el rol seleccionado
  final bool eliminarRolSeleccionado;
}

/// {@template BlocKycEventoAgregarOpcionDocente}
/// Agrega una nueva opcion de kyc para elegir una asignatura
/// {@endtemplate}
class BlocKycEventoAgregarOpcionDocente extends BlocKycEvento {
  /// {@macro BlocKycEventoAgregarOpcionDocente}
  const BlocKycEventoAgregarOpcionDocente({
    required this.idAsignaturaSeleccionada,
    required this.idComisionSeleccionada,
  });

  /// Id de la asignatura seleccionada

  final int idAsignaturaSeleccionada;

  /// Id de la comision seleccionada
  final int idComisionSeleccionada;
}

/// {@template BlocKycEventoAgregarOpcionAlumno}
/// Agrega una nueva opcion de kyc para elegir una comision
/// {@endtemplate}
class BlocKycEventoAgregarOpcionAlumno extends BlocKycEvento {
  /// {@macro BlocKycEventoAgregarOpcionAlumno}
  const BlocKycEventoAgregarOpcionAlumno({
    required this.idComisionSeleccionada,
  });

  /// Id de la comision seleccionada
  final int idComisionSeleccionada;
}

/// {@template BlocKycEventoEliminarOpcion}
/// Elimina una opcion del kyc
/// {@endtemplate}
class BlocKycEventoEliminarOpcion extends BlocKycEvento {
  /// {@macro BlocKycEventoizarOpcion}
  const BlocKycEventoEliminarOpcion({required this.idOpcion});

  /// Id de la opcion a eliminar
  final int idOpcion;
}

/// {@template BlocKycEventoCerrarSesion}
/// Cierra sesion del usuario.
/// {@endtemplate}
class BlocKycEventoCerrarSesion extends BlocKycEvento {}

/// {@template BlocKycEventoSolicitarRol}
/// Envia una solicitacion de rol
/// {@endtemplate}
class BlocKycEventoSolicitarRegistro extends BlocKycEvento {
  /// {@macro BlocKycEventoSolicitarRol}
  const BlocKycEventoSolicitarRegistro({required this.userInfo});

  /// Informacion del usuario
  final auth.UserInfo? userInfo;
}
