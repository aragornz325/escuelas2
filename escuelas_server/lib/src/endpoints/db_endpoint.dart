import 'package:escuelas_server/src/controller.dart';
import 'package:escuelas_server/src/excepciones/excepcion_endpoint.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class DbEndpoint extends Endpoint with Controller {
  Future<VersionDb> obtenerUltimaVersionDeDb(Session session) async =>
      await ejecutarOperacionControlador(
        session,
        'obtenerUltimaVersionDeDb',
        () async {
          final versionDb = await VersionDb.db.findFirstRow(session);
          if (versionDb == null) {
            throw ExcepcionCustom.fromJson(errorDesconocido, Protocol());
          }

          return versionDb;
        },
      );
}
