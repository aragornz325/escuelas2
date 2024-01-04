import 'package:escuelas_server/orm.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class OrmAsignatura extends ORM {
  /// La función `crearAsignatura` crea un nuevo objeto `Asignatura` en la base de datos usando la
  /// `Session` proporcionada y devuelve el objeto creado.
  /// 
  /// Args:
  ///   session (Session): El parámetro de sesión es de tipo Sesión y representa la sesión de la base de
  /// datos que se utilizará para ejecutar la operación de la base de datos.
  ///   asignatura (Asignatura): El parámetro "asignatura" es de tipo "Asignatura" y es obligatorio.
  /// 
  /// Returns:
  ///   a `Futuro<Asignatura>`.
  Future<Asignatura> crearAsignatura(
    Session session, {
    required Asignatura asignatura,
  }) async {
    final asignaturaDB = await ejecutarOperacionOrm(
      session,
      (session) => Asignatura.db.insert(
        session,
        [asignatura],
      ),
    );
    return asignaturaDB.first;
  }

  /// La función `actualizarAsignatura` actualiza un objeto `Asignatura` en la base de datos usando un
  /// ORM.
  /// 
  /// Args:
  ///   session (Session): El parámetro de sesión es de tipo Sesión. Se utiliza para establecer una
  /// conexión con la base de datos y realizar operaciones de base de datos dentro de la sesión.
  ///   asignatura (Asignatura): El parámetro "asignatura" es de tipo "Asignatura" y es obligatorio.
  /// 
  /// Returns:
  ///   a `Futuro<Asignatura>`.
  Future<Asignatura> actualizarAsignatura(
    Session session, {
    required Asignatura asignatura,
  }) async {
    final asignaturaDB = await ejecutarOperacionOrm(
      session,
      (session) => Asignatura.db.update(
        session,
        [asignatura],
      ),
    );
    return asignaturaDB.first;
  }

  /// La función `obtenerAsignaturaPorId` recupera un objeto `Asignatura` de una base de datos usando su
  /// ID y lanza una excepción si no se encuentra el objeto.
  /// 
  /// Args:
  ///   session (Session): Un objeto de sesión utilizado para operaciones de bases de datos.
  ///   id (int): El parámetro "id" es un número entero que representa el identificador único de la
  /// asignación.
  /// 
  /// Returns:
  ///   un objeto Future que se resuelve en una instancia de la clase Asignatura.
  Future<Asignatura> obtenerAsignaturaPorId(
    Session session, {
    required int id,
  }) async {
    final asignatura = await ejecutarOperacionOrm(
      session,
      (session) => Asignatura.db.findById(
        session,
        id,
      ),
    );
    if (asignatura == null) {
      throw Exception(
        'Asignatura no encontrada',
      );
    }
    return asignatura;
  }

  /// La función "obtenerAsignaturas" recupera una lista de objetos "Asignatura" de una base de datos
  /// usando un ORM y lanza una excepción si la lista está vacía.
  /// 
  /// Args:
  ///   session (Session): El parámetro de sesión es una instancia de la clase Session, que se utiliza
  /// para interactuar con la base de datos. Se pasa a la función obtenerAsignaturas para realizar
  /// operaciones en la base de datos.
  /// 
  /// Returns:
  ///   un `Futuro` que se resuelve en una `Lista` de objetos `Asignatura`.
  Future<List<Asignatura>> obtenerAsignaturas(
    Session session,
  ) async {
    final asignaturas = await ejecutarOperacionOrm(
      session,
      (session) => Asignatura.db.find(
        session,
      ),
    );
    if (asignaturas.isEmpty) {
      throw Exception(
        'No hay asignaturas',
      );
    }
    return asignaturas;
  }

  /// La función `eliminarAsignatura` elimina una asignación por su ID usando un ORM.
  /// 
  /// Args:
  ///   session (Session): El parámetro "sesión" es de tipo "Sesión" y es obligatorio. Representa la
  /// sesión o conexión actual a la base de datos.
  ///   id (int): El parámetro "id" es un número entero que representa el identificador único de la
  /// asignación que se va a eliminar.
  /// 
  /// Returns:
  ///   un `Futuro<int>`.
  Future<int> eliminarAsignatura(
    Session session, {
    required int id,
  }) async {
    final asignatura = await obtenerAsignaturaPorId(
      session,
      id: id,
    );
    final eliminado = await ejecutarOperacionOrm(
      session,
      (session) => Asignatura.db.delete(
        session,
        [asignatura],
      ),
    );
    return eliminado.first;
  }

  
}
