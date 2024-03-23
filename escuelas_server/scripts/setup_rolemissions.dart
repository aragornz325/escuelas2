import 'dart:io';

import 'package:escuelas_commons/escuelas_commons.dart';
import 'package:rolemissions/rolemissions.dart';

void main() async {
  // ! TODO(anyone): remover las credenciales de la base de datos
  final rolemission = Rolemissions(
    persistanceDelegate: PostgresStrategy(
      host: 'aws-0-sa-east-1.pooler.supabase.com',
      databaseName: 'postgres',
      userName: 'postgres.mvdsvzvejhmrnxgdfdwz',
      dbPassword: 'L86Grm9pso3LyUdA',
      port: 5432,
    ),
  );

  await rolemission.initialFixture(
    userTable: 'usuarios',
  );

  exit(0);
}

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