
import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class DbEndpoint extends Endpoint with Controller {
  Future<VersionDb> obtenerUltimaVersionDeDb(Session session) =>
      ejecutarOperacionControlador(
        session,
        'obtenerUltimaVersionDeDb',
        () async {
          final versionDb = await VersionDb.db.findFirstRow(session);

          if (versionDb == null) {
            throw ExcepcionCustom(tipoDeError: TipoExcepcion.desconocido);
          }

          return versionDb;
        },
      );
}
