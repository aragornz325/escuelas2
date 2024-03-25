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
    [
      PermisoDeAsignatura.asignarDocenteAAsignatura,
      PermisoDeAsignatura.crearAsignatura,
      PermisoDeAsignatura.editarAsignatura,
      PermisoDeAsignatura.eliminarAsignatura,
      PermisoDeAsignatura.verAsignatura,
    ],
    [
      PermisoDeAsistencia.crearAsistencia,
      PermisoDeAsistencia.editarAsistencia,
      PermisoDeAsistencia.eliminarAsistencia,
      PermisoDeAsistencia.verAsistencia,
    ],
    [
      PermisoDeCalificacion.crearCalificacion,
      PermisoDeCalificacion.editarCalificacion,
      PermisoDeCalificacion.eliminarCalificacion,
      PermisoDeCalificacion.verCalificacion,
    ],
    [
      PermisoDeComision.asignarAlumnosAComision,
      PermisoDeComision.crearComision,
      PermisoDeComision.editarComision,
      PermisoDeComision.eliminarComision,
      PermisoDeComision.verComision,
    ],
    [
      PermisoDeCurso.crearCurso,
      PermisoDeCurso.editarCurso,
      PermisoDeCurso.eliminarCurso,
      PermisoDeCurso.verCurso,
    ],
    [
      PermisoDeRol.crearRol,
      PermisoDeRol.editarRol,
      PermisoDeRol.eliminarRol,
      PermisoDeRol.verRol,
    ],
    [
      PermisoDeSolicitud.crearSolicitud,
      PermisoDeSolicitud.editarSolicitud,
      PermisoDeSolicitud.eliminarSolicitud,
      PermisoDeSolicitud.verSolicitud,
    ],
    [
      PermisoDeUsuario.crearUsuario,
      PermisoDeUsuario.editarUsuario,
      PermisoDeUsuario.eliminarUsuario,
      PermisoDeUsuario.responderSolicitudDeRegistro,
      PermisoDeUsuario.verUsuario,
    ],
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
