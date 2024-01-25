import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orm.dart';
import 'package:serverpod/serverpod.dart';

class OrmComision extends ORM {
  Future<List<ComisionDeCurso>> obtenerComisiones(
    Session session,
  ) async =>
      ejecutarOperacionOrm(
        session,
        (session) => ComisionDeCurso.db.find(
          session,
          include: ComisionDeCurso.include(
            curso: Curso.include(),
            estudiantes: RelacionComisionUsuario.includeList(
              include: RelacionComisionUsuario.include(
                usuario: Usuario.include(),
              ),
            ),
          ),
        ),
      );

  Future<List<ComisionDeCurso>> obtenerComisionesDeCursoPorId(
    Session session, {
    required int idCurso,
  }) async =>
      ejecutarOperacionOrm(
        session,
        (session) => ComisionDeCurso.db.find(
          session,
          where: (comision) => comision.curso.id.equals(idCurso),
          include: ComisionDeCurso.include(
            curso: Curso.include(),
            estudiantes: RelacionComisionUsuario.includeList(
              include: RelacionComisionUsuario.include(
                usuario: Usuario.include(),
              ),
            ),
          ),
        ),
      );
}
