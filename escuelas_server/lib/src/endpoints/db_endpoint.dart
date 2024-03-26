// import 'package:escuelas_server/src/controller.dart';
// import 'package:escuelas_server/src/excepciones/excepcion_endpoint.dart';
// import 'package:escuelas_server/src/generated/protocol.dart';
// import 'package:serverpod/server.dart' as server;

// class DbEndpoint extends server.Endpoint with Controller {
//   Future<VersionDb> obtenerUltimaVersionDeDb(server.Session session) =>
//       ejecutarOperacionControlador(
//         session,
//         'obtenerUltimaVersionDeDb',
//         () async {
//           final versionDb = await VersionDb.db.findFirstRow(session);

//           if (versionDb == null) {
//             throw ExcepcionCustom.fromJson(errorDesconocido, Protocol());
//           }

//           return versionDb;
//         },
//       );
// }
