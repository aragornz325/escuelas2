import 'dart:io';

import 'package:escuelas_commons/escuelas_commons.dart';
import 'package:escuelas_server/src/endpoints/rol_endpoint.dart';
import 'package:escuelas_server/server.dart';

Future<void> main(List<String> args) async {
  final runMode = 'development';

  final permisosEstudiante = [
    <Enum>[
      PermisoDeAsignatura.verAsignatura,
    ],
    <Enum>[
      PermisoDeAsistencia.verAsistencia,
    ],
    <Enum>[
      PermisoDeCalificacion.verCalificacion,
    ],
    <Enum>[
      PermisoDeComision.verComision,
    ],
    <Enum>[
      PermisoDeCurso.verCurso,
    ],
    <Enum>[
      PermisoDeRol.verRol,
    ],
    <Enum>[
      PermisoDeSolicitud.verSolicitud,
    ],
    <Enum>[
      PermisoDeUsuario.verUsuario,
    ],
  ];

  final permisosDocente = [
    <Enum>[
      PermisoDeAsignatura.verAsignatura,
    ],
    <Enum>[
      PermisoDeAsistencia.crearAsistencia,
      PermisoDeAsistencia.verAsistencia,
    ],
    <Enum>[
      PermisoDeCalificacion.crearCalificacion,
      PermisoDeCalificacion.verCalificacion,
    ],
    <Enum>[
      PermisoDeComision.verComision,
    ],
    <Enum>[
      PermisoDeCurso.verCurso,
    ],
    <Enum>[
      PermisoDeRol.verRol,
    ],
    <Enum>[
      PermisoDeSolicitud.verSolicitud,
    ],
    <Enum>[
      PermisoDeUsuario.verUsuario,
    ],
  ];

  final permisosDirectivo = [
    <Enum>[
      PermisoDeAsignatura.asignarDocenteAAsignatura,
      PermisoDeAsignatura.crearAsignatura,
      PermisoDeAsignatura.editarAsignatura,
      PermisoDeAsignatura.eliminarAsignatura,
      PermisoDeAsignatura.verAsignatura,
    ],
    <Enum>[
      PermisoDeAsistencia.crearAsistencia,
      PermisoDeAsistencia.editarAsistencia,
      PermisoDeAsistencia.eliminarAsistencia,
      PermisoDeAsistencia.verAsistencia,
    ],
    <Enum>[
      PermisoDeCalificacion.crearCalificacion,
      PermisoDeCalificacion.editarCalificacion,
      PermisoDeCalificacion.eliminarCalificacion,
      PermisoDeCalificacion.verCalificacion,
    ],
    <Enum>[
      PermisoDeComision.asignarAlumnosAComision,
      PermisoDeComision.crearComision,
      PermisoDeComision.editarComision,
      PermisoDeComision.eliminarComision,
      PermisoDeComision.verComision,
    ],
    <Enum>[
      PermisoDeCurso.crearCurso,
      PermisoDeCurso.editarCurso,
      PermisoDeCurso.eliminarCurso,
      PermisoDeCurso.verCurso,
    ],
    <Enum>[
      PermisoDeRol.crearRol,
      PermisoDeRol.editarRol,
      PermisoDeRol.eliminarRol,
      PermisoDeRol.verRol,
    ],
    <Enum>[
      PermisoDeSolicitud.crearSolicitud,
      PermisoDeSolicitud.editarSolicitud,
      PermisoDeSolicitud.eliminarSolicitud,
      PermisoDeSolicitud.verSolicitud,
    ],
    <Enum>[
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

  await run(['--mode', runMode]);

  final session = await pod.createSession();

  for (var rol in roles.keys) {
    await RolEndpoint().crearRol(
      session,
      name: rol,
      permisos: Permisos.fromEnumList(roles[rol]!).toSerialization(),
    );
  }

  exit(0);
}
