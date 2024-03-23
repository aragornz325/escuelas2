import 'package:escuelas_commons/escuelas_commons.dart';
import 'package:escuelas_server/src/endpoints/rol_endpoint.dart';

import '../test/server_test.dart';

Future<void> main(List<String> args) async {
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

  final roles = {
    'estudiante': permisosEstudiante,
    'docente': permisosDocente,
    'directivo': permisosDirectivo,
  };

  await runServerTesting([]);

  final session = await podTesting.createSession();

  for (var rol in roles.keys) {
    await RolEndpoint().crearRol(
      session,
      name: rol,
      permisos: Permisos.fromEnumList(roles[rol]!).toSerialization(),
    );
  }
}
