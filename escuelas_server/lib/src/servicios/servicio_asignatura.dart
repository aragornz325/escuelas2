import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_asignatura.dart';
import 'package:escuelas_server/src/orms/orm_asignatura_solicitada.dart';
import 'package:escuelas_server/src/orms/orm_asignatura_usuario.dart';
import 'package:escuelas_server/src/servicio.dart';
import 'package:serverpod/serverpod.dart';

class ServicioAsignatura extends Servicio<OrmAsignatura> {
  @override
  OrmAsignatura get orm => OrmAsignatura();

  final _ormUsuarioAsignatura = OrmRelacionAsignaturaUsuario();

  final _ormAsignaturaSolicitada = OrmAsignaturaSolicitada();

  /// La función `crearAsignatura` crea un nuevo objeto `Asignatura` en la base de datos usando la
  /// sesión proporcionada y devuelve el objeto creado.
  ///
  /// Args:
  ///   session (Session):
  ///   asignatura (Asignatura): El parámetro "asignatura" es de tipo `Asignatura` y es obligatorio.
  ///
  /// Returns:
  ///   a `Futuro<Asignatura>`.
  Future<Asignatura> crearAsignatura(
    Session session, {
    required Asignatura asignatura,
  }) async {
    final asignaturaDB = await ejecutarOperacion(
      () => orm.crearAsignatura(
        session,
        asignatura: asignatura,
      ),
    );
    return asignaturaDB;
  }

  /// La función `actualizarAsignatura` actualiza un objeto `Asignatura` en una base de datos usando un
  /// objeto `Session` proporcionado.
  ///
  /// Args:
  ///   session (Session):
  /// Returns:
  ///   a `Futuro<Asignatura>`.
  Future<Asignatura> actualizarAsignatura(
    Session session, {
    required Asignatura asignatura,
  }) async {
    final asignaturaDB = await ejecutarOperacion(
      () => orm.actualizarAsignatura(
        session,
        asignatura: asignatura,
      ),
    );
    return asignaturaDB;
  }

  /// La función `otenerAsignaturaPorId` recupera un objeto `Asignatura` por su ID usando una `Session`
  /// proporcionada y una operación ORM.
  ///
  /// Args:
  ///   session (Session):
  ///   id (int): El parámetro "id" es un número entero que representa el identificador único de una
  /// "Asignatura" (asunto).
  ///
  /// Returns:
  ///   a `Futuro<Asignatura>`.
  Future<Asignatura> obtenerAsignaturaPorId(
    Session session, {
    required int id,
  }) async {
    final asignatura = await ejecutarOperacion(
      () => orm.obtenerAsignaturaPorId(
        session,
        id: id,
      ),
    );
    return asignatura;
  }

  /// La función "obtenerAsignaturas" recupera una lista de sujetos utilizando una sesión y un ORM.
  ///
  /// Args:
  ///   session (Session):
  /// Returns:
  ///   un objeto `Futuro` que se resuelve en una `Lista` de objetos `Asignatura`.
  Future<List<Asignatura>> obtenerAsignaturas(
    Session session,
  ) async {
    final asignaturas = await ejecutarOperacion(
      () => orm.obtenerAsignaturas(
        session,
      ),
    );
    return asignaturas;
  }

  /// La función `eliminarAsignatura` es una función de Dart que elimina una tarea utilizando la sesión
  /// proporcionada y el ID de tarea.
  ///
  /// Args:
  ///   session (Session):
  ///   id (int): El parámetro "id" es un número entero que representa el identificador único de la
  /// asignatura que se va a eliminar.
  ///
  /// Returns:
  ///   un `Futuro<int>`.
  Future<int> eliminarAsignatura(
    Session session, {
    required int id,
  }) async {
    return await ejecutarOperacion(
      () => orm.eliminarAsignatura(
        session,
        id: id,
      ),
    );
  }

  Future<void> asignarUsuarioAAsignaturas(
    Session session, {
    required List<Asignatura> asignaturas,
    required int usuarioId,
  }) async {
    final idAsignaturas = asignaturas.map((asignatura) {
      final id = asignatura.id;

      if (id == null) {
        throw Exception('La asignatura no tiene id');
      }

      return id;
    }).toList();

    await ejecutarOperacion(
      () => _ormUsuarioAsignatura.crearRelacionUsuarioAAsignaturas(
        session,
        idAsignaturas: idAsignaturas,
        usuarioId: usuarioId,
      ),
    );
  }

  Future<List<AsignaturaSolicitada>> crearAsignaturasSolicitadas(
    Session session, {
    required List<AsignaturaSolicitada> asignaturasSolicitadas,
  }) async =>
      ejecutarOperacion(
        () => _ormAsignaturaSolicitada.crearAsignaturasSolicitadas(
          session,
          asignaturasSolicitadas: asignaturasSolicitadas,
        ),
      );

  Future<List<AsignaturaSolicitada>>
      obtenerAsignaturasSolicitadasPorIdUsuarioPendiente(
    Session session, {
    required int idUsuarioPendiente,
  }) async {
    return await ejecutarOperacion(
      () => _ormAsignaturaSolicitada
          .obtenerAsignaturasSolicitadasPorIdUsuarioPendiente(
        session,
        idUsuarioPendiente: idUsuarioPendiente,
      ),
    );
  }

  Future<void> asignarAsignaturasSolicitadas(
    Session session, {
    required List<AsignaturaSolicitada> asignaturasSolicitadas,
    required int usuarioId,
  }) async {
    final idAsignaturas =
        asignaturasSolicitadas.map((e) => e.asignaturaId).toList();

    await ejecutarOperacion(
      () => _ormUsuarioAsignatura.crearRelacionUsuarioAAsignaturas(
        session,
        idAsignaturas: idAsignaturas,
        usuarioId: usuarioId,
      ),
    );
  }
}
