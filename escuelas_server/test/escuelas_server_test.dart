import 'package:escuelas_commons/escuelas_commons.dart';
import 'package:escuelas_server/src/endpoints/calificacion_endpoint.dart';
import 'package:escuelas_server/src/endpoints/rol_endpoint.dart';
import 'package:escuelas_server/src/endpoints/solicitud_endpoint.dart';
import 'package:escuelas_server/src/endpoints/usuario_endpoint.dart';
import 'package:escuelas_server/src/generated/protocol.dart';
import 'package:escuelas_server/src/orms/orm_calificacion.dart';
import 'package:escuelas_server/src/orms/orm_comision.dart';
import 'package:escuelas_server/src/orms/orm_direccionesDeEmail.dart';
import 'package:escuelas_server/src/orms/orm_usuario.dart';
import 'package:escuelas_server/src/servicios/servicio_rol.dart';
import 'package:escuelas_server/src/servicios/servicio_solicitud_nota_mensual.dart';
import 'package:escuelas_server/src/servicios/servicio_usuario.dart';
import 'package:rolemissions/rolemissions.dart';
import 'package:serverpod_auth_server/module.dart';
import 'package:test/test.dart';

import 'server_test.dart';

Future<void> main() async {
  final ahora = DateTime.now();

  await runServerTesting([]);

  final session = await podTesting.createSession();

  final authKey = await session.auth.signInUser(11, 'email');

  final permisosDirectivo = [
    PermisoDeAsignatura.values,
    PermisoDeAsistencia.values,
    PermisoDeCalificacion.values,
    PermisoDeComision.values,
    PermisoDeCurso.values,
    PermisoDeRol.values,
    PermisoDeSolicitud.values,
    PermisoDeUsuario.values,
  ];

  final permisosDocente = [
    [
      PermisoDeAsignatura.verAsignatura,
    ],
    [PermisoDeAsistencia.crearAsistencia, PermisoDeAsistencia.verAsistencia],
    [
      PermisoDeCalificacion.crearCalificacion,
      PermisoDeCalificacion.verCalificacion,
    ],
    [
      PermisoDeComision.verComision,
    ],
    [
      PermisoDeCurso.verCurso,
    ],
    [
      PermisoDeRol.verRol,
    ],
    [
      PermisoDeSolicitud.verSolicitud,
    ],
    [
      PermisoDeUsuario.verUsuario,
    ],
  ];

  final permisosEstudiante = [
    [
      PermisoDeAsignatura.verAsignatura,
    ],
    [PermisoDeAsistencia.verAsistencia],
    [
      PermisoDeCalificacion.verCalificacion,
    ],
    [
      PermisoDeComision.verComision,
    ],
    [
      PermisoDeCurso.verCurso,
    ],
    [
      PermisoDeRol.verRol,
    ],
    [
      PermisoDeSolicitud.verSolicitud,
    ],
    [
      PermisoDeUsuario.verUsuario,
    ],
  ];

  await RolEndpoint().crearRol(session,
      name: 'directivo',
      permisos: Permisos.fromEnumList(permisosDirectivo).toSerialization(),);
}
