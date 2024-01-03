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
  final Rol? rolElegido;

  /// Indica si se debe eliminar el rol seleccionado
  final bool eliminarRolSeleccionado;
}

/// {@template BlocKycEventoSeleccionarCursoYMateria}
/// Selecciona una materia o curso de una de las opciones
/// {@endtemplate}
class BlocKycEventoSeleccionarCursoYMateria extends BlocKycEvento {
  /// {@macro BlocKycEventoSeleccionarCursoYMateria}
  const BlocKycEventoSeleccionarCursoYMateria({
    required this.idOpcion,
    this.idCurso,
    this.idMateria,
  });

  /// Id de la opcion a la cual se le va a asignar el curso/materia
  final int idOpcion;

  /// Id del curso seleccionado
  final int? idCurso;

  /// Id de la materia seleccionada
  final int? idMateria;
}

/// {@template BlocKycEventoAgregarOpcion}
/// Agrega una nueva opcion de kyc para elegir una materia
/// {@endtemplate}
class BlocKycEventoAgregarOpcion extends BlocKycEvento {}

/// {@template BlocKycEventoEliminarOpcion}
/// Elimina una opcion del kyc
/// {@endtemplate}
class BlocKycEventoEliminarOpcion extends BlocKycEvento {
  /// {@macro BlocKycEventoizarOpcion}
  const BlocKycEventoEliminarOpcion({required this.idOpcion});
  final int idOpcion;
}
